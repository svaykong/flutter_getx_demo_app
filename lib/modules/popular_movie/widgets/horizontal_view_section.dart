import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../models/popular_movie_model.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/constants.dart';

class HorizontalViewSection extends StatelessWidget {
  const HorizontalViewSection({
    super.key,
    this.popularMovies,
  });

  final List<PopularMovieModel>? popularMovies;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: Get.height * 0.2,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: popularMovies == null ? 5 : popularMovies!.length,
            itemBuilder: (ctx, index) {
              return Card(
                margin: const EdgeInsets.only(right: 8.0),
                clipBehavior: Clip.antiAlias,
                elevation: 20.0,
                child: popularMovies == null
                    ? SizedBox(
                        height: Get.height * 0.30,
                        width: Get.width * 0.5,
                      )
                    : GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.movieDetails, arguments: [popularMovies![index].id]);
                        },
                        child: CachedNetworkImage(
                          imageUrl: '$imageBaseUrl${popularMovies![index].backdropPath}',
                          fit: BoxFit.cover,
                          height: Get.height * 0.30,
                          width: Get.width * 0.5,
                        ),
                      ),
              );
            }),
      ),
    );
  }
}
