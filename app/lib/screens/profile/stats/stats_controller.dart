import 'package:flutter/foundation.dart';
import 'package:openapi/openapi.dart';

typedef StatsFetcher = Future<ProfileStatsResponseEntity?> Function(int? year);
typedef HistoryFetcher = Future<FlightHistoryResponseEntity?> Function(
    String? cursor, int? year);

class StatsController extends ChangeNotifier {
  StatsController({required this.fetchStats, required this.fetchHistory});

  final StatsFetcher fetchStats;
  final HistoryFetcher fetchHistory;

  int? year;
  ProfileStatsResponseEntity? stats;
  bool loading = false;
  String? error;
  List<StatsFlightSummaryEntity> history = [];
  bool historyLoading = false;
  bool historyDone = false;
  List<YearCountEntity> yearCounts = [];

  String? _cursor;
  int _requestId = 0;

  /// Stats plus first history page for the current [year].
  Future<void> load() async {
    final id = ++_requestId;
    loading = true;
    historyLoading = false;
    error = null;
    history = [];
    historyDone = false;
    _cursor = null;
    notifyListeners();
    try {
      final results = await Future.wait([
        fetchStats(year),
        fetchHistory(null, year),
      ]);
      if (id != _requestId) return;
      stats = results[0] as ProfileStatsResponseEntity?;
      final page = results[1] as FlightHistoryResponseEntity?;
      if (page != null) {
        history = page.items.toList();
        yearCounts = page.yearCounts.toList();
        _cursor = page.nextCursor;
      }
      historyDone = _cursor == null;
    } catch (e) {
      if (id != _requestId) return;
      error = e is Exception ? _message(e) : e.toString();
    }
    loading = false;
    notifyListeners();
  }

  Future<void> setYear(int? y) {
    if (y == year) return Future.value();
    year = y;
    return load();
  }

  Future<void> loadMoreHistory() async {
    if (loading || historyLoading || historyDone) return;
    final id = _requestId;
    historyLoading = true;
    notifyListeners();
    try {
      final page = await fetchHistory(_cursor, year);
      if (id != _requestId) return;
      if (page != null) {
        history = [...history, ...page.items];
        _cursor = page.nextCursor;
      }
      historyDone = _cursor == null;
    } catch (e) {
      if (id != _requestId) return;
      error = e is Exception ? _message(e) : e.toString();
    }
    historyLoading = false;
    notifyListeners();
  }

  // ApiException/Exception toString carries a prefix; keep the readable part.
  String _message(Exception e) {
    final dynamic d = e;
    try {
      final m = d.message;
      if (m is String) return m;
    } catch (_) {}
    return e.toString().replaceFirst('Exception: ', '');
  }
}
