import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:telescope_phone_v2/core/extensions/translation_extension/Translation_extension.dart';
import 'package:telescope_phone_v2/presentation/screens/home/kpisTabView.dart';
import '../../../data/cubits/kpi_cubit/kpi_cubit.dart';
import '../../../data/cubits/kpi_cubit/kpi_state.dart';
import '../../../data/cubits/search_cubit/search_bar_cubit.dart';
import '../../../data/providers/kpi_provider.dart';
import '../../../data/providers/kpiinfo_providers.dart';
import '../../../data/repos/kpiInfo_repository.dart';
import '../../../data/repos/kpi_repository.dart';
import '../../components/customSearchBar.dart';
import '../../components/drawer.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchBarCubit(),
        ),
        BlocProvider(
          create: (context) => KpiCubit(
            KpiInfoRepository(
              provider: KpiInfoProvider(),
            ),
          )..fetchKpis(),
        ),
      ],
      child: HomeScreenView(),
    );
  }
}

class HomeScreenView extends StatefulWidget {
  HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final GlobalKey _drawerKey = GlobalKey();
  String? date;
  //final InfoService infoService = InfoService();

  @override
  void initState() {
    super.initState();
    _checkShowCaseStatus();
    _loadUserName();
  }

  Future<void> _checkShowCaseStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isShowCaseAlreadyShown = prefs.getBool('isShowCaseShown') ?? false;

    if (!isShowCaseAlreadyShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context).startShowCase([_drawerKey]);
      });
      await prefs.setBool('isShowCaseShown', true);
    }
  }

  void _loadUserName() async {
    //final dateTime = await infoService.getDate();

    setState(() {
      //date = dateTime ?? '00:00';
      date = '00:00';
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs (Daily and Monthly)
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: BlocBuilder<SearchBarCubit, SearchBarState>(
            builder: (context, state) {
              return switch (state) {
                SearchBarShow() => AppBar(
                  title: CustomSearchBar(
                    controller:
                    context.watch<SearchBarCubit>().searchController,
                  ),
                ),
                SearchBarHide() => AppBar(
                  leading: Showcase(
                    key: _drawerKey,
                    description: (context).trans("Tap here to add KPIs"),
                    child: InkWell(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: const Icon(Icons.menu)),
                  ),
                  centerTitle: true,
                  title: Text(
                    context.trans("TeleScope"),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        context.read<SearchBarCubit>().show();
                      },
                      icon: const Icon(Icons.search_outlined),
                    ),
                  ],
                ),
              };
            },
          ),
        ),
        drawer: AppDrawer(),
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  text: (context).trans("Daily"),
                ),
                Tab(text: (context).trans("Monthly")),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                 KpisTabView(),
                  KpisTabView()
                ],
              ),
            ),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: BlocConsumer<KpiCubit, KpiState>(
          listener: (context, state) {
          },
          builder: (context, state) {
            return BottomAppBar(
              child: Center(child: Text('Last Update was : $date')),
              color: Color(0xFFB2DAFF).withOpacity(0.4),
            );
          },
        ),
      ),
    );
  }
}