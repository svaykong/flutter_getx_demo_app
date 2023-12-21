import 'package:get/get.dart';

import 'all_movies_controller.dart';

class AllMoviesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AllMoviesController());
  }
}
