import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'dashboard_screen.dart';

class TripDetailScreen extends StatelessWidget {
  const TripDetailScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(34, 20, 34, 18),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new, size: 17),
                    onPressed: () => Navigator.pop(context),
                    ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'KL Sentral → Bukit Bintang',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'LRT Kelana Jaya Line · via KLCC',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6C727C),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(19),
              ),
              child: const Row(
                children: [
                  SizedBox(
                    width: 95,
                    height: 95,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: .62,
                          strokeWidth: 8,
                          color: amber,
                          backgroundColor: Color(0xFFE6E8EB),
                        ),
                        Text('62%', style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Medium crowding',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Blended from live reports & GTFS-realtime ridership',
                          style: TextStyle(
                            color: Color(0xFF6C727C),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(19),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Crowding — next hour',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 22),
                  CrowdBar(),
                ],
              ),
            ),
            const SizedBox(height: 17),
            Row(
              children: [
                const Text(
                  'LIVE TRACKING',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: mint,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Text(
                    '●  Low transfer risk',
                    style: TextStyle(
                      color: teal,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9),
            const Expanded(child: StationList()),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      side: const BorderSide(color: navy),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Set alert',
                      style: TextStyle(
                        color: navy,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      backgroundColor: red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Start tracking',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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

class StationList extends StatelessWidget {
  const StationList({super.key});
  @override
  Widget build(BuildContext context) => Column(
    children: const [
      Station('KL Sentral', '4:02 PM', Color(0xFF9AA2AD)),
      Station('Pasar Seni', '4:07 PM', red),
      Station('Masjid Jamek · transfer', '4:11 PM', Color(0xFFE1E4E8)),
      Station('KLCC', '4:18 PM', Color(0xFFE1E4E8)),
      Station('Bukit Bintang', '4:23 PM', Color(0xFFE1E4E8)),
    ],
  );
}

class Station extends StatelessWidget {
  final String name, time;
  final Color color;
  const Station(this.name, this.time, this.color, {super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: color == const Color(0xFFE1E4E8)
                  ? const Color(0xFF9AA2AD)
                  : navy,
            ),
          ),
        ),
        Text(time, style: const TextStyle(fontSize: 16)),
      ],
    ),
  );
}
