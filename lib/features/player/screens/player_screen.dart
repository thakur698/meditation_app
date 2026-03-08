import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/ambience_model.dart';
import '../../../providers/player_provider.dart';
import '../../journal/screens/journal_screen.dart';

class PlayerScreen extends StatefulWidget {
  final AmbienceModel ambience;

  const PlayerScreen({super.key, required this.ambience});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  Timer? timer;
  int elapsedSeconds = 0;

  /// START SESSION
  void startSession() {
    final playerProvider = context.read<PlayerProvider>();

    playerProvider.playAudio("audio/${widget.ambience.audio}");

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        elapsedSeconds++;
      });

      if (elapsedSeconds >= widget.ambience.duration) {
        endSession();
      }
    });
  }

  /// END SESSION
  void endSession() {
    timer?.cancel();

    context.read<PlayerProvider>().stopAudio();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const JournalScreen()),
    );
  }

  /// FORMAT TIMER
  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;

    return "${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remaining = widget.ambience.duration - elapsedSeconds;

    return Scaffold(
      appBar: AppBar(title: Text(widget.ambience.title)),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "assets/images/${widget.ambience.image}",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 40),

            /// TIMER CIRCLE
            SizedBox(
              height: 220,
              width: 220,

              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: elapsedSeconds / widget.ambience.duration,
                    strokeWidth: 10,
                  ),

                  Text(
                    formatTime(remaining),
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            /// BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: startSession,
                  child: const Text("Start"),
                ),

                const SizedBox(width: 20),

                ElevatedButton(
                  onPressed: endSession,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("End"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
