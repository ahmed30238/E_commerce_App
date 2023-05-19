import 'package:e_commerce_app/core/routing/routing_paths.dart';
import 'package:e_commerce_app/presentation/screens/layout/layout_screen.dart';
import 'package:e_commerce_app/presentation/screens/register_screen/register_screen.dart';
import 'package:e_commerce_app/presentation/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.splashPath:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
        );
      case RoutePaths.registerScreen:
        return MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        );
      case RoutePaths.layoutScreen:
        return MaterialPageRoute(
          builder: (context) => const LayOutScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const LayOutScreen(),
        );
    }
  }
}
