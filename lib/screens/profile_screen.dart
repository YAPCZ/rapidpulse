import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'auth_screens.dart';

class ProfileScreen extends StatelessWidget {
  final bool isLoggedIn;
  const ProfileScreen({super.key, required this.isLoggedIn});
  @override
  Widget build(BuildContext context) =>
      isLoggedIn ? _signedInProfile(context) : _guestProfile(context);

  Widget _guestProfile(BuildContext context) => Padding(
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 42,
          backgroundColor: Color.fromARGB(255, 247, 231, 231),
          child: Icon(Icons.person_outline, size: 48, color: red),
        ),
        const SizedBox(height: 20),
        const Text(
          'Your commute, your way',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: navy,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Log in to save routes and receive personalised crowding alerts.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 28),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: red,
            minimumSize: const Size.fromHeight(52),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          ),
          child: const Text('Log in'),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SignUpScreen()),
          ),
          child: const Text('Sign up'),
        ),
      ],
    ),
  );

  Widget _signedInProfile(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const CircleAvatar(
        radius: 34,
        backgroundColor: mint,
        child: Icon(Icons.person, size: 40, color: teal),
      ),
      const SizedBox(height: 10),
      const Text(
        'Cheng Yap',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          color: navy,
        ),
      ),
      const Text('cheng@example.com', textAlign: TextAlign.center),
      const SizedBox(height: 28),
      const Text(
        'Saved routes',
        style: TextStyle(fontWeight: FontWeight.bold, color: navy),
      ),
      const Card(
        child: ListTile(
          leading: Icon(Icons.bookmark_outline, color: teal),
          title: Text('Home to Work'),
          subtitle: Text('Taman Bahagia to KL Sentral'),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
      const SizedBox(height: 20),
      const Text(
        'Preferences',
        style: TextStyle(fontWeight: FontWeight.bold, color: navy),
      ),
      const Card(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.notifications_outlined),
              title: Text('Crowding alerts'),
              trailing: Switch(value: true, onChanged: null),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
              trailing: Text('English'),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      TextButton.icon(
        onPressed: () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (_) => false,
        ),
        icon: const Icon(Icons.logout, color: red),
        label: const Text('Log out', style: TextStyle(color: red)),
      ),
    ],
  );
}
