import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lib_common/lib_common.dart';
import 'package:lib_style/lib_style.dart';

import '../../lib_employee.dart';

class SnackBarWidget {
  void dummy() {}

  static void handleSnackBar({
    required BuildContext context,
    required String message,
    bool isUndoRequired = false,
    bool isDeleted = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed,
        content: Text(
          message,
          style: getIt<Resources>().themes.bodySmall.copyWith(
                color: getIt<Resources>().themes.white,
              ),
        ),
        action: isUndoRequired
            ? SnackBarAction(
                label: getIt<Resources>().string.undo,
                textColor: getIt<Resources>().themes.blue,
                onPressed: () {
                  final Employee selectedEmployee =
                      context.read<EmployeeBloc>().state.selectedEmployee;
                  final Employee newEmployee = isDeleted
                      ? Employee.empty().copyWith(
                          name: selectedEmployee.name,
                          designation: selectedEmployee.designation,
                          fromDate: selectedEmployee.fromDate,
                          toDate: selectedEmployee.toDate,
                          key: '',
                        )
                      : selectedEmployee;

                  context.read<EmployeeBloc>().add(
                        EmployeeEvent.saveEmployee(
                          employee: newEmployee,
                          isEdit: !isDeleted,
                        ),
                      );
                },
              )
            : null,
      ),
    );
  }
}
