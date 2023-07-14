import 'package:e_commerce_app/core/global/dark_theme/dark_theme.dart';
import 'package:e_commerce_app/core/global/light_theme/light_theme.dart';
import 'package:e_commerce_app/core/helper_methods/helper_methods.dart';
import 'package:e_commerce_app/core/routing/app_router.dart';
import 'package:e_commerce_app/core/routing/routing_paths.dart';
import 'package:e_commerce_app/core/service_locator/service_locator.dart';
import 'package:e_commerce_app/core/token_util/theme_mode.dart';
import 'package:e_commerce_app/core/token_util/token_utile.dart';
import 'package:e_commerce_app/observer.dart';
import 'package:e_commerce_app/presentation/controller/home_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/layout_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/layout_cubit/states.dart';
import 'package:e_commerce_app/presentation/controller/logout_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/search_controller/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick_log/quick_log.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  Bloc.observer = MyBlocObserver();
  prefs = await SharedPreferences.getInstance();
  await TokenUtil.loadTokenToMemory();
  await ThemeUtils.loadThemeToMemory();
  // prefs!.getBool(AppEnum.isDarkTheme.name);
  Logger logger = const Logger("Main Logger");
  logger.fine("Your token is ${TokenUtil.getTokenFromMemory()}");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(
          create: (context) => AppCubit()..getLanguage(),
        ),
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => LogoutCubit()),
      ],
      child: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          // if (state is! AppChangeLanguage) {
          //   return const SizedBox();
          // }
          var cubit = AppCubit.get(context);
          // var darkMode = cubit.isDarkTheme;
          return MaterialApp(
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: Locale(cubit.localeCode ?? 'en'),
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            builder: (context, child) => ScreenUtilInit(
              builder: (_, __) => child!,
              useInheritedMediaQuery: true,

              /// The [Size] of the device in the design draft,
              designSize: const Size(430, 932),
            ),
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeUtils.getTheme() ? ThemeMode.dark : ThemeMode.light,
            onGenerateRoute: AppRouter.onGenerateRoutes,
            initialRoute: RoutePaths.splashPath,
          );
        },
      ),
    );
  }
}
// todo pagination (Done)
// todo pusher (Done)
// todo maps (Done)
// todo connect to firebase (notification)
// todo edit dark theme (ongoing) => falilure ==> (done)
// todo edit methods invocation
// todo Customize Dio Library (ongoing)
// todo add firebase notification

Route pageAnimator(Widget widget) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // const begin = Offset(0.0, 1.0);
      // const end = Offset.zero;
      const curve = Curves.ease;
      var tween =
          Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: curve));
      return RotationTransition(
        turns: animation.drive(tween),

        // opacity: animation.drive(tween),
        // position: animation.drive(tween),
        child: child,
      );
    },
  );
}
