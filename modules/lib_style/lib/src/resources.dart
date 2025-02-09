import '../lib_style.dart';
import 'assets.dart';
import 'res/app_strings.dart';
import 'res/app_themes.dart';

class Resources {
  Resources(this._isLightMode);

  final AppThemeMode _isLightMode;

  AppStrings string = AppStrings();

  AppThemes get themes => AppThemes(_isLightMode);

  Assets get assets => Assets();
}
