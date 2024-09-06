import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
import 'package:tiani/functionality/data.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Colors.blue,
    primaryContainer: Colors.white,
    secondary: Colors.black,
  )
);
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  canvasColor: Colors.black,
  colorScheme: ColorScheme.dark(
    primary: Colors.blue,
    primaryContainer: Colors.black,
    secondary: Colors.white,
  )
);
