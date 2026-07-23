import 'package:flutter/material.dart';

const navy = Color(0xFF16191E);
const teal = Color(0xFF19B777);
const mint = Color(0xFFE7F7EF);
const amber = Color(0xFFFFA326);
const red = Color(0xFFFF4B42);
const appBackground = Color(0xFFF4F5F7);

final appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: red),
  scaffoldBackgroundColor: appBackground,
  fontFamily: 'Arial',
);
