import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:telescope_phone_v2/data/models/kpiInfo.dart';
import '../../core/styles/color_constants.dart';
import '../../data/models/kpi_model.dart';
import '../routers/app_routes.dart';

class KpiCard extends StatelessWidget {
  final KpiInfo kpiData;

  KpiCard({super.key, required this.kpiData});

  @override
  Widget build(BuildContext context) {
    //List<FlSpot> spots = _generateChartData(kpiData);

    return GestureDetector(
      onTap: () {
        //Navigator.pushNamed(context, AppRoutes., arguments: kpiData);
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Rectangle 30.png")),
        ),
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "data 1",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: AppColors.greyColor,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      //kpiData.formatNumberWithCommas(kpiData.value.toInt()),
                      "value",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // PercentageWidget(
                    //   currentValue: kpiData.difference?.toDouble() ?? 0,
                    //   devidedValue: kpiData.value,
                    //)
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: LineChart(LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        isCurved: true,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.secondary
                            : AppColors.primary,
                        dotData: const FlDotData(show: false),
                       // spots: spots,
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
                    lineTouchData: const LineTouchData(
                      enabled: false,
                    ),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Helper method to generate FlSpot values from dailyData
//List<FlSpot> _generateChartData(KpiDailyData dailyData) {
  // Assuming last7Days contains a list of 7 double values representing the KPI for each day
  //List<double> values = dailyData.last7Days;

  // Ensure there are 7 values in the list, or handle cases where data is missing
  //if (values.length != 7) {
   // throw Exception('The last7Days list must contain exactly 7 values.');
  //}

  // Create a list of FlSpot for the chart using the last 7 days of data
  //return List.generate(values.length, (index) {
    // The x-axis represents the day (index 0 = 7 days ago, index 6 = today)
//     // The y-axis is the corresponding KPI value
//     return FlSpot(index.toDouble(), values[index]);
//   });
// }
