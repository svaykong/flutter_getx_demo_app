import 'package:flutter/material.dart';
import 'package:flutter_getx_demo_app/themes/app_text_theme.dart';

class HeadingSection extends StatelessWidget {
  const HeadingSection({
    super.key,
    required this.headingName,
    required this.onSeeAllPressed,
  });

  final String headingName;
  final VoidCallback onSeeAllPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headingName,
            style: poppinsRegular(
              fontSize: 18.0,
            ),
          ),
          TextButton(
            onPressed: onSeeAllPressed,
            child: Text(
              'See All',
              style: poppinsRegular(
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
