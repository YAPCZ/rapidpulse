import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'RapidPulse – Terms and Conditions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text('Last Updated: 19 August 2026'),

            SizedBox(height: 24),

            Text(
              '1. Acceptance of Terms',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              'By creating an account or using RapidPulse, '
              'you acknowledge that you have read, understood, '
              'and agreed to these Terms and Conditions.',
            ),

            SizedBox(height: 20),

            Text(
              '2. User Accounts',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              'Users are responsible for providing accurate '
              'information and keeping their account credentials '
              'confidential.',
            ),

            SizedBox(height: 20),

            Text(
              '3. Acceptable Use',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              'Users must not use RapidPulse for illegal activities, '
              'attempt to gain unauthorized access, upload harmful '
              'content, or interfere with the application.',
            ),

            SizedBox(height: 20),

            Text(
              '4. Application Availability',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              'RapidPulse aims to provide continuous access to its '
              'services. However, temporary interruptions may occur '
              'due to maintenance or technical problems.',
            ),

            SizedBox(height: 20),

            Text(
              '5. Changes to These Terms',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              'These Terms and Conditions may be updated from time '
              'to time. Users are encouraged to review the terms '
              'periodically.',
            ),

            SizedBox(height: 20),

            Text(
              '6. Contact Us',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              'If you have questions or feedback regarding these '
              'Terms and Conditions, please contact the RapidPulse '
              'development team.',
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}