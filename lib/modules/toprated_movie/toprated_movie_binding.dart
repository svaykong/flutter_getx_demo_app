import 'package:get/get.dart';

import 'toprated_movie_controller.dart';

class TopRatedMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TopRatedMovieController());
  }
}