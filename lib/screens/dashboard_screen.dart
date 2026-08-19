import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'trip_detail_screen.dart';
import 'package:rapidpulse_my/model/user_model.dart';

/// Main dashboard screen showing greeting, search bar, crowding info, and upcoming trips.
class DashboardScreen extends StatelessWidget {
  final User? user;
  const DashboardScreen({super.key, this.user});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(34, 24, 34, 16),
    children: [
      // Greeting section with user name and notification icon
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Good morning',
                  style: TextStyle(color: Color(0xFF6C727C), fontSize: 13),
                ),
                Text(
                  'Hi, ${user?.username ?? 'Guest'}',
                  style: const TextStyle(
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
      // Search bar placeholder
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
      // Live crowding trend section
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
      // Upcoming trips list
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

  /// Navigates to the trip detail screen.
  void _open(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const TripDetailScreen()),
  );
}

/// A horizontal bar chart component that visualizes crowding levels over time.
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

/// A reusable card component to display details of a single trip.
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
                // Transport mode icon
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(Icons.train_outlined, color: color, size: 19),
                ),
                const SizedBox(width: 11),
                // Trip info: Name and Destination
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
                // Timing info: Minutes and delay status
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
            // Crowding level indicator
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
                    color: color.withOpacity(0.12),
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

