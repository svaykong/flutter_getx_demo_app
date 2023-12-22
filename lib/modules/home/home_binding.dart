import 'package:get/get.dart';

// import 'home_controller.dart';
import '../popular_movie/popular_movie_controller.dart';
import '../popular_tvshows/popular_tvshows_controller.dart';
import '../toprated_tvshows/toprated_tvshows_controller.dart';
import '../toprated_movie/toprated_movie_controller.dart';
import '../all_movies/all_movies_controller.dart';

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
    Get.lazyPut(() => PopularTvShowsController());
    Get.lazyPut(() => TopRatedTVShowsController());
    Get.lazyPut(() => TopRatedMovieController());
    Get.lazyPut(() => AllMoviesController());
  }
}
