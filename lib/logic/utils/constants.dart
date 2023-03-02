import 'package:flutter/material.dart';

class AppData {
  static const String baseUrl = "https://fakestoreapi.com";
  static const Duration httpTimeout = Duration(seconds: 60);
  static const int maxCartValue = 20;
  static ColorScheme colorScheme(BuildContext context) =>
      Theme.of(context).colorScheme;

  static TextTheme textTheme(BuildContext context) =>
      Theme.of(context).textTheme;
}
