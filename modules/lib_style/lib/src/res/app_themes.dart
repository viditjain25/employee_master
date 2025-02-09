import 'package:flutter/material.dart';

import '../utils/app_theme_mode.dart';
import 'base_theme.dart';
import 'dark_theme.dart';
import 'light_theme.dart';

class AppThemes {
  AppThemes(this._isLightMode) {
    _selectedTheme =
        (_isLightMode == AppThemeMode.light) ? LightTheme() : DarkTheme();
  }

  final AppThemeMode _isLightMode;
  late BaseTheme _selectedTheme;

  ThemeData get appTheme => _selectedTheme.appTheme;

  Color get blue => _selectedTheme.blue;

  Color get deepBlue => _selectedTheme.deepBlue;

  Color get lightWhite => _selectedTheme.lightWhite;

  Color get white => _selectedTheme.white;

  Color get lightBlack => _selectedTheme.lightBlack;

  Color get lightGrey => _selectedTheme.lightGrey;

  Color get lightBlue => _selectedTheme.lightBlue;

  Color get red => _selectedTheme.red;

  TextStyle get titleLarge => _selectedTheme.titleLarge;

  TextStyle get titleMedium => _selectedTheme.titleMedium;

  TextStyle get titleMedium16 => _selectedTheme.titleMedium16;

  TextStyle get titleLarge16 => _selectedTheme.titleLarge16;

  TextStyle get titleSmall => _selectedTheme.titleSmall;

  TextStyle get bodyLarge => _selectedTheme.bodyLarge;

  TextStyle get bodyMedium => _selectedTheme.bodyMedium;

  TextStyle get bodySmall => _selectedTheme.bodySmall;

  TextStyle get displayLarge => _selectedTheme.displayLarge;

  TextStyle get displayMedium => _selectedTheme.displayMedium;

  TextStyle get titleSmallFontSize16 => _selectedTheme.titleSmallFontSize16;
}
