import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

import '../themes/app_text_theme.dart';
import '../routes/app_routes.dart';
import '../themes/colors_theme.dart';
import '../utils/constants.dart';
import '../models/movie_model.dart';
import '../shared_widgets/round_progress_bar.dart';

class HorizontalViewSection extends StatelessWidget {
  const HorizontalViewSection({
    super.key,
    required this.movies,
  });

  final List<ResultModel> movies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.35,
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          scrollDirection: Axis.horizontal,
          itemCount: movies.isEmpty ? 5 : movies.length,
          itemBuilder: (ctx, index) {
            if (movies.isEmpty) {
              return Card(
                margin: const EdgeInsets.only(right: 8.0),
                elevation: 2.0,
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  height: Get.height * 0.30,
                  width: Get.width * 0.5,
                ),
              );
            }

            return Stack(
              children: [
                SizedBox(
                  width: Get.width * 0.5,
                  child: Card(
                    margin: const EdgeInsets.only(right: 8.0),
                    elevation: 2.0,
                    clipBehavior: Clip.antiAlias,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.movieDetails, arguments: [movies[index].id]);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CachedNetworkImage(
                              placeholder: (_, __) => Container(color: Colors.grey[300]),
                              imageUrl: '$imageBaseUrl${movies[index].backdropPath}',
                              fit: BoxFit.cover,
                              width: Get.width * 0.6,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 20.0),
                            child: Text(
                              movies[index].originalTitle,
                              textAlign: TextAlign.start,
                              style: poppinsRegular(
                                fontWeight: FontWeight.w700
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                            child: Text(
                              movies[index].getReleaseDateISO,
                              textAlign: TextAlign.start,
                              style: poppinsRegular(
                                color: ThemeColor.secondaryDarkGrey,
                                fontSize: 14.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: Get.height * 0.08,
                  left: 5,
                  child: RoundProgressBar(
                    percent: movies[index].votPercent,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
