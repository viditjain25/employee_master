import 'package:flutter/material.dart';
import 'package:lib_common/lib_common.dart';

import '../../lib_style.dart';

abstract class BaseTheme {
  Color get blue;

  Color get deepBlue;

  Color get lightWhite;

  Color get white;

  Color get lightBlack;

  Color get lightGrey;

  Color get lightBlue;

  Color get red;

  Resources res = getIt<Resources>();

  ThemeData get appTheme => ThemeData(
        scaffoldBackgroundColor: lightWhite,
        primaryColor: blue,
        primaryColorDark: deepBlue,
        canvasColor: white,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: lightGrey,
          inversePrimary: lightBlue,
          error: red,
          surface: lightBlack,
        ),
      );

  // ThemeData get appTheme => ThemeData(
  //       primaryColor: enabled2Dark,
  //       brightness: Brightness.light,
  //       colorScheme: const ColorScheme.light().copyWith(
  //         background: fillsBlackDefault,
  //       ),
  //       textSelectionTheme: TextSelectionThemeData(
  //         cursorColor: fillsBlackDefault,
  //         selectionHandleColor: Colors.transparent,
  //       ),
  //       scaffoldBackgroundColor: avatarsPlaceholderPureWhite,
  //     );
  TextStyle get titleLarge => TextStyle(
        fontFamily: 'Roboto',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: white,
      );

  TextStyle get titleLarge16 => TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: white,
  );

  TextStyle get titleMedium => TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: lightGrey,
      );

  TextStyle get titleMedium16 => TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: lightGrey,
  );

  TextStyle get titleSmall => TextStyle(
        fontFamily: 'Roboto',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: lightGrey,
      );

  TextStyle get titleSmallFontSize16 => TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: lightBlack,
      );

  TextStyle get bodyLarge => TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: white,
      );

  TextStyle get bodyMedium => TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: lightBlack,
      );

  TextStyle get bodySmall => TextStyle(
        fontFamily: 'Roboto',
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: lightBlack,
      );

  TextStyle get displayLarge => TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: blue,
      );

  TextStyle get displayMedium => TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: lightBlack,
      );
}
