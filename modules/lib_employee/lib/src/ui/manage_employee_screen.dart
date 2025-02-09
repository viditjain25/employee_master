import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lib_common/lib_common.dart';
import 'package:lib_style/lib_style.dart';
import '../../lib_employee.dart';
import 'designation_menu.dart';
import 'snack_bar.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class ManageEmployeeScreen extends StatefulWidget {
  const ManageEmployeeScreen({
    super.key,
    this.isEdit = false,
  });

  final bool isEdit;

  @override
  State<ManageEmployeeScreen> createState() => _ManageEmployeeScreenState();
}

class _ManageEmployeeScreenState extends State<ManageEmployeeScreen>
    with WidgetsBindingObserver {
  final Resources res = getIt<Resources>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  String? _commonValidator({required String? value}) {
    if (value == null || value.isEmpty) {
      return '* Mandatory';
    }
    return null;
  }

  String? _commonValidatorDate({required String? value}) {
    return null;
  }

  final TextEditingController nameController = TextEditingController();

  final TextEditingController roleController = TextEditingController();

  final TextEditingController startDateController = TextEditingController();

  final TextEditingController endDateController = TextEditingController();

  DateTime startDate = DateTime.now();

  DateTime endDate = DateTime.now();
  bool finished = true;

  void _onDelete({required BuildContext context}) {
    context.read<EmployeeBloc>().add(
          EmployeeEvent.deleteEmployee(
            employee: context.read<EmployeeBloc>().state.selectedEmployee,
          ),
        );
    getIt<NavigationService>().goBack();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeBloc, EmployeeState>(
      listenWhen: (EmployeeState previous, EmployeeState current) =>
          previous.isSubmitting != current.isSubmitting,
      listener: (BuildContext context, EmployeeState state) {
        state.apiFailureOrSuccessOption.fold(
          () {
            if (!state.isSubmitting) {
              SnackBarWidget.handleSnackBar(
                context: context,
                message: widget.isEdit
                    ? res.string.employeeUpdatedSuccessfully
                    : res.string.employeeAddedSuccessfully,
              );
              getIt<NavigationService>().goBack();
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
          previous.isSubmitting != current.isSubmitting ||
          previous.isDeleting != current.isDeleting,
      builder: (BuildContext context, EmployeeState state) {
        if (widget.isEdit && finished) {
          nameController.text = state.selectedEmployee.name;
          roleController.text = state.selectedEmployee.designation;
          startDateController.text = state.selectedEmployee.fromDate;
          endDateController.text = state.selectedEmployee.toDate;
          finished = false;
        }
        return Scaffold(
          appBar: getAppBarWidget(state),
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: <Widget>[
              getBodyWidget(),
              KeyboardVisibilityBuilder(
                  builder: (BuildContext context, bool isKeyboardVisible) {
                return Positioned(
                  left: 0,
                  right: 0,
                  bottom: isKeyboardVisible ? 284 : 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: getBottomWidget(state),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  PreferredSizeWidget getAppBarWidget(EmployeeState state) {
    return EmployeeAppBar(
      title: widget.isEdit
          ? res.string.editEmployeeDetails
          : res.string.addEmployeeDetails,
      isEdit: widget.isEdit,
      onDelete: () => widget.isEdit ? _onDelete(context: context) : null,
      shimmerDeleteIcon: state.isDeleting,
    );
  }

  Widget getBodyWidget() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    constraints.maxHeight, // Ensures it takes full height
              ),
              child: IntrinsicHeight(
                child: Container(
                  color: res.themes.white,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: 396,
                            height: 80,
                            child: CustomTextField(
                              hintText: res.string.employeeName,
                              prefixIcon: personIcon,
                              validator: (String? value) =>
                                  _commonValidator(value: value),
                              controller: nameController,
                              style: res.themes.bodyMedium,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 396,
                            height: 80,
                            child: CustomTextField(
                              hintText: res.string.selectRole,
                              prefixIcon: designationIcon,
                              readOnly: true,
                              style: res.themes.bodyMedium,
                              suffixIcon: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(15, 17, 14, 17),
                                child: const SvgImageWidget(
                                  svgImage: dropdownIcon,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                              onTap: () async {
                                // TODO(vidit): ensure edit case
                                await handleBottomSheet();
                              },
                              validator: (String? value) =>
                                  _commonValidator(value: value),
                              controller: roleController,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: SizedBox(
                                  height: 80,
                                  child: CustomTextField(
                                    hintText: res.string.today,
                                    prefixIcon: calenderIcon,
                                    readOnly: true,
                                    hintStyle:
                                        res.themes.titleMedium16.copyWith(
                                      color: res.themes.lightBlack,
                                    ),
                                    style: res.themes.displayMedium,
                                    onTap: () async {
                                      _showDatePicker(
                                        context: context,
                                        isStartDate: true,
                                      );
                                    },
                                    validator: (String? value) =>
                                        _commonValidatorDate(value: value),
                                    controller: startDateController,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 30,
                                ),
                                child: const SvgImageWidget(
                                  svgImage: rightArrowIcon,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 80,
                                  child: CustomTextField(
                                    hintText: res.string.noDate,
                                    prefixIcon: calenderIcon,
                                    readOnly: true,
                                    style: res.themes.displayMedium,
                                    onTap: () async => _showDatePicker(
                                      context: context,
                                      isStartDate: false,
                                    ),
                                    validator: (String? value) =>
                                        _commonValidatorDate(
                                      value: value,
                                    ),
                                    controller: endDateController,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> handleBottomSheet() async {
    Future<void>.delayed(const Duration(milliseconds: 500), () {
      StatusBarHandler().updateStatusBarWithColor(
        Colors.transparent,
      );
    });
    await showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (_) {
        return const DesignationMenu();
      },
    ).then(
      (dynamic value) {
        if (value == null) {
          return;
        }
        setState(() {
          roleController.text = value as String;
        });
      },
    );
  }

  Widget getBottomWidget(EmployeeState state) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: res.themes.lightGrey.withValues(alpha: 0.2),
            width: 2,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(
          top: 12,
          right: 12,
        ),
        color: res.themes.white,
        child: Wrap(
          alignment: WrapAlignment.end,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                backgroundColor: res.themes.lightBlue,
              ),
              onPressed: state.isDeleting || state.isSubmitting
                  ? null
                  : () => getIt<NavigationService>().goBack(),
              child: Text(
                res.string.cancel,
                style: res.themes.bodyLarge.copyWith(
                  color: res.themes.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                backgroundColor: res.themes.blue,
              ),
              onPressed: state.isDeleting || state.isSubmitting
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        final Employee emp = Employee.empty().copyWith(
                          name: nameController.text,
                          designation: roleController.text,
                          fromDate: DateFormat(homeScreenDisplayFormat).format(
                            startDateController.text.isEmpty
                                ? DateTime.now()
                                : startDate,
                          ),
                          toDate: endDateController.text.isEmpty ||
                                  endDateController.text.trim() ==
                                      res.string.noDate
                              ? res.string.noDate
                              : DateFormat(homeScreenDisplayFormat)
                                  .format(endDate),
                          key: widget.isEdit
                              ? context
                                  .read<EmployeeBloc>()
                                  .state
                                  .selectedEmployee
                                  .key
                              : '',
                        );
                        context.read<EmployeeBloc>().add(
                              EmployeeEvent.saveEmployee(
                                employee: emp,
                                isEdit: widget.isEdit,
                              ),
                            );
                      }
                    },
              child: Text(
                res.string.save,
                style: res.themes.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDatePicker({
    required BuildContext context,
    required bool isStartDate,
  }) async {
    Future<void>.delayed(const Duration(milliseconds: 200), () {
      StatusBarHandler().updateStatusBarWithColor(
        Colors.transparent,
      );
    });
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        final Resources res = getIt<Resources>();
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 24.0,
          ),
          backgroundColor: res.themes.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: CustomDatePicker(
            isStartDate: isStartDate,
            currentDate: isStartDate
                ? startDateController.text.isEmpty
                    ? null
                    : startDate
                : (endDateController.text.isEmpty ||
                        endDateController.text.trim() == res.string.noDate)
                    ? null
                    : endDate,
            firstDate: isStartDate
                ? DateTime(
                    calendarStartDateYear,
                  )
                : startDate,
            lastDay: DateTime(
              calendarLastDateYear,
            ),
            onPressed: (DateTime? date) {
              calendarCallback(date, isStartDate);
            },
          ),
        );
      },
    );
  }

  void calendarCallback(DateTime? date, bool isStartDate) {
    if (date == null && isStartDate) {
      return;
    }
    if (isStartDate) {
      setState(() {
        startDateController.text = date != null
            ? DateFormat(dateFormat).format(date)
            : res.string.today;
        if (date != null) {
          startDate = date;
        }

        if (endDate.isBefore(startDate)) {
          endDateController.text = res.string.noDate;
        }
      });
    }

    if (!isStartDate) {
      setState(() {
        endDateController.text = date != null
            ? DateFormat(dateFormat).format(date)
            : res.string.noDate;
        if (date != null) {
          endDate = date;
        }
        if (endDate.isBefore(startDate)) {
          endDateController.text = res.string.noDate;
        }
      });
    }
    getIt<NavigationService>().goBack();
  }
}
