import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../shared_widgets/round_progress_bar.dart';
import '../../themes/app_text_theme.dart';
import '../../themes/colors_theme.dart';
import '../../utils/constants.dart';
import '../../models/movie_model.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.result,
  });

  final ResultModel result;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.movieDetails, arguments: [result.id]);
        },
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  placeholder: (_, __) => Container(color: Colors.grey[100]),
                  imageUrl: '$imageBaseUrl${result.backdropPath}',
                  fit: BoxFit.cover,
                  height: Get.height * 0.30,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 20.0),
                  child: Text(
                    result.originalTitle,
                    textAlign: TextAlign.start,
                    style: poppinsRegular(fontWeight: FontWeight.w700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Text(
                    result.getReleaseDateISO,
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
                percent: result.votPercent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
