import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class JournalProvider extends ChangeNotifier {

  final Box journalBox = Hive.box('journal');

  List get journals => journalBox.values.toList();

  void saveJournal(String text, String mood) {

    journalBox.add({
      "text": text,
      "mood": mood,
      "date": DateTime.now().toString(),
    });

    notifyListeners();
  }
}