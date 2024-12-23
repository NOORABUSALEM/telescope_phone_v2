import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/cubits/kpi_cubit/kpi_cubit.dart';
import '../../../data/cubits/kpi_cubit/kpi_state.dart';
import '../../../data/cubits/search_cubit/search_bar_cubit.dart';
import '../../../data/providers/kpi_provider.dart';
import '../../../data/providers/kpiinfo_providers.dart';
import '../../../data/repos/kpiInfo_repository.dart';
import '../../../data/repos/kpi_repository.dart';
import '../../components/kpiCard.dart';

class KpisTabView extends StatelessWidget {
  const KpisTabView({super.key});

  static SharedPreferences? sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // Helper method to load the display status of a specific KPI
  static bool _isKpiDisplayed(String kpiId) {
    return sharedPreferences!.getBool(kpiId) ?? false; // Return false if not saved
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => KpiCubit(
            KpiInfoRepository(
              provider: KpiInfoProvider(),
            ),
          )..fetchKpis(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("KPIs"),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<KpiCubit>().fetchKpis();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const Gap(16),
                BlocBuilder<SearchBarCubit, SearchBarState>(
                  builder: (context, searchState) {
                    return BlocBuilder<KpiCubit, KpiState>(
                      builder: (context, kpiState) {
                        if (kpiState is KpiLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (kpiState is KpiLoaded) {
                          final kpiList = kpiState.kpis;
                          return Expanded(
                            child: ListView.separated(
                              itemCount: kpiList.length,
                              itemBuilder: (context, index) {
                                final kpi = kpiList[index];
                                return KpiCard(kpiData: kpi);
                              },
                              separatorBuilder: (context, index) => const Gap(16),
                            ),
                          );
                        }

                        if (kpiState is KpiError) {
                          return const Center(
                            child: Text("Failed to load KPIs"),
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
