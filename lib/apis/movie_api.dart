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

  Future<dynamic> getNowPlayingMovies() async {
    _url = '/movie/now_playing?api_key=$apiKey';
    final response = await dio.get(_url);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<dynamic> getUpcomingMovies() async {
    _url = '/movie/upcoming?api_key=$apiKey';
    final response = await dio.get(_url);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<dynamic> getTopRatedMovies() async {
    _url = '/movie/top_rated?api_key=$apiKey';
    final response = await dio.get(_url);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
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
}
