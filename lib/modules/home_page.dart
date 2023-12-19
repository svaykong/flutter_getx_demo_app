import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

import 'shared_widgets/heading_section.dart';
import '../utils/logger.dart';
import '../modules/popular_movie/popular_movie_controller.dart';
import '../modules/popular_movie/widgets/horizontal_view_section.dart' as popular;
import '../modules/upcoming_movie/widgets/horizontal_view_section.dart' as upcoming;
import '../modules/upcoming_movie/upcoming_movie_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.view_list_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            HeadingSection(
              headingName: 'Popular Movies',
              onSeeAllPressed: () {},
            ),
            GetBuilder<PopularMovieController>(
              builder: (controller) {
                if (controller.popularMovies.isEmpty && controller.isLoading) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: const popular.HorizontalViewSection(
                      popularMovies: null,
                    ),
                  );
                }

                return popular.HorizontalViewSection(popularMovies: controller.popularMovies);
              },
            ),
            HeadingSection(
              headingName: 'Upcoming Movies',
              onSeeAllPressed: () {},
            ),
            GetBuilder<UpcomingMovieController>(
              builder: (controller) => controller.isLoading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: const upcoming.HorizontalViewSection(
                        upcomingMovies: null,
                      ),
                    )
                  : upcoming.HorizontalViewSection(upcomingMovies: controller.upcomingMovies),
            ),
          ],
        ),
      ),
    );
  }
}
