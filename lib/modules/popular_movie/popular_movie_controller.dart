import 'package:get/get.dart';

import '../../models/base_type.dart';
import '../../apis/movie_api.dart';
import '../../models/movie_model.dart';
import '../../utils/logger.dart';

class PopularMovieController extends GetxController {
  final MovieApi _movieApi = MovieApi();
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
      var response = await _movieApi.getPopularMovies();
      if (response != null) {
        popularMovie = MovieModel.fromMap(response, BaseType.POPULAR_MOVIE);
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
