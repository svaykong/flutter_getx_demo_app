import 'package:get/get.dart';

import 'app_routes.dart';
import '../modules/movie_details/movie_details_binding.dart';
import '../modules/movie_details/movie_details_page.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_page.dart';
import '../modules/all_movies/all_movies_page.dart';
import '../modules/all_movies/all_movies_binding.dart';

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
    GetPage(
      name: AppRoutes.allMovies,
      page: () => const AllMoviesPage(),
      binding: AllMoviesBinding(),
    ),
  ];
}
