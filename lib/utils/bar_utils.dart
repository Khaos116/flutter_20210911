import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarUtils {
  static void setBarColors({Color statusColor = Colors.transparent, Color naviColor = Colors.black, bool statusDarkMode = true, bool naviDarkMode = false}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: naviColor,
      systemNavigationBarDividerColor: null,
      statusBarColor: statusColor,
      systemNavigationBarIconBrightness: naviDarkMode ? Brightness.dark : Brightness.light,
      statusBarIconBrightness: statusDarkMode ? Brightness.dark : Brightness.light,
      statusBarBrightness: statusDarkMode ? Brightness.dark : Brightness.light,
    ));
  }
}
