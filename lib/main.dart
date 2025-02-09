import 'package:employee_master/util/packages_manager.dart';
import 'package:employee_master/util/injector.dart';
import 'package:flutter/material.dart';
import 'package:lib_common/lib_common.dart';
import 'package:lib_employee/lib_employee.dart';
import 'package:lib_style/lib_style.dart';

import 'app.dart';

void main() async {
  await setup();
  runApp(const MyApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.setupDI();
  await getIt<EmployeeStorage>().init();
  SvgAssetLoader loader = const SvgAssetLoader(noEmployeeIcon);
  await svg.cache
      .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
  await PackagesManager(getIt<AppRouter>(),)
      .setupNavigationRoute();
}
