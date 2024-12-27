import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:telescope_phone_v2/data/models/kpiInfo.dart';
import 'package:telescope_phone_v2/presentation/components/presenteg.dart';

import '../../core/styles/color_constants.dart';
import '../routers/app_routes.dart';

class KpiCard extends StatelessWidget {
  final KpiInfo kpiItem;

  KpiCard({super.key, required this.kpiItem});

  @override
  Widget build(BuildContext context) {
    List<FlSpot> spots = _generateChartData(kpiItem.kpiData!.dataList[0]);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.kpiStatistics, arguments: kpiItem);
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
                      kpiItem.getLocalizedName(context),
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
                      kpiItem.kpiData!.value.first.data.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    PercentageWidget(percentage: kpiItem.kpiData!.compilationData[0],
                    )
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
                        spots: spots,
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


List<FlSpot> _generateChartData(List<double> values) {
  // Assuming last7Days contains a list of 7 double values representing the KPI for each day


  // Ensure there are 7 values in the list, or handle cases where data is missing


  // Create a list of FlSpot for the chart using the last 7 days of data
  return List.generate(values.length, (index) {
    // The x-axis represents the day (index 0 = 7 days ago, index 6 = today)
    // The y-axis is the corresponding KPI value
    return FlSpot(index.toDouble(), values[index]);
  });
}
