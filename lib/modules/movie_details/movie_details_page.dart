import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../shared_widgets/round_progress_bar.dart';
import 'movie_details_controller.dart';
import '../../themes/app_text_theme.dart';
import '../../themes/colors_theme.dart';
import '../../utils/constants.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieDetailsController>(builder: (controller) {
      var movieItem = controller.movieData;
      return Scaffold(
        backgroundColor: ThemeColor.white,
        body: controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : NestedScrollView(
                headerSliverBuilder: ((BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      title: Text(
                        movieItem[0].originalTitle,
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
                              imageUrl: '$imageBaseUrl${movieItem[0].backdropPath}',
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
                                percent: movieItem[0].votePercent,
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
                        'Overview',
                        style: poppinsRegular(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Gap(20),
                      Text(
                        movieItem[0].overview,
                        style: poppinsRegular(color: ThemeColor.primaryGrey),
                        textAlign: TextAlign.justify,
                      ),
                      const Gap(20.0),
                      RichText(
                        text: TextSpan(
                          text: 'Release ',
                          style: poppinsRegular(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: movieItem[0].getReleaseDateISO.isEmpty ? 'None' : movieItem[0].getReleaseDateISO,
                              style: poppinsRegular(color: ThemeColor.primaryGrey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      );
    });
  }
}
