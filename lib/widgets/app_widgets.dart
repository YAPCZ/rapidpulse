import 'package:flutter_test/flutter_test.dart';
import 'package:rapidpulse_my/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('opens the guest dashboard after the splash screen', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const RapidPulseApp());

    expect(find.text('RapidPulse MY'), findsOneWidget);

    // Finish the 1.6-second splash delay.
    await tester.pump(const Duration(milliseconds: 1600));

    // Finish the page-navigation animation.
    await tester.pumpAndSettle();

    expect(find.text('LIVE NOW · KELANA JAYA LINE'), findsOneWidget);
  });
}