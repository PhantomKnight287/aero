// Design-rules ratchet (see app/DESIGN.md).
//
// Scans lib/ (except lib/ui/ and generated *.g.dart) for banned patterns and
// compares per-file counts against test/design_baseline.json:
//   - count above baseline (or a new file with violations) -> fail
//   - count below baseline -> fail until the baseline is regenerated, so
//     cleanup progress is locked in
// Regenerate after migrating code:
//   UPDATE_DESIGN_BASELINE=1 flutter test test/design_rules_test.dart
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

final rules = <String, RegExp>{
  'alert_dialog': RegExp(r'\bAlertDialog\b'),
  'show_dialog': RegExp(r'\bshowDialog\b'),
  'snackbar': RegExp(r'\bSnackBar\('),
  'material_color': RegExp(r'\bColors\.(?!transparent\b)\w+'),
  'hex_color': RegExp(r'\bColor\(0x'),
  'raw_radius': RegExp(r'Radius\.circular\(\s*[\d.]+'),
  'raw_font_size': RegExp(r'fontSize:\s*[\d.]+'),
  'ease_in': RegExp(r'Curves\.easeIn\b'),
};

const baselinePath = 'test/design_baseline.json';

/// file -> rule -> count, only non-zero entries.
Map<String, Map<String, int>> scanSource(Map<String, String> files) {
  final result = <String, Map<String, int>>{};
  files.forEach((path, source) {
    final counts = <String, int>{};
    for (final line in const LineSplitter().convert(source)) {
      if (line.trimLeft().startsWith('//')) continue;
      rules.forEach((rule, re) {
        final n = re.allMatches(line).length;
        if (n > 0) counts[rule] = (counts[rule] ?? 0) + n;
      });
    }
    if (counts.isNotEmpty) result[path] = counts;
  });
  return result;
}

Map<String, String> readLib() {
  final files = <String, String>{};
  for (final f in Directory('lib').listSync(recursive: true)) {
    if (f is! File || !f.path.endsWith('.dart')) continue;
    final path = f.path.replaceAll(r'\', '/');
    if (path.startsWith('lib/ui/') || path.endsWith('.g.dart')) continue;
    files[path] = f.readAsStringSync();
  }
  return files;
}

/// Human-readable differences between [actual] and [baseline].
List<String> compare(
  Map<String, Map<String, int>> actual,
  Map<String, Map<String, int>> baseline,
) {
  final problems = <String>[];
  final paths = {...actual.keys, ...baseline.keys}.toList()..sort();
  for (final path in paths) {
    for (final rule in rules.keys) {
      final now = actual[path]?[rule] ?? 0;
      final allowed = baseline[path]?[rule] ?? 0;
      if (now > allowed) {
        problems.add('$path: $rule $now (allowed $allowed) — use lib/ui '
            'tokens/components instead');
      } else if (now < allowed) {
        problems.add('$path: $rule dropped to $now (baseline $allowed) — '
            'regenerate the baseline to lock it in');
      }
    }
  }
  return problems;
}

void main() {
  test('scanSource counts banned patterns and skips comments', () {
    final result = scanSource({
      'lib/a.dart': '''
// AlertDialog in a comment is fine
showDialog(builder: (_) => AlertDialog());
Container(color: Colors.red, decoration: BoxDecoration(color: Colors.transparent));
BorderRadius.circular(10); Radius.circular(AeroRadius.md);
TextStyle(fontSize: 12); TextStyle(fontSize: AeroText.size);
const c = Color(0xff000000);
''',
      'lib/clean.dart': 'Text("hi", style: AeroText.body);',
    });
    expect(result, {
      'lib/a.dart': {
        'show_dialog': 1,
        'alert_dialog': 1,
        'material_color': 1,
        'raw_radius': 1,
        'raw_font_size': 1,
        'hex_color': 1,
      },
    });
  });

  test('compare flags growth, new files and unrecorded cleanup', () {
    final problems = compare(
      {
        'lib/a.dart': {'raw_radius': 3},
        'lib/new.dart': {'snackbar': 1},
        'lib/b.dart': {'hex_color': 1},
      },
      {
        'lib/a.dart': {'raw_radius': 2},
        'lib/b.dart': {'hex_color': 2},
      },
    );
    expect(problems, hasLength(3));
    expect(problems.join('\n'), contains('lib/a.dart: raw_radius 3'));
    expect(problems.join('\n'), contains('lib/new.dart: snackbar 1'));
    expect(problems.join('\n'), contains('lib/b.dart: hex_color dropped'));
  });

  test('lib/ matches the design baseline', () {
    final actual = scanSource(readLib());
    final file = File(baselinePath);
    if (Platform.environment['UPDATE_DESIGN_BASELINE'] == '1') {
      final sorted = Map.fromEntries(
          actual.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
      file.writeAsStringSync(
          '${const JsonEncoder.withIndent('  ').convert(sorted)}\n');
      return;
    }
    final baseline = (jsonDecode(file.readAsStringSync()) as Map)
        .map((k, v) => MapEntry(k as String, (v as Map).cast<String, int>()));
    final problems = compare(actual, baseline);
    expect(problems, isEmpty, reason: problems.join('\n'));
  });
}
