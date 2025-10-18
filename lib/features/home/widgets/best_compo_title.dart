import 'package:flutter/material.dart';
import 'package:mera_app/features/home/screens/best_compo_screen.dart';

class BestCompoHeading extends StatelessWidget {
  const BestCompoHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Best Compo",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            shadows: [
              Shadow(
                offset: Offset(0, 1.5),
                blurRadius: 4,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BestCompoScreen(),
              ),
            );
          },
          child: Text(
            "View",
            style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: Colors.grey,
              decorationThickness: 1.5,
              shadows: [
                Shadow(
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                  color: Colors.black.withOpacity(0.3),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
