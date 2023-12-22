import 'package:get/get.dart';

import '../../utils/logger.dart';
import '../../models/base_type.dart';
import '../../apis/tvshows_api.dart';
import '../../models/movie_model.dart';

class PopularTvShowsController extends GetxController {
  final TVShowsApi _tvShowsApi = TVShowsApi();
  late MovieModel upcomingMovie;
  bool isLoading = true;
  String errMsg = '';

  @override
  void onInit() {
    super.onInit();
    fetchUpcomingMovies();
  }

  void fetchUpcomingMovies() async {
    try {
      var response = await _tvShowsApi.getPopularTVShowsMovies();
      if (response != null) {
        upcomingMovie = MovieModel.fromMap(response, BaseType.POPULAR_TVSHOWS);
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
