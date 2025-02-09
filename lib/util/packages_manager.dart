import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lib_common/lib_common.dart';
import 'package:lib_employee/lib_employee.dart';
import 'navigation_manager.dart';


class PackagesManager {
  PackagesManager(this._appRoute,);

  final AppRouter _appRoute;

  Map<String, WidgetBuilder> _setupNavigation() {
    return <String, WidgetBuilder>{
      RoutePaths.splashScreen: (BuildContext context) =>
          NavigationManager.instance.getSplashScreen(),
      RoutePaths.employeeListScreen: (BuildContext context) =>
          EmployeePluginManager.instance.getEmployeeListScreen(context),
      RoutePaths.manageEmployeeScreen: (BuildContext context) =>
          EmployeePluginManager.instance.getManagerEmployeeScreen(context),
    };
  }

  Future<void> setupNavigationRoute() async {
    final Map<String, WidgetBuilder> routeMap =
        _setupNavigation();

    // added app level navigation
    _appRoute.routeMap.addAll(routeMap);
  }
}
