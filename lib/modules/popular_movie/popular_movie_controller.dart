import 'package:get/get.dart';

import '../../models/movie_type.dart';
import '../../apis/movie_api.dart';
import '../../models/movie_model.dart';
import '../../utils/logger.dart';

class PopularMovieController extends GetxController {
  MovieApi movieApi = MovieApi();
  List<MovieModel> popularMovies = [];
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
        response['results'].forEach((data) {
          final movie = MovieModel.fromMap(data);
          movie.movieType = MovieType.POPULAR;
          popularMovies.add(movie);
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
