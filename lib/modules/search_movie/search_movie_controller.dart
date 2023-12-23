import 'dart:async';

import 'package:get/get.dart';

import '../../models/base_type.dart';
import '../../models/movie_model.dart';
import '../../apis/movie_api.dart';
import '../../utils/logger.dart';

class SearchMovieController extends GetxController {
  final MovieApi _movieApi = MovieApi();

  //MovieModel? resultSearchMovie;
  //bool isLoading = false;
  //String errMsg = '';

  Stream<MovieModel> search({required String query}) {
    try {
      return Stream.fromFuture(_movieApi.searchMovie(query: query));
      /*
      _movieApi.searchMovie(query: query)
          .then((result) => MovieModel.fromMap(result, BaseType.UNKNOWN))
          .asStream();
      */
    } catch (e) {
      'exception: $e'.log();
      throw Exception("Search exception: $e");
    } finally {
      'search finally'.log();
    }
  }
}
