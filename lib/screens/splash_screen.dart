import 'package:flutter/material.dart';
import 'package:rapidpulse_my/screens/app_shell.dart';
import 'package:rapidpulse_my/sql/session_manager.dart';
import 'package:rapidpulse_my/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../theme/app_theme.dart';

/// The app's launch screen. New users enter the dashboard as guests.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    // Check Supabase session (Google login)
    final supabaseUser = await AuthService.instance.getCurrentUser();

    await Future.delayed(const Duration(milliseconds: 1600));

    if (!mounted) return;

    // Google / Supabase login
    if (supabaseUser != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => AppShell(user: supabaseUser),
        ),
      );
      return;
    }

    // No login → guest
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const AppShell(user: null),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: navy,
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(color: red, shape: BoxShape.circle),
            child: const Icon(
              Icons.insights_rounded,
              color: Colors.white,
              size: 50,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'RapidPulse MY',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Move smarter. Avoid the rush.',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    ),
  );
}
