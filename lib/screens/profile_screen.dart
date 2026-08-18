import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'auth_screens.dart';
import 'package:rapidpulse_my/model/user_model.dart';
import 'package:rapidpulse_my/sql/session_manager.dart';
import 'package:rapidpulse_my/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  final User? user;

  const ProfileScreen({
    super.key,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    final isGuest = user == null;
    
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        CircleAvatar(
          radius: 34,
          backgroundColor: isGuest ? Colors.grey[200] : mint,
          child: Icon(
            isGuest ? Icons.person_outline : Icons.person,
            size: 40,
            color: isGuest ? Colors.grey : teal,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          isGuest ? 'Guest User' : user!.username,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: navy,
          ),
        ),
        if (!isGuest)
          Text(user!.email, textAlign: TextAlign.center)
        else
          const Text(
            'Log in to sync your data across devices',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
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
        if (isGuest)
          FilledButton.icon(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
              );
            },
            style: FilledButton.styleFrom(backgroundColor: red),
            icon: const Icon(Icons.login),
            label: const Text('Log In / Sign Up'),
          )
        else
          TextButton.icon(
            onPressed: () async {
              await AuthService.instance.signOut();
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
}
