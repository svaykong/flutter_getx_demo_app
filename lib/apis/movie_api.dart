import 'package:dio/dio.dart';

import '../models/base_type.dart';
import '../utils/constants.dart';
import '../utils/logger.dart';
import '../models/movie_model.dart';

class MovieApi {
  String _url = '';
  final dio = Dio(BaseOptions(baseUrl: apiBaseUrl));

  Future<dynamic> getPopularMoviesByPage({required int pageNum}) async {
    _url = '/movie/popular?api_key=$tmdApiKey&page=$pageNum';
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
    _url = '/movie/top_rated?api_key=$tmdApiKey&page=$pageNum';
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
    _url = '/movie/$movieId?api_key=$tmdApiKey';
    final response = await dio.get(_url);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<MovieModel> searchMovie({required String query}) async {
    try {
      _url = '$apiBaseUrl/search/movie?api_key=$tmdApiKey&query=$query&include_adult=false&language=en-US&page=1';
      final response = await dio.get(
        _url,
        options: Options(headers: {
          "accept": "application/json",
          // "Authorization": "Bearer $token", // Can skip token
        }),
      );
      if (response.statusCode == 200) {
        return Future.value(MovieModel.fromMap(response.data, BaseType.UNKNOWN));
      } else {
        return Future.error("Unknown");
      }
    } catch (e) {
      'searchMovieApi exception: $e'.log();
      return Future.error("Unknown error: $e");
    } finally {
      'searchMovieApi finally'.log();
    }
  }
}
