import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:telescope_phone_v2/core/extensions/translation_extension/Translation_extension.dart';
import 'package:telescope_phone_v2/data/models/kpiInfo.dart';
import '../../../core/styles/color_constants.dart';
import '../../components/customSwitcher.dart';
import '../../components/presenteg.dart';
import '../../components/targetComponent.dart';
import '../../routers/app_routes.dart';
import '../../widgets/dynamicLineChart.dart';
import 'package:share_plus/share_plus.dart';


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
    if(kpiItem.periodicity=='monthly') {
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
            DynamicLineChart(days:kpiItem.kpiData!.dataList[0].dates, values: kpiItem.kpiData!.dataList[0].data, unit: kpiItem.kpiUnit??"", events: kpiItem.kpiData!.dataList[0].events ,);
        break;
      case 1:
        selectedChart =
            DynamicLineChart(days:kpiItem.kpiData!.dataList[1].dates, values: kpiItem.kpiData!.dataList[1].data, unit: kpiItem.kpiUnit??"", events:kpiItem.kpiData!.dataList[1].events ,);
        break;
      default:
        selectedChart =
            DynamicLineChart(days:kpiItem.kpiData!.dataList[2].dates, values: kpiItem.kpiData!.dataList[2].data, unit: kpiItem.kpiUnit??"", events: kpiItem.kpiData!.dataList[2].events ,);
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
            onPressed: () async {
              // Show a menu with two options
              final result = await showMenu<int>(
                context: context,
                position: RelativeRect.fromLTRB(100.0, 100.0, 0.0, 0.0),  // Adjust position as needed
                items: [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Row(
                      children: const [
                        Icon(Icons.settings),
                        SizedBox(width: 8),
                        Text('KPI Settings'),
                      ],
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Row(
                      children: const [
                        Icon(Icons.share),
                        SizedBox(width: 8),
                        Text('Share'),
                      ],
                    ),
                  ),
                ],
              );

              // Perform action based on user selection
              if (result == 0) {
                // Navigate to KPI Settings page
                Navigator.pushNamed(
                  context,
                  AppRoutes.kpiSettings,
                  arguments: kpiItem,
                );
              } else if (result == 1) {
                // Share the text content (e.g., KPI details)
                String shareText = """
                    ${kpiItem.nameEn}
                  
                    Day: ${kpiItem.kpiData?.value.date}
                    Value: ${kpiItem.kpiData?.value.data}  ${kpiItem.kpiUnit}
                  
                    Difference from the last update: ${kpiItem.kpiData?.compilationData.first}%
                  
                   Achieved Target: ${kpiItem.target?.last.percentageAchieved}%
                 
                    Telescope: Your data in your space
                    """;

                try {
                  // Share the content and check if sharing was successful
                  await Share.share(shareText);

                  // You can simulate a success message here
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Success'),
                      content: Text('Content shared successfully!'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                } catch (e) {
                  print("Error while sharing: $e");  // Print the actual error
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Failed to share the content. Error: $e'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              }
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

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  kpiItem.target!.length,
                      (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: TargetComponent(
                      percentageAchieved:  kpiItem.target![index].percentageAchieved?.toDouble() ??0.0,
                      title: "You Have Achieved in the ${kpiItem.target![index].quarter}",
                      subtitle: "Of Your Target : ${kpiItem.target![index].target} ${kpiItem.kpiUnit}",
                    ),
                  ),
                ),
              ),
            ),
                const Gap(40),
                Divider(),
                //_buildRelatedKPIs(context,kpiItem)
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
                label: (kpiItem.periodicity=='daily')?(context).trans("Last Day"):(context).trans("Last Month"),
                value: kpiItem.kpiData!.compilationData[0]),
            const _buildDivider(),
            MetricRow(
                label: (kpiItem.periodicity=='daily')?(context).trans("Last Week"):(context).trans("Quarter Average"),
                value: kpiItem.kpiData!.compilationData[1]),
            const _buildDivider(),
            MetricRow(
                label: (kpiItem.periodicity=='daily')?(context).trans("Month Average"):(context).trans("Year Average"),
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
