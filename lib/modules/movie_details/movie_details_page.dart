import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../shared_widgets/round_progress_bar.dart';
import 'movie_details_controller.dart';
import '../../themes/app_text_theme.dart';
import '../../themes/colors_theme.dart';
import '../../utils/constants.dart';
import '../../utils/logger.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.white,
      body: _getBody,
    );
  }

  Widget get _getBody {
    return GetBuilder<MovieDetailsController>(builder: (controller) {
      var movieItem = controller.movieData;
      if (controller.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (movieItem == null) {
        return const Center(
          child: Text('Unknown error'),
        );
      }
      return NestedScrollView(
        headerSliverBuilder: ((BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text(
                movieItem.originalTitle,
                style: poppinsRegular(fontSize: 20, color: ThemeColor.white, fontWeight: FontWeight.bold),
              ),
              expandedHeight: Get.height / 1.8,
              floating: true,
              pinned: true,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: '$imageBaseUrl${movieItem.backdropPath}',
                      fit: BoxFit.cover,
                      width: Get.width,
                      height: Get.height,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5.0,
                      left: 5.0,
                      child: RoundProgressBar(
                        percent: movieItem.votePercent,
                      ),
                    ),
                  ],
                ),
                collapseMode: CollapseMode.parallax,
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            )
          ];
        }),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movieItem.tagline,
                style: poppinsRegular(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: ThemeColor.primaryGrey,
                ),
              ),
              const Gap(20),
              Text(
                'Overview',
                style: poppinsRegular(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Gap(20),
              Text(
                movieItem.overview,
                style: poppinsRegular(color: ThemeColor.primaryGrey),
                textAlign: TextAlign.justify,
              ),
              const Gap(20.0),
              Text(
                'Release Date: ${movieItem.getReleaseDateISO.isEmpty ? 'None' : movieItem.getReleaseDateISO}',
                style: poppinsRegular(),
              ),
              Text(
                movieItem.genres.map((genre) => genre.name).join(' | '),
                style: poppinsRegular(color: ThemeColor.primaryGrey),
              ),
              const Gap(20.0),
              // TODO: Watch Trailer
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: ThemeColor.primaryColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    side: BorderSide(width: 0.45),
                  ),
                ),
                onPressed: () {
                  Get.snackbar('Watch Trailer', 'Todo display trailer');
                },
                child: const Text(
                  'Watch Trailer',
                  style: TextStyle(
                    color: ThemeColor.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
