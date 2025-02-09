import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../lib_style.dart';

/// A utility class for managing the appearance of the system status bar in a Flutter app.
class StatusBarHandler {
  /// Updates the status bar overlay style to make it dark with the specified background color.
  ///
  /// [res] - The Flutter `Resources` object.
  ///
  /// [isOverlayVisible] - A boolean value indicating whether an overlay is currently visible.
  /// If `true`, the status bar will have a dark icon color and a light background; otherwise,
  /// it will be transparent.
  void updateStatusBarWithOverlay(
    Resources res, {
    required bool isOverlayVisible,
  }) {
    setSystemChrome(
      statusBarColor:
          _getStatusBarColor(res, isOverlayVisible: isOverlayVisible),
      statusBarIconBrightness: Brightness.dark,
    );
  }

  /// Updates the status bar overlay style to make it dark with a transparent background.
  void updateStatusBarToDark() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  /// Updates the status bar overlay style with a custom background color.
  ///
  /// [color] - The custom color to set as the status bar background.
  void updateStatusBarWithColor(Color color) {
    setSystemChrome(statusBarColor: color);
  }

  /// Determines the appropriate status bar color based on the overlay visibility.
  ///
  /// [res] - The Flutter `Resources` object.
  ///
  /// [isOverlayVisible] - A boolean value indicating whether an overlay is currently visible.
  ///
  /// Returns the color for the status bar. If [isOverlayVisible] is `true`, it returns the
  /// specified color from the resources object; otherwise, it returns a transparent color.
  Color _getStatusBarColor(Resources res, {required bool isOverlayVisible}) {
    return isOverlayVisible
        ? res.themes.lightBlack
        : Colors.transparent;
  }

  /// Applies the given color and brightness to the system chrome.
  ///
  /// The [statusBarColor] parameter is an optional color that defines the background color of the status bar.
  ///
  /// The [statusBarIconBrightness] parameter is an optional brightness that sets the color of status bar icons.
  ///
  /// This function utilizes the `SystemChrome.setSystemUIOverlayStyle` method to update the system UI overlay style with the given [statusBarColor] and [statusBarIconBrightness].
  ///
  /// Example usage:
  ///
  /// ```dart
  /// setSystemChrome(
  ///   statusBarColor: Colors.blue,
  ///   statusBarIconBrightness: Brightness.light,
  /// );
  /// ```
  void setSystemChrome({
    Color? statusBarColor,
    Brightness? statusBarIconBrightness,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness,
      ),
    );
  }
}
