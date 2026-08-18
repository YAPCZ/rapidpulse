import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://urrcpzsaroefkftbjpfd.supabase.co',
    anonKey: 'sb_publishable_YWXu0chlejhtELHIAzmPwA_ECN1GVpK',
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