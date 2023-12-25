import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

import '../themes/colors_theme.dart';

class RoundProgressBar extends StatelessWidget {
  const RoundProgressBar({
    super.key,
    required this.percent,
  });

  final int percent;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: Get.height * 0.04,
      lineWidth: 5.0,
      center: Container(
        height: Get.height * 0.07,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: ThemeColor.primaryColor,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          '$percent%',
          style: const TextStyle(
            color: ThemeColor.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      backgroundColor: ThemeColor.primaryDarkGrey,
      progressColor: ThemeColor.primaryYellow,
      percent: percent / 100,
    );
  }
}
