import 'package:flutter/material.dart';

class HackathonsScreen extends StatelessWidget {
  const HackathonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Hackathons',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Participate in our contests and earn rewards.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
