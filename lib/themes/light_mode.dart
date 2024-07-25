import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme:
      ColorScheme.fromSeed(seedColor: const Color(0xff6200ee)).copyWith(
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade200,
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade900,
    surface: Colors.grey.shade300,
  ),
);
