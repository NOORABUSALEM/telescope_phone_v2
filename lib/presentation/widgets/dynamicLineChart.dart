import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/styles/color_constants.dart';

class DynamicLineChart extends StatelessWidget {
  DateTime day;

  List<double> values;

  DynamicLineChart({super.key, required this.day, required this.values});

  List<String> getLastNDays(DateTime givenDate, int n) {
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    return List.generate(
      n,
      (index) =>
          dateFormat.format(givenDate.subtract(Duration(days: n - 1 - index))),
    );
  }

  List<FlSpot> generateFlSpots(DateTime day, List<double> values) {
    int n = values.length;
    List<String> days = getLastNDays(day, n);

    return List.generate(n, (index) {
      double x = index.toDouble();
      double y = values[index];
      print('Date: ${days[index]}, Value: $y');
      return FlSpot(x, y);
    });
  }

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    if (route == null) {
      return const Center(child: Text('No data available'));
    }

    List<FlSpot> points = generateFlSpots(day, values);

    return SizedBox(
      height: 300,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              preventCurveOverShooting: true,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.secondary
                  : AppColors.primary,
              dotData: const FlDotData(show: false),
              spots: points,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: Theme.of(context).brightness == Brightness.dark
                      ? [
                          AppColors.secondary.withOpacity(0.3),
                          AppColors.darkCardColor.withOpacity(0.3)
                        ]
                      : [
                          AppColors.primary.withOpacity(0.3),
                          AppColors.lightCardColor.withOpacity(0.3)
                        ],
                ),
              ),
            ),
          ],
          borderData: FlBorderData(
            border: const Border(bottom: BorderSide(), left: BorderSide()),
          ),
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: _bottomTitles(getLastNDays(day, values.length)),
            ),
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (LineBarSpot spot) =>
                  Theme.of(context).brightness == Brightness.dark
                      ? AppColors.secondary
                      : AppColors.primary,
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              tooltipRoundedRadius: 8,
              tooltipPadding: const EdgeInsets.all(10),
              tooltipMargin: 10,
              getTooltipItems: (touchedSpots) => touchedSpots.map((spot) {
                return LineTooltipItem(
                  'Value: ${spot.y}',
                  TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.lightTextColor
                          : AppColors.darkTextColor),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  SideTitles _bottomTitles(List<String> days) {
    return SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        if (value >= 0 && value == value.toInt() && value < days.length) {
          String date = days[value.toInt()];
          return Text(
            date.split('-').sublist(0, 2).join('/'),
            style: const TextStyle(fontSize: 12),
          );
        }
        return const Text('');
      },
    );
  }
}
