import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:telescope_phone_v2/core/extensions/translation_extension/Translation_extension.dart';
import 'package:telescope_phone_v2/data/models/kpiInfo.dart';
import '../../../core/styles/color_constants.dart';
import '../../components/customSwitcher.dart';
import '../../components/presenteg.dart';
import '../../routers/app_routes.dart';
import '../../widgets/dynamicLineChart.dart';

class KpiStatistics extends StatefulWidget {
  const KpiStatistics({super.key});

  @override
  _KpiStatisticsState createState() => _KpiStatisticsState();
}

class _KpiStatisticsState extends State<KpiStatistics> {
  int _currentSelection = 0;

  @override
  Widget build(BuildContext context) {

    final KpiInfo kpiItem =
        ModalRoute.of(context)!.settings.arguments  as KpiInfo;

    List<String> switcherOptions = [];
    if(kpiItem.type=='monthly') {
      switcherOptions = [
        (context).trans("Quarterly"),
        (context).trans("Yearly"),
        (context).trans("All")
      ];
    }else{
      switcherOptions = [
        (context).trans("Weekly"),
        (context).trans("Monthly"),
        (context).trans("All")
      ];
    }
    Widget selectedChart;
    switch (_currentSelection) {
      case 0:
        selectedChart =
            DynamicLineChart(day:DateTime.parse(kpiItem.kpiData!.value[0].date) , values: kpiItem.kpiData!.dataList[0]);
        break;
      case 1:
        selectedChart =
            DynamicLineChart(day: DateTime.parse(kpiItem.kpiData!.value[0].date), values: kpiItem.kpiData!.dataList[1]);
        break;
      default:
        selectedChart =
            DynamicLineChart(day: DateTime.parse(kpiItem.kpiData!.value[0].date), values: kpiItem.kpiData!.dataList[2]);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(kpiItem.getLocalizedName(context)),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
              icon: const Icon(
                Icons.info_outline,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.aboutKpi,
                  arguments: kpiItem,
                );
              }),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.kpiSettings,
                arguments: kpiItem,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Gap(40),
                SizedBox(height: 300, child: selectedChart),
                // Display selected chart
                const Gap(20),
                CustomSwitcher(
                  options: switcherOptions,
                  onSelectionChanged: (index) {
                    setState(() {
                      _currentSelection = index;
                    });
                  },
                ),
                const Gap(20),
                MetricsCard(),
                const Gap(30),
                Text(
                  (context).trans("You Have Achieved"),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Gap(10),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: (kpiItem.target?.toDouble()  )
                              ?.clamp(0.0, 1.0),
                          strokeWidth: 8,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.secondary
                              : AppColors.primary,
                        ),
                      ),
                      Text(
                        '${(( (kpiItem.target ?? 1)) * 100).toStringAsFixed(1)}%',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                Text(
                  (context).trans("Of Your Target"),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Gap(40),
                Divider(),
                _buildRelatedKPIs(context,kpiItem)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _buildDivider extends StatelessWidget {
  const _buildDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Divider(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.backgroundColor
            : AppColors.greyColor,
        thickness: 1,
      ),
    );
  }
}

class MetricRow extends StatelessWidget {
  final String label;
  final double value;


  const MetricRow(
      {super.key,
      required this.label,
      required this.value,
     });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        PercentageWidget(percentage: value,

        )
      ],
    );
  }
}

class MetricsCard extends StatelessWidget {
  MetricsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     final KpiInfo kpiItem =
         ModalRoute.of(context)!.settings.arguments as KpiInfo;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.lightTextColor
          : AppColors.lightGreyColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            MetricRow(
                label: (kpiItem.periodicity=='daily')?(context).trans("Last Day"):(context).trans("You Have Achieved"),
                value: kpiItem.kpiData!.compilationData[0]),
            const _buildDivider(),
            MetricRow(
                label: (kpiItem.periodicity=='daily')?(context).trans("Last Week"):(context).trans("You Have Achieved"),
                value: kpiItem.kpiData!.compilationData[1]),
            const _buildDivider(),
            MetricRow(
                label: (kpiItem.periodicity=='daily')?(context).trans("Month Average"):(context).trans("You Have Achieved"),
                value: kpiItem.kpiData!.compilationData[2]),
          ],
        ),
      ),
    );
  }
}

Widget _buildRelatedKPIs(BuildContext context, KpiInfo kpiItem) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        (context).trans("Related KPIs"),
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      // Use map() to convert each item into a widget and toList() to convert to a List
      ...kpiItem.relatedKpis?.map((item) => _buildKpiRow(context, item)) ?? [],
    ],
  );
}

Widget _buildKpiRow(BuildContext context, RelatedKpi relatedKpi) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          relatedKpi.getLocalizedName(context),
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkTextColor
                : AppColors.lightTextColor,
          ),
        ),
      ],
    ),
  );
}
