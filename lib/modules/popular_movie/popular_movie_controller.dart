import 'package:get/get.dart';

import '../../models/movie_type.dart';
import '../../apis/movie_api.dart';
import '../../models/movie_model.dart';
import '../../utils/logger.dart';

class PopularMovieController extends GetxController {
  MovieApi movieApi = MovieApi();
  late MovieModel popularMovie;
  bool isLoading = true;
  String errMsg = '';

  @override
  void onInit() {
    super.onInit();
    fetchPopularMovies();
  }

  void fetchPopularMovies() async {
    try {
      var response = await movieApi.getPopularMovies();
      if (response != null) {
        popularMovie = MovieModel.fromMap(response, MovieType.POPULAR);
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

  //TODO: When click See All display more popular movies
  void fetchAllPopularMovies() async {
    try {
      var response = await movieApi.getPopularMoviesByPage(pageNum: 1);
      if (response != null) {
        popularMovie = MovieModel.fromMap(response, MovieType.POPULAR);
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
