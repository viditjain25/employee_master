import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lib_common/lib_common.dart';
import 'package:lib_style/lib_style.dart';

import '../../lib_employee.dart';
import 'snack_bar.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  Widget build(BuildContext context) {
    final Resources res = getIt<Resources>();
    return Scaffold(
      appBar: EmployeeAppBar(
        title: res.string.employeeList,
        isEdit: false,
        onDelete: null,
      ),
      body: Container(color: res.themes.lightWhite, child: _EmployeeList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getIt<NavigationService>().pushNamed(
          RoutePaths.manageEmployeeScreen,
        ),
        child: const SvgImageWidget(
          width: 18,
          height: 18,
          svgImage: addIcon,
        ),
      ),
    );
  }
}

class _EmployeeList extends StatefulWidget {
  @override
  State<_EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<_EmployeeList> {
  @override
  Widget build(BuildContext context) {
    final Resources res = getIt<Resources>();
    return BlocConsumer<EmployeeBloc, EmployeeState>(
      listenWhen: (EmployeeState previous, EmployeeState current) =>
          previous.isDeleting != current.isDeleting,
      listener: (BuildContext context, EmployeeState state) {
        state.apiFailureOrSuccessOption.fold(
          () {
            if (!state.isDeleting) {
              SnackBarWidget.handleSnackBar(
                context: context,
                message: res.string.employeeDeletedSuccessfully,
                isUndoRequired: true,
                isDeleted: true,
              );
            }
          },
          (dz.Either<ApiFailure, dynamic> either) => either.fold(
            (ApiFailure failure) {
              SnackBarWidget.handleSnackBar(
                context: context,
                message: failure.failureMessage,
              );
            },
            (_) {},
          ),
        );
      },
      buildWhen: (EmployeeState previous, EmployeeState current) =>
          previous.isFetching != current.isFetching ||
          previous.currentEmployeeList != current.currentEmployeeList ||
          previous.previousEmployeeList != current.previousEmployeeList ||
          previous.isDeleting != current.isDeleting,
      builder: (BuildContext context, EmployeeState state) {
        return ScrollList<Employee>(
          isLoading: state.isFetching,
          itemBuilder: (BuildContext context, Employee item) => Container(
            color: getIt<Resources>().themes.white,
            child: _EmployeeItem(
              employee: item,
              state: state,
            ),
          ),
          group1Header: getIt<Resources>().string.currentEmployees,
          group2Header: getIt<Resources>().string.previousEmployees,
          itemGroup1: state.currentEmployeeList,
          itemGroup2: state.previousEmployeeList,
          onRefresh: () => context.read<EmployeeBloc>().add(
                const EmployeeEvent.getAllEmployee(),
              ),
          noRecordFoundWidget:
              NoRecordFound(title: res.string.noEmployeeRecordsFound),
          controller: ScrollController(),
        );
      },
    );
  }
}

class _EmployeeItem extends StatefulWidget {
  const _EmployeeItem({
    required this.employee,
    required this.state,
  });

  final Employee employee;
  final EmployeeState state;

  @override
  State<_EmployeeItem> createState() => _EmployeeItemState();
}

class _EmployeeItemState extends State<_EmployeeItem> {
  @override
  Widget build(BuildContext context) {
    return CustomSlidable(
      endActionPaneActions: <CustomSlidableAction>[
        CustomSlidableAction(
          icon: Icons.delete_outline,
          onPressed: (BuildContext context) => context.read<EmployeeBloc>().add(
                EmployeeEvent.deleteEmployee(
                  employee: widget.employee,
                ),
              ),
          backgroundColor: getIt<Resources>().themes.red,
          foregroundColor: getIt<Resources>().themes.white,
        ),
      ],
      enabled: !widget.state.isDeleting,
      child: LoadingShimmer(
        enabled: widget.state.isDeleting &&
            widget.state.selectedEmployee.key == widget.employee.key,
        child: Column(
          children: <Widget>[
            getThreeLineWidget(),
            getDividerWidget(),
          ],
        ),
      ),
    );
  }

  Widget getDividerWidget() {
    return Container(
      height: 1,
      width: double.infinity,
      color: getIt<Resources>().themes.lightGrey.withAlpha(50),
    );
  }

  Widget getThreeLineWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
      child: SizedBox(
        height: 100,
        child: ListTile(
          tileColor: Theme.of(context).canvasColor,
          visualDensity: const VisualDensity(vertical: -2),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 11.0),
            child: SizedBox(
              height: 20,
              child: Text(
                widget.employee.name,
                style: getIt<Resources>().themes.titleLarge16.copyWith(
                      color: getIt<Resources>().themes.lightBlack,
                    ),
              ),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
                child: Text(
                  widget.employee.designation,
                  style: getIt<Resources>().themes.titleMedium,
                ),
              ),
              const SizedBox(
                height: 11,
              ),
              SizedBox(
                height: 20,
                child: Text(
                  widget.employee.subtitleLebel,
                  style: getIt<Resources>().themes.titleSmall,
                ),
              ),
            ],
          ),
          isThreeLine: true,
          onTap: () {
            context.read<EmployeeBloc>().add(
                  EmployeeEvent.proceedToEditEmployee(
                    employee: widget.employee,
                  ),
                );
            getIt<NavigationService>().pushNamed(
              RoutePaths.manageEmployeeScreen,
              arguments: true,
            );
          },
        ),
      ),
    );
  }
}
