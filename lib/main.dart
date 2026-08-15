import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    runApp(const RapidPulseApp());
}

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