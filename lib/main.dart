import 'package:flutter/material.dart';
import 'package:habit_tracker_app/pages/home_page.dart';
import 'package:habit_tracker_app/themes/dark_mode.dart';
import 'package:habit_tracker_app/themes/light_mode.dart';
import 'package:habit_tracker_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habit Tracker',
      home: HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
