import 'package:flutter/material.dart';
import '../../../data/models/ambience_model.dart';

class AmbienceCard extends StatelessWidget {
  final AmbienceModel ambience;
  final VoidCallback onTap;

  const AmbienceCard({super.key, required this.ambience, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                "assets/images/${ambience.image}",
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            /// TEXT
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ambience.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${ambience.tag} • ${ambience.duration ~/ 60} min",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
