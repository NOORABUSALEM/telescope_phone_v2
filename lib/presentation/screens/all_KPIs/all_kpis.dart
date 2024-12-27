import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telescope_phone_v2/core/extensions/translation_extension/Translation_extension.dart';

import '../../../data/cubits/kpiInfo_cubit/kpi_info_cubit.dart';
import '../../../data/models/kpiInfo.dart';
import '../../../data/providers/kpiinfo_providers.dart';
import '../../../data/repos/kpiInfo_repository.dart';


class AllKpisSettingView extends StatelessWidget {
  const AllKpisSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (x, y) {
        //context.read<KpiDailyDataCubit>().fetchKpiDailyData();
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => KpiInfoCubit(
              KpiInfoRepository(
                KpiInfoProvider(Dio()),
              ),
            )..fetchKpiInfo(),
          ),
          // BlocProvider(
          //   create: (context) => KpiDailyDataCubit(
          //       KpiDailyDataRepository(ApiKpiDailyDataProvider(Dio())))
          //     ..fetchKpiDailyData(),
          // ),
        ],
        child: const AllKpisView(),
      ),
    );
  }
}

class AllKpisView extends StatelessWidget {
  const AllKpisView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((context).trans('KPIs List')),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
            onPressed: () {
              //context.read<KpiDailyDataCubit>().fetchKpiDailyData();
              context.read<KpiInfoCubit>().fetchKpiInfo();
              Navigator.pop(context, true);
            },
            icon: const Icon(Icons.arrow_back_rounded)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            BlocBuilder<KpiInfoCubit, KpiInfoState>(
              builder: (context, state) {
                if (state is KpiInfoLoading) {

                  return const Center(child: CircularProgressIndicator());
                }
                if (state is KpiInfoSuccess) {
                  final kpiInfoList = state.kpiList;
                  if (kpiInfoList.isEmpty) {
                    return Center(
                      child: Text((context).trans("No KPI data available."))
                    );
                  }

                  return Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final kpiInfoItem = kpiInfoList[index];

                        return KpiListItem(infoModel: kpiInfoItem);
                      },
                      separatorBuilder: (context, index) {
                        return const Gap(16);
                      },
                      itemCount: kpiInfoList.length,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class KpiListItem extends StatefulWidget {
  final KpiInfo infoModel;

  const KpiListItem({super.key, required this.infoModel});

  @override
  _KpiListItemState createState() => _KpiListItemState();
}

class _KpiListItemState extends State<KpiListItem> {
  bool isDisplayed = false;

  @override
  void initState() {
    super.initState();
    _loadKpiDisplayStatus();
  }

  Future<void> _loadKpiDisplayStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDisplayed = prefs.getBool(widget.infoModel.id.toString()) ??
          false; // Fetch saved state
    });
  }

  Future<void> _saveKpiDisplayStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        widget.infoModel.id.toString(), value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        title: Text(widget.infoModel.getLocalizedName(context)),
        trailing: Switch(
          value: isDisplayed,
          onChanged: (value) {
            setState(() {
              isDisplayed = value;
            });

            _saveKpiDisplayStatus(value);
          },
        ),
      ),
    );
  }
}
