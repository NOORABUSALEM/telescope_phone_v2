import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:telescope_phone_v2/core/services/auth_service.dart';
import 'package:telescope_phone_v2/data/providers/auth_provider.dart';
import 'package:telescope_phone_v2/presentation/routers/app_routes.dart';
import 'package:telescope_phone_v2/presentation/screens/home/kpi_tab.dart';

import 'app_localizations.dart';
import 'core/services/user_language_service.dart';
import 'data/cubits/local_cubit/local_cubit.dart';
import 'data/cubits/local_cubit/local_state.dart';
import 'data/cubits/login_cubit/login_cubit.dart';
import 'data/cubits/theme_cubit/theme_cubit.dart';
import 'data/repos/auth_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserLanguageService.init();
  await DailyKpisView.init(); // Initialize SharedPreferences here

  runApp(ShowCaseWidget(
    builder: (context) => MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider<LocaleCubit>(
          create: (context) => LocaleCubit(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(AuthRepository(authProvider: AuthProvider(Dio()), authService: AuthService())),
        ),
        // BlocProvider(
        //   create: (context) => KpiDailyDataCubit(
        //     KpiDailyDataRepository(ApiKpiDailyDataProvider(Dio())),
        //   )..fetchKpiDailyData(),
        // )
      ],
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return BlocBuilder<LocaleCubit, LocalState>(
          builder: (context, state) {
            if (state is SelectedLocale) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Telescope',
                theme: theme,
                locale: state.locale,
                supportedLocales: AppLocalizations.supportedLocales(),
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                initialRoute: AppRoutes.splash,
                routes: AppRoutes.getRoutes(),
              );
            }
            return Container();
          },
        );
      },
    );
  }
}

