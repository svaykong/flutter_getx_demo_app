import 'package:get/get.dart';

import '../../utils/logger.dart';
import '../../models/base_type.dart';
import '../../apis/movie_api.dart';
import '../../models/movie_model.dart';

class TopRatedMovieController extends GetxController {
  final MovieApi _movieApi = MovieApi();
  late MovieModel topRatedMovie;
  bool isLoading = true;
  String errMsg = '';

  @override
  void onInit() {
    super.onInit();
    fetchTopRateMovies();
  }

  void fetchTopRateMovies() async {
    try {
      var response = await _movieApi.getTopRatedMovies();
      if (response != null) {
        topRatedMovie = MovieModel.fromMap(response, BaseType.TOPRATED_MOVIE);
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
