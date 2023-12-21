import 'package:get/get.dart';

import 'nowplaying_movie_controller.dart';

class NowPlayingMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NowPlayingMovieController());
  }
}