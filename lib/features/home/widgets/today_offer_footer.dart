import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mera_app/core/theme/app_color.dart';

class TodayOfferFooter extends StatelessWidget {
  final int currentIndex;

  const TodayOfferFooter({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("FoodItems")
          .where("isTodayOffer", isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();
        final count = snapshot.data!.docs.length;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(count, (index) {
            final isActive = currentIndex == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: isActive ? 10 : 8,
              height: isActive ? 10 : 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive
                    ? AppColors.primaryOrange
                    : Colors.grey.withOpacity(0.4),
              ),
            );
          }),
        );
      },
    );
  }
}
