import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telescope_phone_v2/core/extensions/translation_extension/Translation_extension.dart';
import 'package:telescope_phone_v2/data/models/kpiInfo.dart';

import '../../../data/cubits/kpiInfo_cubit/kpi_info_cubit.dart';
import '../../../data/cubits/search_cubit/search_bar_cubit.dart';
import '../../components/kpiCard.dart';
import '../../components/show_filter_component.dart';

class KpisScreen extends StatefulWidget {
  final String type;
  final String? selectedPositive;
  final String? selectedType;
  const KpisScreen({
  super.key,
  required this.type, this.selectedPositive, this.selectedType,
  });

  @override
  State<KpisScreen> createState() => _KpisScreenState();
}

class _KpisScreenState extends State<KpisScreen> {

   String? selectedPositive;
   String? selectedType;

   void _applyFilters(String? positive, String? type) {
     setState(() {
       selectedPositive = positive;
       selectedType = type;
     });
   }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KpiInfoCubit, KpiInfoState>(
      builder: (context, state) {
        if (state is KpiInfoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is KpiInfoSuccess) {
          return KpisView(
            kpiList: state.kpiList,
            type: widget.type,
            selectedPositive: selectedPositive,
            selectedType: selectedType,
            onApplyFilters: _applyFilters,
          );
        } else {
          return const Center(child: Text("Error loading KPIs"));
        }
      },
    );
  }
}

class KpisView extends StatelessWidget {
  final String type;
  final String? selectedPositive;
  final String? selectedType;
  final List<KpiInfo> kpiList;
  final Function(String?, String?) onApplyFilters;


  const KpisView({
    super.key,
    required this.type,
    required this.kpiList,
    this.selectedPositive,
    this.selectedType,
    required this.onApplyFilters,
  });

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
    if (KpisView.sharedPreferences == null) {
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
                      final searchQuery = searchState.searchQuery.toLowerCase();

                      // Combine all filtering logic here
                      final filteredKpis = kpiState.kpiList.where((item) {
                        final matchesPeriodicity = item.periodicity == type;
                        final matchesSearchQuery = item.getLocalizedName(context).toLowerCase().contains(searchQuery);
                        final matchesPositiveDirection = selectedPositive == 'positive'
                            ? item.positiveDirection == true
                            : selectedPositive == 'negative'
                            ? item.positiveDirection == false
                            : true;
                        final matchesType = selectedType == 'all' || selectedType == null
                            ? true
                            : item.type == selectedType;
                        final isDisplayed = _isKpiDisplayed(item.id.toString());

                        // Debug prints to verify each condition
                        print('KPI ID: ${item.id}');
                        print('Periodicity matches: $matchesPeriodicity');
                        print('Search query matches: $matchesSearchQuery');
                        print('Positive direction matches: $matchesPositiveDirection');
                        print('Type matches: $matchesType');
                        print('Is displayed: $isDisplayed');

                        return matchesPeriodicity && matchesSearchQuery && matchesPositiveDirection && matchesType && isDisplayed;
                      }).toList();

                      print('Filtered KPIs: ${filteredKpis.length}');

                      if (filteredKpis.isEmpty) {
                        return Expanded(
                          child: Center(
                            child: Text(
                              'There are no KPIs to display',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                          ),
                        );
                      }

                      return Expanded(
                        child: ListView.separated(
                          itemCount: filteredKpis.length,
                          itemBuilder: (context, index) {
                            final kpiItem = filteredKpis[index];
                            return KpiCard(kpiItem: kpiItem);
                          },
                          separatorBuilder: (context, index) => const Gap(16),
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
