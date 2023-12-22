import 'package:get/get.dart';

import 'toprated_tvshows_controller.dart';

class TopRatedTVShowsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TopRatedTVShowsController());
  }
}