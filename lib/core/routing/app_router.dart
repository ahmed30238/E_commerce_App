import 'package:e_commerce_app/core/routing/routing_paths.dart';
import 'package:e_commerce_app/main.dart';
import 'package:e_commerce_app/presentation/screens/layout/layout_screen.dart';
import 'package:e_commerce_app/presentation/screens/login_screen/login_screen.dart';
import 'package:e_commerce_app/presentation/screens/register_screen/register_screen.dart';
import 'package:e_commerce_app/presentation/screens/splash_screen/splash_screen.dart';
import 'package:e_commerce_app/presentation/screens/zoom_image/z.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.splashPath:
        return pageAnimator(const SplashView());
      case RoutePaths.registerScreen:
        return MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        );
      case RoutePaths.layoutScreen:
        return MaterialPageRoute(
          builder: (context) => const LayOutScreen(),
        );
      case RoutePaths.loginScreen:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case RoutePaths.zoomImagePath:
      
        String image = settings.arguments as String;
        int imageId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => ZoomImage(
            image: image,
            imageId: imageId,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const LayOutScreen(),
        );
    }
  }
}
