import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../shared_widgets/round_progress_bar.dart';
import '../../models/movie_model.dart';
import '../../models/base_type.dart';
import '../../routes/app_routes.dart';
import '../../themes/app_text_theme.dart';
import '../../themes/colors_theme.dart';
import '../../utils/constants.dart';
import '../../utils/logger.dart';
import '../../modules/all_movies/all_movies_controller.dart';

class AllMoviesPage extends StatelessWidget {
  const AllMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle),
      ),
      body: SafeArea(
        child: GetBuilder<AllMoviesController>(
          builder: (controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (controller.errMsg.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(controller.errMsg),
              );
            }
            return _buildListView(controller.allMovies);
          },
        ),
      ),
    );
  }

  String get getTitle {
    switch (Get.arguments) {
      case BaseType.POPULAR_MOVIE:
        return 'All Popular Movies';
      case BaseType.POPULAR_TVSHOWS:
        return 'All Popular TV Shows';
      case BaseType.TOPRATED_TVSHOWS:
        return 'All Top Rated TV Shows';
      case BaseType.TOPRATED_MOVIE:
        return 'All Top Rated Movies';
      default:
        return '';
    }
  }

  Widget _buildListView(List<ResultModel> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.all(10.0),
        clipBehavior: Clip.antiAlias,
        elevation: 2.0,
        child: GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.movieDetails, arguments: [results[index].id]);
          },
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    placeholder: (_, __) => Container(color: Colors.grey[100]),
                    imageUrl: '$imageBaseUrl${results[index].backdropPath}',
                    fit: BoxFit.cover,
                    height: Get.height * 0.30,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 20.0),
                    child: Text(
                      results[index].originalTitle,
                      textAlign: TextAlign.start,
                      style: poppinsRegular(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: Text(
                      results[index].getReleaseDateISO,
                      textAlign: TextAlign.start,
                      style: poppinsRegular(
                        color: ThemeColor.secondaryDarkGrey,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 55,
                left: 5,
                child: RoundProgressBar(
                  percent: results[index].votPercent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
