import 'package:flutter/material.dart';

double deviceWidth = 360;

final RouteObserver<PageRoute<dynamic>> routeObserver =
    RouteObserver<PageRoute<dynamic>>();

const String _basePath = 'assets/svg/';
const String noEmployeeIcon = '${_basePath}no_employee_icon.svg';
const String calenderIcon = '${_basePath}calender_icon.svg';
const String personIcon = '${_basePath}person_icon.svg';
const String designationIcon = '${_basePath}designation_icon.svg';
const String dropdownIcon = '${_basePath}dropdown_icon.svg';
const String rightArrowIcon = '${_basePath}right_arrow_icon.svg';
const String deleteIcon = '${_basePath}delete_icon.svg';
const String rightForwardIcon = '${_basePath}right_forward_icon.svg';
const String leftForwardIcon = '${_basePath}left_forward_icon.svg';
const String leftForwardEnableIcon = '${_basePath}left_forward_enable_icon.svg';
const String addIcon = '${_basePath}add_icon.svg';
const int daysToGoBackFromCurrentDay = 30;
const int daysToGoForwardFromCurrentDay = 30;
const String dateFormat = 'dd MMM yyyy';
const String homeScreenDisplayFormat = 'dd MMM, yyyy';
const int calendarStartDateYear = 2000;
const int calendarLastDateYear = 2070;
bool setupCompleted = false;
const String hiveBoxName = 'employee_box';
const List<String> designationList = <String>[
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner',
];
