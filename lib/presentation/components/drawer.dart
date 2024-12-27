import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:telescope_phone_v2/core/extensions/translation_extension/Translation_extension.dart';
import 'package:telescope_phone_v2/core/services/user_service.dart';
import 'package:telescope_phone_v2/data/cubits/kpiInfo_cubit/kpi_info_cubit.dart';
import 'package:telescope_phone_v2/presentation/components/themeToggleButton.dart';
import 'package:telescope_phone_v2/presentation/screens/all_KPIs/all_kpis.dart';

import '../../core/services/info_service.dart';
import '../../core/styles/color_constants.dart';
import '../../data/cubits/login_cubit/login_cubit.dart';
import 'languageSelector.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String? userName;
  String? userEmail;
  String? userRole;
  final UserService userService = UserService();
  final GlobalKey _kpiKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _checkShowCaseStatus2();
  }

  Future<void> _checkShowCaseStatus2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isShowCaseAlreadyShown = prefs.getBool('isShowCaseShown') ?? false;

    if (!isShowCaseAlreadyShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context).startShowCase([_kpiKey]);
      });
      await prefs.setBool('isShowCaseShown', true);
    }
  }

  void _loadUserName() async {
    final name = await userService.getUserName();
    final email = await userService.getUserEmail();
    final role = await userService.getRole();
    setState(() {
      userName = name ?? 'Guest';
      userEmail = email ?? 'Guest';
      userRole = role ?? 'Guest';
    });
  }

  Future<void> _navigateToAllKpis(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
       // builder: (context) => const AllKpis(),
        builder: (context) => const AllKpisSettingView(),
      ),
    );
    if (result == true) {
      //context.read<KpiDailyDataCubit>().fetchKpiDailyData();
      context.read<KpiInfoCubit>().fetchKpiInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 270,
            child: DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(50),
                  const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 50,
                    child: Image(
                      image: AssetImage('assets/images/Asset12.png'),
                    ),
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Text(
                        '$userName', // Display the user name
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const Expanded(child: SizedBox()),
                      if (userRole == "employee")
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFCC00).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              (context).trans("employee"),
                              style: const TextStyle(
                                  color: AppColors.yellowColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      if (userRole == "manager")
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF24A959).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              (context).trans("manager"),
                              style: const TextStyle(
                                  color: AppColors.upArrowColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Text(
                    '$userEmail', // Display the user email
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          LanguageSelector(),
          const DrawerItem(
            text: "Dark Theme",
            IconData: Icon(Icons.dark_mode_rounded),
            trailing: ThemeToggleButton(),
          ),
          Showcase(
            key: _kpiKey,
            description: (context).trans("Add KPIs from here"),
            child: DrawerItem(
              text: "KPIs",
              IconData: const Icon(Icons.show_chart),
              onTap: () {
                _navigateToAllKpis(context);
                Scaffold.of(context).closeDrawer();
              },
            ),
          ),
          DrawerItem(
            text: "Log Out",
            IconData: const Icon(Icons.logout_rounded),
            onTap: () async {
              // Show a confirmation dialog before logging out
              bool shouldLogout = await _showLogoutConfirmationDialog(context);
              if (shouldLogout) {
                context
                    .read<LoginCubit>()
                    .logout(); // Call logout function from LoginCubit
                Navigator.of(context)
                    .pushReplacementNamed('/login'); // Navigate to login screen
              }
            },
          ),
        ],
      ),
    );
  }
}

Future<bool> _showLogoutConfirmationDialog(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text((context).trans("Are you sure you want to log out?")),
            actions: [
              TextButton(
                child: Text(
                  (context).trans("Cancel"),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pop(false); // Return false if cancel is pressed
                },
              ),
              TextButton(
                child: Text(
                  (context).trans("Log Out"),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pop(true); // Return true if logout is confirmed
                },
              ),
            ],
          );
        },
      ) ??
      false; // Return false if the dialog is dismissed
}

class DrawerItem extends StatelessWidget {
  final String text;
  final Icon IconData;
  final Widget? trailing;
  final VoidCallback? onTap;

  const DrawerItem({
    super.key,
    required this.text,
    required this.IconData,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text((context).trans(text)),
      leading: IconData,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
