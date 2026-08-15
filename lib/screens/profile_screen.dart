import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'auth_screens.dart';
import 'package:rapidpulse_my/model/user_model.dart';
import 'package:rapidpulse_my/sql/session_manager.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) =>
    ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const CircleAvatar(
          radius: 34,
          backgroundColor: mint,
          child: Icon(Icons.person, size: 40, color: teal),
        ),
        const SizedBox(height: 10),
        Text(
          user.username,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: navy,
          ),
        ),
        Text(user.email, textAlign: TextAlign.center),
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
          onPressed: () async {
            await SessionManager.clearSession();
            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
              );
            }
          },
          icon: const Icon(Icons.logout, color: red),
          label: const Text('Log out', style: TextStyle(color: red)),
        ),
      ],
    );
}
