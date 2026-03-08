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

  String selectedMood = "😊";

  final moods = ["😊", "😌", "😴", "😔", "😡"];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reflection Journal"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "How do you feel?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            /// Mood selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      color: selectedMood == mood
                          ? Colors.blue
                          : Colors.black,
                    ),
                  ),
                );

              }).toList(),
            ),

            const SizedBox(height: 30),

            /// Reflection input
            TextField(
              controller: controller,
              maxLines: 4,

              decoration: const InputDecoration(
                hintText: "Write your reflection...",
                border: OutlineInputBorder(),
              ),
            ),

            const Spacer(),

            /// Save button
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