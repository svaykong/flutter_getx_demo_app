import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

class RoundProgressBar extends StatelessWidget {
  const RoundProgressBar({
    super.key,
    required this.percent,
  });

  final int percent;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 30.0,
      lineWidth: 5.0,
      center: Container(
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blueGrey[900],
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          '$percent%',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade600,
      progressColor: Colors.orange,
      percent: percent / 100,
    );
  }
}
