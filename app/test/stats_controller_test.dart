import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart';
import 'package:aero/screens/profile/stats/stats_controller.dart';

class FakeStats extends Fake implements ProfileStatsResponseEntity {
  FakeStats(this.year);
  @override
  final num? year;
}

class FakeSummary extends Fake implements StatsFlightSummaryEntity {
  FakeSummary(this.id);
  @override
  final String id;
}

FlightHistoryResponseEntity page(List<String> ids, String? next,
    [List<int> years = const [2025]]) {
  return FlightHistoryResponseEntity((b) => b
    ..items = ListBuilder<StatsFlightSummaryEntity>(ids.map(FakeSummary.new))
    ..nextCursor = next
    ..yearCounts =
        ListBuilder<YearCountEntity>(years.map((y) => YearCountEntity((c) => c
          ..year = y
          ..count = 1))));
}

void main() {
  test('load fetches stats and first page', () async {
    final c = StatsController(
      fetchStats: (y) async => FakeStats(y),
      fetchHistory: (cur, y) async => page(['a', 'b'], 'n1', [2024, 2025]),
    );
    await c.load();
    expect(c.loading, false);
    expect(c.stats, isNotNull);
    expect(c.history.map((e) => e.id), ['a', 'b']);
    expect(c.yearCounts.length, 2);
    expect(c.historyDone, false);
  });

  test('setYear resets history and passes year', () async {
    final years = <int?>[];
    final c = StatsController(
      fetchStats: (y) async => FakeStats(y),
      fetchHistory: (cur, y) async {
        years.add(y);
        return page(y == null ? ['a'] : ['z'], null);
      },
    );
    await c.load();
    await c.setYear(2024);
    expect(years, [null, 2024]);
    expect(c.year, 2024);
    expect(c.history.map((e) => e.id), ['z']);
    await c.setYear(2024);
    expect(years.length, 2);
  });

  test('loadMoreHistory appends and stops at null cursor', () async {
    var calls = 0;
    final c = StatsController(
      fetchStats: (y) async => FakeStats(y),
      fetchHistory: (cur, y) async {
        calls++;
        return cur == null ? page(['a'], 'n1') : page(['b'], null);
      },
    );
    await c.load();
    await c.loadMoreHistory();
    expect(c.history.map((e) => e.id), ['a', 'b']);
    expect(c.historyDone, true);
    await c.loadMoreHistory();
    expect(calls, 2);
  });

  test('stale year response is ignored', () async {
    final gates = <int?, Completer<void>>{
      2024: Completer(),
      2025: Completer(),
    };
    final c = StatsController(
      fetchStats: (y) async {
        await gates[y]!.future;
        return FakeStats(y);
      },
      fetchHistory: (cur, y) async => page(['y$y'], null),
    );
    final f1 = c.setYear(2024);
    final f2 = c.setYear(2025);
    gates[2025]!.complete();
    await f2;
    gates[2024]!.complete();
    await f1;
    expect(c.stats!.year, 2025);
    expect(c.history.map((e) => e.id), ['y2025']);
    expect(c.loading, false);
  });

  test('error sets message and clears loading', () async {
    final c = StatsController(
      fetchStats: (y) async => throw Exception('boom'),
      fetchHistory: (cur, y) async => page([], null),
    );
    await c.load();
    expect(c.error, contains('boom'));
    expect(c.loading, false);
  });
}
