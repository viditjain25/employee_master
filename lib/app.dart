import 'package:employee_master/util/navigation_manager.dart';
import 'package:lib_common/lib_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:lib_employee/lib_employee.dart';
import 'package:lib_style/lib_style.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final Resources _res = getIt<Resources>();
  final NavigationService _navigationService = getIt<NavigationService>();
  final AppRouter _appRouter = getIt<AppRouter>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      StatusBarHandler().setSystemChrome(
        statusBarColor: _res.themes.deepBlue,
        statusBarIconBrightness: Brightness.dark,
      );
    });

    return BlocProvider<EmployeeBloc>(
      create: (_) => getIt<EmployeeBloc>()
        ..add(const EmployeeEvent.initialize())
        ..add(const EmployeeEvent.getAllEmployee()),
      child: MediaQuery(
        data: MediaQueryData.fromView(View.of(context)),
        child: ScreenUtilInit(
          designSize: const Size(360, 720),
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              title: _res.string.appName,
              theme: _res.themes.appTheme,
              navigatorObservers: <NavigatorObserver>[
                routeObserver,
              ],
              navigatorKey: _navigationService.navigatorKey,
              onGenerateRoute: _appRouter.generateRoute,
              home: EmployeePluginManager.instance.getEmployeeListScreen(context),
            );
          },
        ),
      ),
    );
  }
}
