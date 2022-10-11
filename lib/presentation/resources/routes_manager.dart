import 'package:flutter/material.dart';

import '../views/experience_view/experience_view.dart';
import '../views/map_view/map_view.dart';
import '../views/onboarding_view/onboarding_view.dart';
import '../views/splash_view/splash_view.dart';
import '../views/wrapper/wrapper.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String homeRoute = '/wrapper';
  static const String experienceRoute = '/experience';
  static const String mapRoute = '/map';

  static const routes = {
    Routes.splashRoute: SplashView(),
    Routes.homeRoute: Wrapper(),
    Routes.onBoardingRoute: OnboardingView(),
    Routes.experienceRoute: ExperienceView(),
    Routes.mapRoute: MapView(),
  };
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      builder: (context) => Routes.routes[routeSettings.name] ?? undefinedRoute(),
    );
  }

  static Widget undefinedRoute() {
    return const Scaffold(body: Center(child: Text('Not Found')));
  }
}
