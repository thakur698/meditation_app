import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'providers/ambience_provider.dart';
import 'providers/player_provider.dart';
import 'providers/journal_provider.dart';

import 'features/ambience/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize Hive
  await Hive.initFlutter();

  /// Open journal storage box
  await Hive.openBox('journal');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AmbienceProvider()),

        ChangeNotifierProvider(create: (_) => PlayerProvider()),

        ChangeNotifierProvider(create: (_) => JournalProvider()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Meditation App",

        theme: ThemeData(primarySwatch: Colors.blue),

        home: const HomeScreen(),
      ),
    );
  }
}
