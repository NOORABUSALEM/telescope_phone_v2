import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:telescope_phone_v2/core/extensions/translation_extension/Translation_extension.dart';
import 'package:telescope_phone_v2/data/models/kpiInfo.dart';
import '../../core/styles/color_constants.dart';

class VerticalChartScreen extends StatefulWidget {
  final List<String> days;
  final List<String?> events;
  final List<double> values;
  final KpiInfo kpiItem;


  const VerticalChartScreen({
    super.key,
    required this.days,
    required this.values,
    required this.events,
    required this.kpiItem,

  });

  @override
  _VerticalChartScreenState createState() => _VerticalChartScreenState();
}

class _VerticalChartScreenState extends State<VerticalChartScreen> {
  String _selectedEvent = '';
  String _selectedData = '';
  String _selectedDay = '';

  List<FlSpot> generateFlSpots(List<String> days, List<double> values) {
    return List.generate(
        values.length, (index) => FlSpot(index.toDouble(), values[index]));
  }

  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    List<FlSpot> points = generateFlSpots(widget.days, widget.values);

    // Calculate the min and max values
    final maxY = widget.values.reduce((a, b) => a > b ? a : b);
    final minY = widget.values.reduce((a, b) => a < b ? a : b);

    return Scaffold(
      appBar: AppBar(title:  Text(
      "${ (context).trans("the events of the")} ${widget.kpiItem.getLocalizedName(context)}",
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: RotatedBox(
            quarterTurns: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0), // Add right padding
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Line Chart
                  SizedBox(
                    height: 500, // Increased height
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: points,
                            isCurved: true,
                            preventCurveOverShooting: true,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppColors.secondary
                                : AppColors.primary,
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) {
                                return FlDotCirclePainter(
                                  radius: 4,
                                  color: widget.events[index] != null
                                      ? Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppColors.primary
                                          : AppColors.secondary
                                      : AppColors.greyColor,
                                  strokeWidth: 0,
                                );
                              },
                            ),
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: Theme.of(context).brightness ==
                                        Brightness.dark
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
                          border: const Border(
                            bottom: BorderSide(),
                            left: BorderSide(),
                            right: BorderSide(width: 0),
                          ),
                        ),
                        gridData: const FlGridData(show: false),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: _bottomTitles(widget.days),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: _leftTitles(widget.values, widget.kpiItem.kpiUnit!),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        extraLinesData: ExtraLinesData(
                          horizontalLines: [
                            HorizontalLine(
                              y: maxY,
                              color: Colors.green,
                              strokeWidth: 2,
                              dashArray: [5, 5],
                            ),
                            HorizontalLine(
                              y: minY,
                              color: Colors.red,
                              strokeWidth: 2,
                              dashArray: [5, 5],
                            ),
                          ],
                        ),
                        minY: 0,
                        maxY: maxY * 1.1, // Add margin at the top
                        lineTouchData: LineTouchData(
                          touchCallback: (FlTouchEvent event,
                              LineTouchResponse? touchResponse) {
                            if (touchResponse != null &&
                                touchResponse.lineBarSpots != null) {
                              final spot = touchResponse.lineBarSpots!.first;
                              setState(() {
                                _selectedEvent =
                                    widget.events[spot.spotIndex] ?? (context).trans("No event");
                                _selectedData = '${spot.y} ${widget.kpiItem.kpiUnit}';
                                _selectedDay =
                                    formatDate(widget.days[spot.spotIndex]);
                              });
                            }
                          },
                          touchTooltipData: LineTouchTooltipData(
                            tooltipBgColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppColors.secondary
                                    : AppColors.primary,
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots.map((spot) {
                                final event = widget.events[spot.spotIndex];
                                return LineTooltipItem(
                                  '${formatDate(widget.days[spot.spotIndex])}\n${spot.y} ${widget.kpiItem.kpiUnit}',
                                  TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppColors.lightTextColor
                                        : AppColors.darkTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }).toList();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Min and Max Labels
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      // Reduce space
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // Center align
                      children: [
                        // Min Label
                        Text(
                          "${(context).trans("Min")}: $minY ${widget.kpiItem.kpiUnit}",
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Add some space between labels
                        // Max Label
                        Text(
                          "${(context).trans("Max")}: $maxY ${widget.kpiItem.kpiUnit}",
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Box under the chart
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 30.0),
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.secondary
                          : AppColors.primary,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${(context).trans("The Day")}: $_selectedDay',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).brightness ==
                                    Brightness.dark
                                ? AppColors.lightTextColor
                                : AppColors.darkTextColor,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          '${(context).trans("The Value")}: $_selectedData ${widget.kpiItem.kpiUnit}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).brightness ==
                                    Brightness.dark
                                ? AppColors.lightTextColor
                                : AppColors.darkTextColor,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          '${(context).trans("The Event")}: $_selectedEvent',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).brightness ==
                                    Brightness.dark
                                ? AppColors.lightTextColor
                                : AppColors.darkTextColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SideTitles _bottomTitles(List<String> days) {
    double fontSize = days.length > 10 ? 10.0 : (days.length > 6 ? 11.0 : 12.0);

    return SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        if (value >= 0 && value == value.toInt() && value < days.length) {
          String date = formatDate(days[value.toInt()]);
          return Text(date, style: TextStyle(fontSize: fontSize));
        }
        return const SizedBox.shrink();
      },
    );
  }

  SideTitles _leftTitles(List<double> values, String unit) {
    final maxY = values.reduce((a, b) => a > b ? a : b);
    final interval = maxY / 4;

    return SideTitles(
      showTitles: true,
      reservedSize: 40,
      interval: interval,
      getTitlesWidget: (value, meta) {
        if (value % interval == 0 && value <= maxY) {
          return Text(
            "${value.toStringAsFixed(1)} $unit",
            style: const TextStyle(fontSize: 12),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}