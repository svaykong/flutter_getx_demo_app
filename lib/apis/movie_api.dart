import 'package:dio/dio.dart';

import '../utils/constants.dart';

class MovieApi {
  String _url = '';
  final dio = Dio(BaseOptions(baseUrl: apiBaseUrl));

  Future<dynamic> getUpcomingMovies() async {
    _url = '/movie/upcoming?api_key=$apiKey';
    final response = await dio.get(_url);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<dynamic> getPopularMovies() async {
    _url = '/movie/popular?api_key=$apiKey';
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
