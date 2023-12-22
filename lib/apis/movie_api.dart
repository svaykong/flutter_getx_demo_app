import 'package:dio/dio.dart';

import '../utils/constants.dart';
import '../utils/logger.dart';

class MovieApi {
  String _url = '';
  final dio = Dio(BaseOptions(baseUrl: apiBaseUrl));

  Future<dynamic> getPopularMoviesByPage({required int pageNum}) async {
    _url = '/movie/popular?api_key=$apiKey&page=$pageNum';
    final response = await dio.get(_url);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<dynamic> getPopularMovies() async {
    return await getPopularMoviesByPage(pageNum: 1);
  }

  Future<dynamic> getTopRatedMoviesByPage({required int pageNum}) async {
    _url = '/movie/top_rated?api_key=$apiKey&page=$pageNum';
    final response = await dio.get(_url);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<dynamic> getTopRatedMovies() async {
    return await getTopRatedMoviesByPage(pageNum: 1);
  }

  Future<dynamic> getMovieDetails({required int movieId}) async {
    _url = '/movie/$movieId?api_key=$apiKey';
    final response = await dio.get(_url);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<dynamic> searchMovie({required String query}) async {
    try {
      _url = '$apiBaseUrl/search/movie?query=$query&include_adult=false&language=en-US&page=1';
      final response = await dio.get(
        _url,
        options: Options(headers: {
          "accept": "application/json",
          "Authorization":
              "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlM2I3NGZkZGFlNjg2OGUxMTlkZmQyZjViOGVmNjJkOSIsInN1YiI6IjVjODQ5NjMyYzNhMzY4NGU5OGRiMzQ5MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GESqSqEd8OG9Aj1NproXc_dRRiCtfJxt7mWUbDuGv3s",
        }),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      'searchMovieApi exception: $e'.log();
    } finally {
      'searchMovieApi finally'.log();
    }
  }
}
