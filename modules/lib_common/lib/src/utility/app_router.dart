import 'package:flutter/cupertino.dart';

bool isSplashLoaded = false;

class AppRouter {
  Map<String, WidgetBuilder> routeMap = <String, WidgetBuilder>{};

  Route<dynamic> generateRoute(RouteSettings settings) {
    if (!isSplashLoaded) {
      isSplashLoaded = true;

      return PageRouteBuilder<dynamic>(
        settings: settings,
        pageBuilder: (_, __, ___) {
          return routeMap[settings.name!]!(_);
        },
        transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
            FadeTransition(
          opacity: a,
          child: c,
        ),
      );
    }

    return CupertinoPageRoute<dynamic>(
      builder: routeMap[settings.name!]!,
      settings: settings,
    );
  }
}
