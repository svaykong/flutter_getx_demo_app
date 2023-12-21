import 'package:get/get.dart';

import '../../utils/logger.dart';
import '../../models/movie_type.dart';
import '../../apis/movie_api.dart';
import '../../models/movie_model.dart';

class TopRatedMovieController extends GetxController {
  MovieApi movieApi = MovieApi();
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
      var response = await movieApi.getTopRatedMovies();
      if (response != null) {
        topRatedMovie = MovieModel.fromMap(response, MovieType.TOPRATED);
        isLoading = false;
      }
    } catch (e) {
      'exception: $e'.log();
      errMsg = e.toString();
      isLoading = false;
    } finally {
      update(); // notify listener
    }
  }
}
