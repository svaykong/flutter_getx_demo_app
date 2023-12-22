import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../shared_widgets/horizontal_view_section.dart';
import 'popular_tvshows_controller.dart';

class PopularTvShowsPage extends StatelessWidget {
  const PopularTvShowsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularTvShowsController>(builder: (controller) {
      if (controller.isLoading) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: const HorizontalViewSection(
            movies: [],
          ),
        );
      }

      if (controller.errMsg.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(controller.errMsg),
        );
      }

      return HorizontalViewSection(movies: controller.upcomingMovie.results);
    });
  }
}
