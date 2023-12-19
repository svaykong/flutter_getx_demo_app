import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../shared_widgets/heading_section.dart';
import 'widgets/horizontal_view_section.dart';
import 'popular_movie_controller.dart';

class PopularMoviePage extends StatelessWidget {
  const PopularMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularMovieController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('TMDB'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              HeadingSection(
                headingName: 'Popular Movies',
                onSeeAllPressed: () {},
              ),
              controller.isLoading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: const HorizontalViewSection(
                        popularMovies: null,
                      ),
                    )
                  : HorizontalViewSection(popularMovies: controller.popularMovies),
            ],
          ),
        ),
      ),
    );
  }
}
