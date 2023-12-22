import 'package:get/get.dart';

import '../../models/base_type.dart';
import '../../models/movie_model.dart';
import '../../apis/movie_api.dart';
import '../../utils/logger.dart';

class SearchMovieController extends GetxController {
  final MovieApi _movieApi = MovieApi();
  MovieModel? resultSearchMovie;
  bool isLoading = true;
  String errMsg = '';

  void search({required String query}) async {
    try {
      final response = await _movieApi.searchMovie(query: query);
      if (response != null) {
        resultSearchMovie = MovieModel.fromMap(response, BaseType.UNKNOWN);
      }
    } catch (e) {
      'exception: $e'.log();
      errMsg = e.toString();
    } finally {
      isLoading = false;
      update(); // notify listener
    }
  }
}
