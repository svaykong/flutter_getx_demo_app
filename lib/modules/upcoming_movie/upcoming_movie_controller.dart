import 'package:get/get.dart';

import '../../utils/logger.dart';
import '../../models/movie_type.dart';
import '../../apis/movie_api.dart';
import '../../models/movie_model.dart';

class UpcomingMovieController extends GetxController {
  MovieApi movieApi = MovieApi();
  List<MovieModel> upcomingMovies = [];
  bool isLoading = true;
  String errMsg = '';

  @override
  void onInit() {
    super.onInit();
    fetchUpcomingMovies();
  }

  void fetchUpcomingMovies() async {
    try {
      var response = await movieApi.getUpcomingMovies();
      if (response != null) {
        response['results'].forEach((data) {
          final movie = MovieModel.fromMap(data);
          movie.movieType = MovieType.UPCOMPING;
          upcomingMovies.add(movie);
        });
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
