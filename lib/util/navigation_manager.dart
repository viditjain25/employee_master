
import 'package:employee_master/app.dart';
import 'package:flutter/cupertino.dart';


class NavigationManager {
  NavigationManager._();

  static final NavigationManager instance = NavigationManager._();

  Widget getSplashScreen() {
    return const MyApp();
  }

}