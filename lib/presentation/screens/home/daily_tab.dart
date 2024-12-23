// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../data/cubits/kpi_cubit/kpi_cubit.dart';
// import '../../../data/cubits/kpi_cubit/kpi_state.dart';
// import '../../../data/cubits/search_cubit/search_bar_cubit.dart';
// import '../../../data/providers/kpi_provider.dart';
// import '../../../data/repos/kpi_repository.dart';
// import '../../components/kpiCard.dart';
//
//
// class DailyKpisView extends StatelessWidget {
//   DailyKpisView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => KpiCubit(
//             KpiRepository(
//               provider:  KpiProvider(),
//             ),
//           )..fetchKpis(),
//         )
//       ],
//       child: DailyKpisView(),
//     );
//   }
// }
//
// class DailyKpisView extends StatelessWidget {
//   DailyKpisView({super.key});
//
//   static SharedPreferences? sharedPreferences;
//
//   static init() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//   }
//
//   // Helper method to load the display status of a specific KPI
//   static bool _isKpiDisplayed(String kpiId) {
//     return sharedPreferences!.getBool(kpiId) ??
//         false; // Return false if not saved
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () async {
//         context.read<KpiCubit>().getDailyKpis();
//       },
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Gap(16),
//             BlocBuilder<SearchBarCubit, SearchBarState>(
//               builder: (context, searchState) {
//                 return BlocBuilder<KpiCubit, KpiState>(
//                   builder: (context, kpiState) {
//                     context.read<KpiCubit>();
//                     if (kpiState is KpiLoading) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//
//                     if (kpiState is KpiLoaded) {
//                       // final searchQuery = searchState.searchQuery.toLowerCase();
//                       //
//                       // final kpiDailyDataList = kpiState.kpis
//                       //     .where((item) =>
//                       //     item.kpiInfo.getLocalizedName(context)!
//                       //         .toLowerCase()
//                       //         .contains(searchQuery))
//                       //     .toList();
//                       //
//                       // final filteredKpis =
//                       // _filterDisplayedKpis(kpiDailyDataList);
//                        final kpiDailyDataList =kpiState.kpis;
//                       return Expanded(
//                         child: ListView.separated(
//                           itemCount: kpiDailyDataList.length,
//                           itemBuilder: (context, index) {
//                             final kpiDailyDataItem = kpiDailyDataList[index];
//
//                             return KpiCard(kpiData: kpiDailyDataItem,);
//                           },
//                           separatorBuilder: (context, index) => const Gap(16),
//                         ),
//                       );
//                     }
//                     if (kpiState is KpiError) {
//                       return const Center(
//                         child: Text("error"),
//                       );
//                     }
//                     return const SizedBox.shrink();
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// //   List<KpiDailyData> _filterDisplayedKpis(List<KpiDailyData> kpiList) {
// //     List<KpiDailyData> displayedKpis = [];
// //     for (var kpi in kpiList) {
// //       bool isDisplayed = _isKpiDisplayed(kpi.kpiInfo.id.toString());
// //       if (isDisplayed) {
// //         displayedKpis.add(kpi);
// //       }
// //     }
// //     return displayedKpis;
// //   }
// // }
