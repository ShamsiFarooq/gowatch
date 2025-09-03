import 'package:flutter/foundation.dart';
import 'package:gowatch/features/movie/model/movie_summary.dart';
import '../service/omdb_api.dart';
import '../utils/debouncer.dart';

class SearchProvider extends ChangeNotifier {
  final OmdbApi api;
  final _debouncer = Debouncer(const Duration(milliseconds: 400));

  String _query = 'avengers';
  int _page = 1;
  int _total = 0;
  bool _loading = false;
  bool _loadingMore = false;
  List<MovieSummary> _items = [];

  SearchProvider(this.api);

  String get query => _query;
  int get total => _total;
  List<MovieSummary> get items => _items;
  bool get loading => _loading;
  bool get loadingMore => _loadingMore;
  bool get isLastPage => _items.length >= _total;

  void onQueryChanged(String q) {
    _query = q;
    _debouncer.run(() async {
      await _search(reset: true);
    });
  }

  Future<void> initialLoad() => _search(reset: true);

  Future<void> fetchNext() async {
    if (isLastPage || _loadingMore || _loading) return;
    _loadingMore = true;
    notifyListeners();
    _page += 1;
    final r = await api.search(_query.isEmpty ? 'avengers' : _query, _page);
    _items = [..._items, ...r.items];
    _total = r.total;
    _loadingMore = false;
    notifyListeners();
  }

  Future<void> _search({required bool reset}) async {
    _loading = true;
    if (reset) {
      _page = 1;
      _items = [];
    }
    notifyListeners();
    final r = await api.search(_query.isEmpty ? 'avengers' : _query, _page);
    _items = r.items;
    _total = r.total;
    _loading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }
}
