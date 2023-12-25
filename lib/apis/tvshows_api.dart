import 'package:dio/dio.dart';

import '../utils/constants.dart';
import '../utils/logger.dart';

class TVShowsApi {
  String _url = '';
  final dio = Dio(BaseOptions(baseUrl: apiBaseUrl));

  Future<dynamic> getPopularTVShowsByPage({required int pageNum}) async {
    _url = '/tv/popular?api_key=$tmdApiKey&page=$pageNum';
    final response = await dio.get(_url);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<dynamic> getPopularTVShowsMovies() async {
    return await getPopularTVShowsByPage(pageNum: 1);
  }

  Future<dynamic> getTopRatedTVShowsByPage({required int pageNum}) async {
    _url = '/tv/top_rated?api_key=$tmdApiKey&page=$pageNum';
    final response = await dio.get(_url);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<dynamic> geTopRatedTVShows() async {
    return await getTopRatedTVShowsByPage(pageNum: 1);
  }
}