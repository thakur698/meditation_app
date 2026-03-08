import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/journal_provider.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final TextEditingController controller = TextEditingController();

  String selectedMood = "🙂";

  final List<String> moods = ["🙂", "😌", "😐", "😴", "😔"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reflection")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What is gently present with you right now?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            /// TEXT FIELD
            TextField(
              controller: controller,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Write your reflection...",
              ),
            ),

            const SizedBox(height: 20),

            /// MOODS
            const Text("Mood"),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: moods.map((mood) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMood = mood;
                    });
                  },
                  child: Text(
                    mood,
                    style: TextStyle(
                      fontSize: 30,
                      color: selectedMood == mood ? Colors.blue : Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),

            const Spacer(),

            /// SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<JournalProvider>().saveJournal(
                    controller.text,
                    selectedMood,
                  );

                  Navigator.pop(context);
                },
                child: const Text("Save Reflection"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
