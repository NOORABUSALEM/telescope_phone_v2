import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:telescope_phone_v2/core/extensions/translation_extension/Translation_extension.dart';
import '../../../core/services/info_service.dart';
import '../../../data/cubits/kpiInfo_cubit/kpi_info_cubit.dart';
import '../../../data/cubits/search_cubit/search_bar_cubit.dart';
import '../../../data/providers/kpiinfo_providers.dart';
import '../../../data/repos/kpiInfo_repository.dart';
import '../../components/customSearchBar.dart';
import '../../components/drawer.dart';
import '../../components/show_filter_component.dart';
import 'kpi_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SearchBarCubit()),
        BlocProvider(
          create: (_) => KpiInfoCubit(
            KpiInfoRepository(KpiInfoProvider(Dio())),
          )..fetchKpiInfo(),
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
  // Filter state variables
  String? positiveFilter; // e.g., "positive", "negative", "any"
  String? typeFilter; // e.g., "numeric", "percentage", "money", "other"

  final GlobalKey _drawerKey = GlobalKey();
  String? date;
  final InfoService infoService = InfoService();

  @override
  void initState() {
    super.initState();
    _checkShowCaseStatus();
    _loadDataService();
  }
  void _updateFilters(String? newPositive, String? newType) {
    setState(() {
      positiveFilter = newPositive;
      typeFilter = newType;
    });
  }

  void _openFilterDialog() {
    showFilterDialog(context, onApply: _updateFilters);
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

  void _loadDataService() async {
    final dateTimeString = await infoService.getDate();

    setState(() {
      if (dateTimeString != null) {
        // Parse the ISO 8601 string to DateTime
        DateTime parsedDate = DateTime.parse(dateTimeString);

        // Format as day, month, and year (dd/MM/yyyy)
        date = "${parsedDate.day}/${parsedDate.month}/${parsedDate.year}";
      }
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
                  leading: InkWell(
                      onTap: _openFilterDialog,
                        child: const Icon(Icons.filter_list_outlined)),
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
                  KpisScreen(type: 'daily',selectedPositive:positiveFilter ,selectedType: typeFilter,),
                  KpisScreen(type: 'monthly',selectedPositive:positiveFilter ,selectedType: typeFilter,),
                ],
              ),
            ),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: BlocConsumer<KpiInfoCubit, KpiInfoState>(
          listener: (context, state) {},
          builder: (context, state) {
            return BottomAppBar(
              color: const Color(0xFFB2DAFF).withOpacity(0.4),
              child: Center(
                  child: Text(date != null
                      ? "${(context).trans("Last Updated:")} $date" // Display formatted date
                      : (context).trans("Fetching last updated date..."))),
            );
          },
        ),
      ),
    );
  }
}