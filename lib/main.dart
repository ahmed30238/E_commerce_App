import 'package:e_commerce_app/core/global/dark_theme/dark_theme.dart';
import 'package:e_commerce_app/core/global/light_theme/light_theme.dart';
import 'package:e_commerce_app/core/routing/app_router.dart';
import 'package:e_commerce_app/core/routing/routing_paths.dart';
import 'package:e_commerce_app/core/service_locator/service_locator.dart';
import 'package:e_commerce_app/observer.dart';
import 'package:e_commerce_app/presentation/controller/layout_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/home_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/layout_cubit/states.dart';
import 'package:e_commerce_app/presentation/controller/logout_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/search_controller/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  Bloc.observer = MyBlocObserver();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //TODO edit dark theme
  bool? isDarkTheme = prefs.getBool('isDarkTheme') ?? false;

  runApp(
    MyApp(
      isDarkTheme: isDarkTheme,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isDarkTheme});

  final bool isDarkTheme;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(
          create: (context) => AppCubit()
            ..changeThemeMode(fromShared: isDarkTheme)
            ..getLanguage(),
        ),
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => LogoutCubit()),
      ],
      child: BlocBuilder<AppCubit, AppStates>(
        // listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          var darkMode = cubit.isDarkTheme;
          return MaterialApp(
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: Locale(cubit.localeCode ?? 'en'),
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightTheme,
            builder: (context, child) => ScreenUtilInit(
              builder: (_, __) => child!,
              useInheritedMediaQuery: true,
              /// The [Size] of the device in the design draft,
              designSize: const Size(430, 932),
            ),
            darkTheme: darkTheme,
            themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
            onGenerateRoute: AppRouter.onGenerateRoutes,
            initialRoute: RoutePaths.splashPath,
            // home: const SplashView(),
          );
        },
      ),
    );
  }
}
