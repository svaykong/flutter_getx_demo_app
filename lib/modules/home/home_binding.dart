import 'package:get/get.dart';

// import 'home_controller.dart';
import '../popular_movie/popular_movie_controller.dart';
import '../upcoming_movie/upcoming_movie_controller.dart';

/*
***Binding
  Bindings can be used to initialize:
  - your controllers,
  - repositories, APIs, and
  - whatever else you need without having to call them directly from the view page.
*/
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    //Get.lazyPut(() => HomeController());
    Get.lazyPut(() => PopularMovieController());
    Get.lazyPut(() => UpcomingMovieController());
  }
}
