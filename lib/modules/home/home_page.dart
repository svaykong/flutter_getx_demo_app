import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../models/base_type.dart';
import '../../modules/all_movies/all_movies_controller.dart';
import '../../shared_widgets/heading_section.dart';
import '../../modules/popular_movie/popular_movie_page.dart';
import '../../modules/popular_tvshows/popular_tvshows_page.dart';
import '../../modules/toprated_tvshows/toprated_tvshows_page.dart';
import '../../modules/toprated_movie/toprated_movie_page.dart';
import '../../routes/app_routes.dart';
import '../../utils/logger.dart';
import '../search_movie/movie_search_delegate.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF032541),
        title: Image.asset(
          'assets/imgs/logo.png',
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MovieSearchDelegate(),
              );
            },
            icon: const Icon(
              Icons.search,
              size: 28.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Column(
            children: [
              HeadingSection(
                headingName: 'Popular Movies',
                onSeeAllPressed: () async {
                  final controller = Get.find<AllMoviesController>();
                  controller.init(BaseType.POPULAR_MOVIE);
                  await controller.fetchAllMovies();
                  Get.toNamed(AppRoutes.allMovies, arguments: BaseType.POPULAR_MOVIE);
                },
              ),
              const PopularMoviePage(),
              HeadingSection(
                headingName: 'Top Rated Movies',
                onSeeAllPressed: () async {
                  final controller = Get.find<AllMoviesController>();
                  controller.init(BaseType.TOPRATED_MOVIE);
                  await controller.fetchAllMovies();
                  Get.toNamed(AppRoutes.allMovies, arguments: BaseType.TOPRATED_MOVIE);
                },
              ),
              const TopRatedMoviePage(),
              HeadingSection(
                headingName: 'Popular TV Shows',
                onSeeAllPressed: () async {
                  final controller = Get.find<AllMoviesController>();
                  controller.init(BaseType.POPULAR_TVSHOWS);
                  await controller.fetchAllMovies();
                  Get.toNamed(AppRoutes.allMovies, arguments: BaseType.POPULAR_TVSHOWS);
                },
              ),
              const PopularTvShowsPage(),
              HeadingSection(
                headingName: 'Top Rated TV Shows',
                onSeeAllPressed: () async {
                  final controller = Get.find<AllMoviesController>();
                  controller.init(BaseType.TOPRATED_TVSHOWS);
                  await controller.fetchAllMovies();
                  Get.toNamed(AppRoutes.allMovies, arguments: BaseType.TOPRATED_TVSHOWS);
                },
              ),
              const TopRatedTVShowsPage(),
            ],
          ),
        ),
      ),
    );
  }
}
