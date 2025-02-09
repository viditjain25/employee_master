import 'package:flutter/material.dart';

import 'ui/employee_list_screen.dart';
import 'ui/manage_employee_screen.dart';

/// plugin manager for this package.
class EmployeePluginManager {
  EmployeePluginManager._();

  static final EmployeePluginManager instance = EmployeePluginManager._();

  Widget getManagerEmployeeScreen(BuildContext context) {
    final bool isEdit =
        ModalRoute.of(context)!.settings.arguments as bool? ?? false;

    return ManageEmployeeScreen(
      isEdit: isEdit,
    );
  }

  Widget getEmployeeListScreen(BuildContext context) {
    return const EmployeeListScreen();
  }
}
