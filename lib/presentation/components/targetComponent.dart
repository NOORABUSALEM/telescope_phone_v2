import 'package:flutter/material.dart';

import '../../core/styles/color_constants.dart';

class TargetComponent extends StatelessWidget {
  final double percentageAchieved;
  final String title;
  final String subtitle;

  const TargetComponent({
    Key? key,
    required this.percentageAchieved,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18, // Larger font size for the title
          ),
        ),
        const SizedBox(height: 20), // More space below the title
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 150, // Increased width
                height: 150, // Increased height
                child: CircularProgressIndicator(
                  value: percentageAchieved/100,
                  strokeWidth: 10, // Thicker stroke
                  color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.secondary
                        : AppColors.primary,
                    ),
          ),
              Text(
                "${(percentageAchieved)}%", // Show percentage
                style: const TextStyle(
                  fontSize: 28, // Larger font size for percentage
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20), // More space below the circular progress
        Text(
          subtitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16, // Larger font size for the subtitle
          ),
        ),
      ],
    );
  }
}
