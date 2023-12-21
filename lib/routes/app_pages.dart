import 'package:get/get.dart';

import 'app_routes.dart';
import '../modules/movie_details/movie_details_binding.dart';
import '../modules/movie_details/movie_details_page.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_page.dart';
// import '../modules/upcoming_movie/upcoming_movie_binding.dart';
// import '../modules/upcoming_movie/upcoming_movie_page.dart';
// import '../modules/popular_movie/popular_movie_binding.dart';
// import '../modules/popular_movie/popular_movie_page.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.movieDetails,
      page: () => const MovieDetailsPage(),
      binding: MovieDetailsBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.popularMovie,
    //   page: () => const PopularMoviePage(),
    //   binding: PopularMovieBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.upcomingMovie,
    //   page: () => const UpcomingMoviePage(),
    //   binding: UpcomingMovieBinding(),
    // ),
  ];
}
