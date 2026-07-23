import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import 'app_shell.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new),
                style: IconButton.styleFrom(backgroundColor: Colors.white),
              ),
            ),
            const SizedBox(height: 28),
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: red,
                    child: Icon(
                      Icons.monitor_heart_outlined,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'RapidPulse MY',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Welcome back',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: navy,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Log in to track live crowding & delays on your commute.',
              style: TextStyle(color: Color(0xFF8993A2), fontSize: 12),
            ),
            const SizedBox(height: 17),
            const FieldLabel('Email'),
            const AppInput(
              label: 'faiz.ahmad@email.com',
              icon: Icons.mail_outline,
            ),
            const SizedBox(height: 11),
            const FieldLabel('Password'),
            const AppInput(
              label: '••••••••••',
              icon: Icons.lock_outline,
              obscure: true,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: red,
                  textStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Forgot Password?'),
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: red,
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const AppShell(isLoggedIn: true),
                ),
              ),
              child: const Text('Log In'),
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'or continue with',
                    style: TextStyle(fontSize: 10, color: Color(0xFF9DA5B1)),
                  ),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(42),
                side: const BorderSide(color: Color(0xFFE9EAED)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              onPressed: () {},
              icon: const Text(
                'G',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              label: const Text(
                'Continue with Google',
                style: TextStyle(
                  color: navy,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 10, color: Color(0xFF8993A2)),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: red,
                    textStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    ),
  );
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new),
                style: IconButton.styleFrom(backgroundColor: Colors.white),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Create account',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: navy,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Join RapidPulse MY to commute smarter, every day.',
              style: TextStyle(color: Color(0xFF8993A2), fontSize: 12),
            ),
            const SizedBox(height: 16),
            const FieldLabel('Full Name'),
            const AppInput(label: 'Ahmad Faiz', icon: Icons.person_outline),
            const SizedBox(height: 10),
            const FieldLabel('Email'),
            const AppInput(
              label: 'faiz.ahmad@email.com',
              icon: Icons.mail_outline,
            ),
            const SizedBox(height: 10),
            const FieldLabel('Phone Number'),
            const AppInput(
              label: '+60 12-345 6789',
              icon: Icons.phone_outlined,
            ),
            const SizedBox(height: 10),
            const FieldLabel('Password'),
            const AppInput(
              label: '••••••••••',
              icon: Icons.lock_outline,
              obscure: true,
            ),
            Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (_) {},
                  activeColor: red,
                  visualDensity: VisualDensity.compact,
                ),
                const Expanded(
                  child: Text(
                    "I agree to RapidPulse MY's Terms of Service and Privacy Policy",
                    style: TextStyle(fontSize: 9, color: Color(0xFF6B7280)),
                  ),
                ),
              ],
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: red,
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const AppShell(isLoggedIn: true),
                ),
              ),
              child: const Text('Create Account'),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(fontSize: 10, color: Color(0xFF8993A2)),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: red,
                    textStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Log In'),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    ),
  );
}

class FieldLabel extends StatelessWidget {
  final String text;
  const FieldLabel(this.text, {super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Text(
      text,
      style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
    ),
  );
}
