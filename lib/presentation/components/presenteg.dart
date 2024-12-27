import 'package:flutter/material.dart';

import '../../core/styles/color_constants.dart';

class PercentageWidget extends StatelessWidget {
   final double percentage;

    PercentageWidget({
     Key? key,
     required double percentage,
   })  : percentage = double.parse(percentage.toStringAsFixed(2)), // Format the percentage to 2 decimal places
         super(key: key);

  Color getColor(double percentage) {
    if (percentage > 0) {
      return AppColors.upArrowColor;
    } else if (percentage < 0) {
      return AppColors.downArrowColor;
    } else {
      return AppColors.greyColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          percentage > 0
              ? Icons.arrow_upward
              : (percentage < 0 ? Icons.arrow_downward : Icons.horizontal_rule),
          color: getColor(percentage),
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          "$percentage %",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: getColor(percentage),
          ),
        ),
      ],
    );
  }
}
