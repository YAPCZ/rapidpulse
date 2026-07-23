import 'package:flutter_test/flutter_test.dart';
import 'package:rapidpulse_my/main.dart';

void main() {
  testWidgets('renders the RapidPulse splash screen', (tester) async {
    await tester.pumpWidget(const RapidPulseApp());
    expect(find.text('RapidPulse MY'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1600));
    await tester.pump();
    expect(find.text('LIVE NOW · KELANA JAYA LINE'), findsOneWidget);
  });
}
