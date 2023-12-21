import 'package:get/get.dart';

import '../../apis/movie_api.dart';
import '../../models/movie_model.dart';
import '../../models/movie_type.dart';
import '../../utils/logger.dart';

class NowPlayingMovieController extends GetxController {
  MovieApi movieApi = MovieApi();
  late MovieModel nowPlayingMovie;
  bool isLoading = true;
  String errMsg = '';

  @override
  void onInit() {
    super.onInit();
    fetchNowPlayingMovies();
  }

  void fetchNowPlayingMovies() async {
    try {
      var response = await movieApi.getNowPlayingMovies();
      if (response != null) {
        nowPlayingMovie = MovieModel.fromMap(response, MovieType.NOWPLAYING);
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
