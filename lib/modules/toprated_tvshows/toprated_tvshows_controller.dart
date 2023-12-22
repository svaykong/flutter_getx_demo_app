import 'package:get/get.dart';

import '../../apis/tvshows_api.dart';
import '../../models/movie_model.dart';
import '../../models/base_type.dart';
import '../../utils/logger.dart';

class TopRatedTVShowsController extends GetxController {
  final TVShowsApi _tvShowsApi = TVShowsApi();
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
      var response = await _tvShowsApi.geTopRatedTVShows();
      if (response != null) {
        nowPlayingMovie = MovieModel.fromMap(response, BaseType.TOPRATED_TVSHOWS);
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
