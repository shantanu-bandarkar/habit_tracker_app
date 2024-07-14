import 'package:flutter/material.dart';
import 'package:habit_tracker_app/themes/dark_mode.dart';
import 'package:habit_tracker_app/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier{
  //intially, light mode
  ThemeData _themeData = lightMode;

  //get current theme
  ThemeData get themeData => _themeData;

  // check if dark theme is enabled
  bool get isDarkMode => _themeData == darkMode;

  //set theme
  set themeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  //toggle theme
  void toggleTheme() {
    if(_themeData == lightMode) {
      themeData = darkMode;
    }
    else{
      themeData = lightMode;
    }
  }
}