import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const RapidPulseApp());

class RapidPulseApp extends StatelessWidget {
  const RapidPulseApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'RapidPulse MY',
    debugShowCheckedModeBanner: false,
    theme: appTheme,
    home: const SplashScreen(),
  );
}
