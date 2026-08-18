import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'trip_detail_screen.dart';

class SearchTripScreen extends StatelessWidget {
  const SearchTripScreen({super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(34, 22, 34, 18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(width: 16),
            const Text(
              'Plan a trip',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: navy,
              ),
            ),
          ],
        ),
        const SizedBox(height: 19),
        Container(
          padding: const EdgeInsets.all(19),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            children: [
              RoutePlace(label: 'FROM', place: 'KL Sentral'),
              Divider(height: 24),
              RoutePlace(label: 'TO', place: 'Bukit Bintang'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
              decoration: BoxDecoration(
                color: navy,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Text(
                'Depart now',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(width: 24),
            const Text(
              'Pick a time',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF6C727C),
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),
        const Text(
          'RECENT SEARCHES',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const RecentRoute('KL Sentral → Bukit Bintang'),
        const Divider(),
        const RecentRoute('Subang Jaya → Mid Valley'),
        const Divider(),
        const RecentRoute('Home → Pavilion KL'),
        const Spacer(),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: red,
            minimumSize: const Size.fromHeight(55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TripDetailScreen()),
          ),
          child: const Text(
            'Find best route',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

class RoutePlace extends StatelessWidget {
  final String label, place;
  const RoutePlace({super.key, required this.label, required this.place});
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF1F0),
          borderRadius: BorderRadius.circular(9),
        ),
        child: const Icon(Icons.location_on_outlined, color: red, size: 19),
      ),
      const SizedBox(width: 15),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF6C727C),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            place,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    ],
  );
}

class RecentRoute extends StatelessWidget {
  final String text;
  const RecentRoute(this.text, {super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 9),
    child: Row(
      children: [
        const Icon(Icons.access_time, size: 16, color: Color(0xFF9AA2AD)),
        const SizedBox(width: 13),
        Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}
