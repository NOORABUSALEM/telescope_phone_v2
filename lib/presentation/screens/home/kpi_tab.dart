import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telescope_phone_v2/data/models/kpiInfo.dart';
import '../../../data/cubits/kpiInfo_cubit/kpi_info_cubit.dart';
import '../../../data/cubits/search_cubit/search_bar_cubit.dart';
import '../../components/kpiCard.dart';

class DailyKpis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KpiInfoCubit, KpiInfoState>(
      builder: (context, state) {
        if (state is KpiInfoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is KpiInfoSuccess) {
          return DailyKpisView(kpiList: state.kpiList);
        } else {
          return const Center(child: Text("Error loading KPIs"));
        }
      },
    );
  }
}

class DailyKpisView extends StatelessWidget {
  DailyKpisView({super.key, required List<KpiInfo> kpiList});

  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // Helper method to load the display status of a specific KPI
  bool _isKpiDisplayed(String kpiId) {
    return sharedPreferences?.getBool(kpiId) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    if (DailyKpisView.sharedPreferences == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<KpiInfoCubit>().fetchKpiInfo();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(16),
            BlocBuilder<SearchBarCubit, SearchBarState>(
              builder: (context, searchState) {
                return BlocBuilder<KpiInfoCubit, KpiInfoState>(
                  builder: (context, kpiState) {
                    context.read<KpiInfoCubit>();
                    if (kpiState is KpiInfoLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (kpiState is KpiInfoSuccess) {
                      final searchQuery =
                      searchState.searchQuery.toLowerCase();

                      final kpiInfoList = kpiState.kpiList
                          .where((item) => item
                          .getLocalizedName(context)
                          .toLowerCase()
                          .contains(searchQuery))
                          .toList();

                      final filteredKpis =
                      _filterDisplayedKpis(kpiInfoList);

                      return Expanded(
                        child: ListView.separated(
                          itemCount: filteredKpis.length,
                          itemBuilder: (context, index) {
                            final kpiItem = kpiInfoList[index];

                            return KpiCard(kpiItem: kpiItem);
                          },
                          separatorBuilder: (context, index) =>
                          const Gap(16),
                        ),
                      );
                    }
                    if (kpiState is KpiInfoError) {
                      return const Center(
                        child: Text("error"),
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
    );
  }


  List<KpiInfo> _filterDisplayedKpis(List<KpiInfo> kpiList) {
    List<KpiInfo> displayedKpis = [];
    for (var kpi in kpiList) {
      bool isDisplayed = _isKpiDisplayed(kpi.id.toString());
      if (isDisplayed) {
        displayedKpis.add(kpi);
      }
    }
    return displayedKpis;
  }
}
