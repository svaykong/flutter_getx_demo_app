import 'package:get/get.dart';

import '../../apis/movie_api.dart';
import '../../models/popular_movie_model.dart';
import '../../utils/logger.dart';

class PopularMovieController extends GetxController {
  MovieApi movieApi = MovieApi();
  List<PopularMovieModel> popularMovies = [];
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    fetchTrendingMovies();
  }

  void fetchTrendingMovies() async {
    try {
      var response = await movieApi.getPopularMovies();
      if (response != null) {
        response['results'].forEach((data) {
          popularMovies.add(PopularMovieModel.fromMap(data));
        });
        isLoading = false;
      }
    } catch (e) {
      'exception: $e'.log();
      isLoading = false;
    } finally {
      // notify listener
      update();
    }
  }
}
