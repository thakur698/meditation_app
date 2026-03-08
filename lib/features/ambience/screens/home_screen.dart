import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/ambience_provider.dart';
import '../widgets/ambience_card.dart';
import 'ambience_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  String selectedTag = "All";

  final List<String> tags = ["All", "Focus", "Calm", "Sleep", "Reset"];

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<AmbienceProvider>().loadAmbiences();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AmbienceProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Ambience Library"), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Search Bar
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search ambience",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// Filter Chips
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: tags.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final tag = tags[index];

                  return ChoiceChip(
                    label: Text(tag),
                    selected: selectedTag == tag,
                    onSelected: (_) {
                      setState(() {
                        selectedTag = tag;
                      });
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            /// Grid
            Expanded(
              child: provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      itemCount: provider.ambiences.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.75,
                          ),
                      itemBuilder: (context, index) {
                        final ambience = provider.ambiences[index];

                        return AmbienceCard(
                          ambience: ambience,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    AmbienceDetailsScreen(ambience: ambience),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
