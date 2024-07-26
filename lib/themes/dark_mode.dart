import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xffbb86fc),
    brightness: Brightness.dark,
  ).copyWith(
    primary: Colors.grey.shade600,
    secondary: const Color.fromARGB(255, 44, 44, 44),
    tertiary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade300,
  ),
);
