import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telescope_phone_v2/presentation/widgets/vertical_chart_screen.dart';
import '../../core/styles/color_constants.dart';
import '../../data/models/kpiInfo.dart';

class DynamicLineChart extends StatelessWidget {
  final List<String> days; // List of string days
  final List<double> values;
  final List<String?> events;
  final KpiInfo kpiitem;


  const DynamicLineChart({
    super.key,
    required this.days, // Use a provided list of days
    required this.values,
    required this.events,
    required this.kpiitem,

  });
  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  }

  List<FlSpot> generateFlSpots(List<String> days, List<double> values) {
    int n = values.length;

    // Ensure the number of days matches the values
    if (days.length != n) {
      throw Exception("The number of days must match the number of values.");
    }

    return List.generate(n, (index) {
      double x = index.toDouble(); // X-axis is the index
      double y = values[index]; // Y-axis is the value
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

    List<FlSpot> points = generateFlSpots(days, values);

    // Calculate the maximum value for the chart
    final maxY = values.reduce((a, b) => a > b ? a : b);

    return GestureDetector(
        onDoubleTap: () {
      // Navigate to the vertical chart screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerticalChartScreen(
            days: days,
            values: values,
            events: events,
            kpiItem: kpiitem,

          ),
        ),
      );
    },

     child:  SizedBox(
      height: 300,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              preventCurveOverShooting: true,
              color: Theme
                  .of(context)
                  .brightness == Brightness.dark
                  ? AppColors.secondary
                  : AppColors.primary,
              dotData: const FlDotData(show: false),
              spots: points,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: Theme
                      .of(context)
                      .brightness == Brightness.dark
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
              //sideTitles: _bottomTitles(getRepresentativeDays(days)),
              sideTitles: _bottomTitles((days)),
            ),
            leftTitles: AxisTitles(
              sideTitles: _leftTitles(values),
            ),
            topTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          minY: 0,
          // Force the Y-axis to start from 0
          maxY: maxY,
          // Set the maximum value dynamically
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor:
              Theme
                  .of(context)
                  .brightness == Brightness.dark
                  ? AppColors.secondary
                  : AppColors.primary,
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              tooltipRoundedRadius: 8,
              tooltipPadding: const EdgeInsets.all(10),
              tooltipMargin: 10,
              getTooltipItems: (touchedSpots) =>
                  touchedSpots.map((spot) {
                    return LineTooltipItem(
                      '${ formatDate(days[spot.spotIndex])}\n${spot.y} ${kpiitem.kpiUnit}',
                      TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme
                              .of(context)
                              .brightness == Brightness.dark
                              ? AppColors.lightTextColor
                              : AppColors.darkTextColor),
                    );
                  }).toList(),
            ),
          ),
        ),
      ),
    ));
  }


  SideTitles _bottomTitles(List<String> days) {
      double fontSize = 12.0;

      // Adjust font size based on the number of days
      if (days.length > 10) {
        fontSize = 10.0;  // Decrease font size if more than 10 days
      } else if (days.length > 6) {
        fontSize = 11.0;  // Slightly decrease font size if there are more than 6 days
      }

      return SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          if (value >= 0 && value == value.toInt() && value < days.length) {
            // For 3 days or less, show all days
            if (days.length <= 3 || value % 2 == 0 || value == days.length - 1) {
              String date = days[value.toInt()];

              // Remove time part if it exists (split by 'T')
              date = date.split('T')[0];

              // Split the date and extract day and month
              List<String> dateParts = date.split('-');
              String day = dateParts[2]; // Day part of the date
              String month = dateParts[1]; // Month part of the date

              // Format as "dd/mm"
              return Text(
                '$day/$month',
                style: TextStyle(fontSize: fontSize),
              );
            }

            // Return an empty string if the title is skipped
            return const Text('');
          }
          return const Text('');
        },
      );
    }

  SideTitles _leftTitles(List<double> values) {
    // Calculate the maximum value from the dataset
    final maxY = values.reduce((a, b) => a > b ? a : b);
    final interval = maxY / 4; // Divide maxY into 4 intervals (5 titles)

    return SideTitles(
      showTitles: true,
      reservedSize: 40,
      interval: interval, // Use the calculated interval
      getTitlesWidget: (value, meta) {
        // Show titles only at interval steps starting from 0
        if (value % interval == 0 && value <= maxY) {
          return Text(
            "${value.toStringAsFixed(1)}  ${kpiitem.kpiUnit}", // Format value to 1 decimal place
            style: const TextStyle(fontSize: 12),
          );
        }
        return const SizedBox.shrink(); // Hide unnecessary titles
      },
    );
  }
}
