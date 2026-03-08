import 'package:flutter/material.dart';

import '../../../data/models/ambience_model.dart';
import '../../player/screens/player_screen.dart';

class AmbienceDetailsScreen extends StatelessWidget {
  final AmbienceModel ambience;

  const AmbienceDetailsScreen({super.key, required this.ambience});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ambience.title)),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            Text(
              ambience.title,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Chip(label: Text(ambience.tag)),

            const SizedBox(height: 10),

            Text(
              "Duration: ${ambience.duration ~/ 60} minutes",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            Text(ambience.description, style: const TextStyle(fontSize: 16)),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PlayerScreen(ambience: ambience),
                    ),
                  );
                },
                child: const Text("Start Session"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
