import 'package:flutter/material.dart';
import 'package:rapidpulse_my/screens/auth_screens.dart';
import 'package:rapidpulse_my/screens/app_shell.dart';
import 'package:rapidpulse_my/sql/session_manager.dart';
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
    final user = await SessionManager.getUser();
    
    await Future.delayed(const Duration(milliseconds: 1600));

    if (!mounted) return;

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AppShell(user: user)),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
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
