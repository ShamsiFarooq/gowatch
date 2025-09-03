import 'package:dio/dio.dart';
import 'package:gowatch/features/movie/model/movie_details.dart';
import 'package:gowatch/features/movie/model/movie_summary.dart';
import '../../../app/env.dart';

class OmdbApi {
  final Dio _dio;
  OmdbApi(Dio dio) : _dio = dio;

  factory OmdbApi.create() => OmdbApi(
    Dio(
      BaseOptions(
        baseUrl: Env.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
      ),
    ),
  );

  Future<({List<MovieSummary> items, int total})> search(
    String q,
    int page,
  ) async {
    final res = await _dio.get(
      '',
      queryParameters: {'apikey': Env.omdbApiKey, 's': q, 'page': page},
    );
    final data = res.data as Map<String, dynamic>;
    if ((data['Response'] ?? 'False') == 'False') {
      return (items: <MovieSummary>[], total: 0);
    }
    final items =
        (data['Search'] as List<dynamic>)
            .map((e) => MovieSummary.fromJson(e))
            .toList();
    final total = int.tryParse('${data['totalResults'] ?? 0}') ?? 0;
    return (items: items, total: total);
  }

  Future<MovieDetails> detail(String imdbId) async {
    final res = await _dio.get(
      '',
      queryParameters: {'apikey': Env.omdbApiKey, 'i': imdbId, 'plot': 'full'},
    );
    final data = res.data as Map<String, dynamic>;
    if ((data['Response'] ?? 'False') == 'False') {
      throw Exception(data['Error'] ?? 'Not found');
    }
    return MovieDetails.fromJson(data);
  }
}
