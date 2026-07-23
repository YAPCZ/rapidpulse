import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LiveMapScreen extends StatelessWidget {
  const LiveMapScreen({super.key});
  @override
  Widget build(BuildContext context) => Container(
    color: const Color(0xFF10172E),
    child: Stack(
      children: [
        CustomPaint(size: Size.infinite, painter: RailMap()),
        const Positioned(
          top: 28,
          left: 34,
          right: 34,
          child: Row(
            children: [
              Text(
                'Live map',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Spacer(),
              Icon(Icons.filter_alt_outlined, color: Colors.white),
            ],
          ),
        ),
        const Positioned(
          top: 90,
          left: 46,
          child: Text(
            '● Low   ● Medium   ● High',
            style: TextStyle(color: Colors.white, fontSize: 11),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 14,
          child: Container(
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'NEAREST STATION',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6C727C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Pasar Seni',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 8),
                Text(
                  'View line details  ›',
                  style: TextStyle(color: red, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class RailMap extends CustomPainter {
  @override
  void paint(Canvas c, Size s) {
    final p = Paint()
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    p.color = teal;
    c.drawLine(
      Offset(24, s.height * .39),
      Offset(s.width * .65, s.height * .39),
      p,
    );
    c.drawLine(
      Offset(s.width * .65, s.height * .2),
      Offset(s.width * .65, s.height * .39),
      p,
    );
    c.drawLine(Offset(24, s.height * .39), Offset(24, s.height * .75), p);
    p.color = red;
    c.drawLine(
      Offset(s.width * .35, s.height * .22),
      Offset(s.width * .35, s.height * .48),
      p,
    );
    c.drawLine(
      Offset(s.width * .35, s.height * .48),
      Offset(s.width * .9, s.height * .48),
      p,
    );
    for (final point in [
      Offset(24, s.height * .39),
      Offset(s.width * .35, s.height * .22),
      Offset(s.width * .35, s.height * .48),
      Offset(s.width * .65, s.height * .2),
      Offset(s.width * .65, s.height * .39),
      Offset(s.width * .9, s.height * .48),
    ]) {
      c.drawCircle(
        point,
        7,
        Paint()
          ..color = point.dx == s.width * .35 && point.dy == s.height * .48
              ? red
              : teal,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
