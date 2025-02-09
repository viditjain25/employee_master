import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lib_style/lib_style.dart';
import 'package:lib_common/lib_common.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override

  Widget build(BuildContext context) {
    final Resources res = getIt<Resources>();
    final double fueloBoxWidth = 180;
    final double fueloBoxHeight = 54;

    Future<void>.delayed(const Duration(seconds: 3),() {
      if (!setupCompleted) {
        getIt<NavigationService>().pushReplacementNamed(RoutePaths.employeeListScreen);
        setupCompleted = true;
      }
    });

    return SafeArea(
      top: false,
      bottom: false,
      left: false,
      right: false,
      child: Container(
        key: const Key('splash_screen'),
        height: double.infinity,
        width: double.infinity,
        color: res.themes.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <SizedBox>[
            SizedBox(
              width: fueloBoxWidth,
              height: fueloBoxHeight,
              child: SvgPicture.asset(noEmployeeIcon),
            ),
          ],
        ),
      ),
    );
  }
}
