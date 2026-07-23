import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'trip_detail_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(34, 24, 34, 16),
    children: [
      Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning',
                  style: TextStyle(color: Color(0xFF6C727C), fontSize: 13),
                ),
                Text(
                  'Hi, Aiman',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: navy,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Badge(
              smallSize: 7,
              child: Icon(Icons.notifications_none, size: 20),
            ),
          ),
        ],
      ),
      const SizedBox(height: 18),
      Container(
        height: 47,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Row(
          children: [
            Icon(Icons.search, color: Color(0xFF9AA2AD)),
            SizedBox(width: 12),
            Text('Where to?', style: TextStyle(color: Color(0xFF9AA2AD))),
          ],
        ),
      ),
      const SizedBox(height: 16),
      const Text(
        'LIVE NOW · KELANA JAYA LINE',
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Column(
          children: [
            Row(
              children: [
                Text(
                  'Crowding trend · next 60 min',
                  style: TextStyle(color: Color(0xFF6C727C), fontSize: 12),
                ),
                Spacer(),
                Text(
                  '62%',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 22),
            CrowdBar(),
          ],
        ),
      ),
      const SizedBox(height: 17),
      const Text(
        'UPCOMING TRIPS',
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 8),
      TripCard(
        title: 'LRT · Kelana Jaya',
        destination: 'to Bukit Bintang',
        minutes: '4 min',
        crowd: 'Low',
        color: teal,
        onTap: () => _open(context),
      ),
      const SizedBox(height: 10),
      TripCard(
        title: 'MRT · Kajang Line',
        destination: 'to KL Sentral',
        minutes: '9 min',
        crowd: 'High',
        color: red,
        delayed: true,
        onTap: () => _open(context),
      ),
      const SizedBox(height: 10),
      TripCard(
        title: 'KTM · Port Klang',
        destination: 'to Subang Jaya',
        minutes: '14 min',
        crowd: 'Medium',
        color: amber,
        onTap: () => _open(context),
      ),
    ],
  );
  void _open(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const TripDetailScreen()),
  );
}

class CrowdBar extends StatelessWidget {
  const CrowdBar({super.key});
  @override
  Widget build(BuildContext context) => Row(
    children: [
      for (final color in [
        teal,
        teal,
        teal,
        amber,
        amber,
        amber,
        amber,
        amber,
        red,
        amber,
        amber,
        amber,
        teal,
      ])
        Expanded(
          child: Container(
            height: 11,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
    ],
  );
}

class TripCard extends StatelessWidget {
  final String title, destination, minutes, crowd;
  final Color color;
  final bool delayed;
  final VoidCallback onTap;
  const TripCard({
    super.key,
    required this.title,
    required this.destination,
    required this.minutes,
    required this.crowd,
    required this.color,
    this.delayed = false,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(17),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(17),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(Icons.train_outlined, color: color, size: 19),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Text(
                        destination,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6C727C),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(minutes, style: const TextStyle(fontSize: 17)),
                    Text(
                      delayed ? '+6 min delay' : 'On time',
                      style: TextStyle(
                        fontSize: 11,
                        color: delayed ? red : teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 11),
              child: Divider(height: 1),
            ),
            const SizedBox(height: 9),
            Row(
              children: [
                const Text(
                  'Crowding',
                  style: TextStyle(fontSize: 12, color: Color(0xFF6C727C)),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.circle, color: color, size: 7),
                      const SizedBox(width: 5),
                      Text(
                        crowd,
                        style: TextStyle(
                          color: color,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
