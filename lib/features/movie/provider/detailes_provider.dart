import 'package:flutter/foundation.dart';
import 'package:gowatch/features/movie/model/movie_details.dart';
import '../service/omdb_api.dart';

class DetailProvider extends ChangeNotifier {
  final OmdbApi api;
  DetailProvider(this.api);

  MovieDetails? movie;
  String? error;
  bool loading = false;

  Future<void> load(String imdbId) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      movie = await api.detail(imdbId);
    } catch (e) {
      error = e.toString();
    }
    loading = false;
    notifyListeners();
  }
}
