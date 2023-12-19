import 'package:flutter/material.dart';

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
          ),
          TextButton(
            onPressed: onSeeAllPressed,
            child: const Text(
              'See All',
            ),
          ),
        ],
      ),
    );
  }
}
