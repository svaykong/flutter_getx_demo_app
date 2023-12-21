import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../utils/constants.dart';
import '../models/movie_model.dart';

class HorizontalViewSection extends StatelessWidget {
  const HorizontalViewSection({
    super.key,
    required this.movies,
  });

  final List<MovieModel> movies;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: Get.height * 0.2,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: movies.isEmpty ? 5 : movies.length,
            itemBuilder: (ctx, index) {
              if (movies.isEmpty) {
                return Card(
                  margin: const EdgeInsets.only(right: 8.0),
                  clipBehavior: Clip.antiAlias,
                  elevation: 20.0,
                  child: SizedBox(
                    height: Get.height * 0.30,
                    width: Get.width * 0.5,
                  ),
                );
              }

              return Card(
                margin: const EdgeInsets.only(right: 8.0),
                clipBehavior: Clip.antiAlias,
                elevation: 20.0,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.movieDetails, arguments: [movies[index].id]);
                  },
                  child: CachedNetworkImage(
                    imageUrl: '$imageBaseUrl${movies[index].backdropPath}',
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
