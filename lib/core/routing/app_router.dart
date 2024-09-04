import 'package:e_commerce_app/core/routing/routing_paths.dart';
import 'package:e_commerce_app/main.dart';
import 'package:e_commerce_app/presentation/controller/home_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/map_screen/location_screen.dart';
import 'package:e_commerce_app/presentation/screens/layout/layout_screen.dart';
import 'package:e_commerce_app/presentation/screens/login_screen/login_screen.dart';
import 'package:e_commerce_app/presentation/screens/register_screen/register_screen.dart';
import 'package:e_commerce_app/presentation/screens/search_screen/search_screen.dart';
import 'package:e_commerce_app/presentation/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.splashPath:
        return pageAnimator(const SplashView());
      case RoutePaths.registerScreen:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );
      case RoutePaths.layoutScreen:
        return MaterialPageRoute(
          builder: (context) => const LayOutScreen(),
        );
      case RoutePaths.searchScreen:
        return MaterialPageRoute(
          builder: (context) => const SearchScreen(),
        );
      case RoutePaths.loginScreen:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case RoutePaths.loc:
        // var argument = settings.arguments as Map<String, dynamic>?;
        // var cubit = argument?["cubit"] as HomeCubit;
        // var model = argument?["model"] as ProductsEntity;
        // todo use these vars with navigation if you needed to navigate to the same screen with different options
        //! hint => you can add whatever you want of vars
        return pageAnimator(
          const LocationsScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const LayOutScreen(),
        );
    }
  }
}

// hint => how to use multiple arguments
void nav(context) {
  Navigator.pushNamed(context, "route name", arguments: {
    "cubit": HomeCubit.get(context),
    "model": HomeCubit.get(context).homeModel,
  });
}
