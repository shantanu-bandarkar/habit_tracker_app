import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),drawer: Drawer(
      child: Center(
        child: CupertinoSwitch(
          value: Provider.of<ThemeProvider>(context).isDarkMode,
          onChanged: (value) => Provider.of<ThemeProvider>(context,listen: false).toggleTheme(),
        ),
      ),

    ),);
  }
}