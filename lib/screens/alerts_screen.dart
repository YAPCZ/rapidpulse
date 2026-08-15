import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(34, 24, 34, 16),
    children: [
      Row(
        children: [
          const Text(
            'Alerts',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(foregroundColor: red),
            child: const Text(
              'Mark all read',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      Row(
        children: [
          FilterChip(
            label: const Text('All'),
            selected: true,
            onSelected: (_) {},
          ),
          const SizedBox(width: 16),
          const Text(
            'Delays',
            style: TextStyle(
              color: Color(0xFF6C727C),
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 32),
          const Text(
            'Crowding',
            style: TextStyle(
              color: Color(0xFF6C727C),
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      const PrototypeAlert(
        icon: Icons.warning_amber_rounded,
        color: red,
        title: 'Crowding alert · KJ Line',
        body: 'Masjid Jamek platform is at High capacity right now.',
        time: '2 min ago',
      ),
      const SizedBox(height: 10),
      const PrototypeAlert(
        icon: Icons.access_time,
        color: amber,
        title: 'Delay · Kajang Line',
        body: 'Trains toward KL Sentral are running 6 min behind.',
        time: '11 min ago',
      ),
      const SizedBox(height: 10),
      const PrototypeAlert(
        icon: Icons.check,
        color: teal,
        title: 'Route back to normal',
        body: 'Port Klang Line service has resumed as scheduled.',
        time: '38 min ago',
      ),
      const SizedBox(height: 10),
      const PrototypeAlert(
        icon: Icons.access_time,
        color: amber,
        title: 'Delay · Ampang Line',
        body: 'Signal fault near Chan Sow Lin, expect +4 min.',
        time: '1 hr ago',
      ),
    ],
  );
}

class PrototypeAlert extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title, body, time;
  const PrototypeAlert({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
    required this.time,
  });
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                body,
                style: const TextStyle(color: Color(0xFF6C727C), fontSize: 13),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: const TextStyle(color: Color(0xFF9AA2AD), fontSize: 11),
        ),
      ],
    ),
  );
}
