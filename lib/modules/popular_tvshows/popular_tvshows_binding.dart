import 'package:get/get.dart';

import 'popular_tvshows_controller.dart';

class PopularTvShowsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PopularTvShowsController());
  }
}