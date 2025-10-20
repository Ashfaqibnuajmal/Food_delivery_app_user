import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mera_app/core/theme/app_color.dart';
import 'package:mera_app/core/widgets/loading.dart';

// ignore: must_be_immutable
class FoodDetails extends StatelessWidget {
  final String foodItemId;
  FoodDetails({super.key, required this.foodItemId});

  bool isHalfSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("FoodItems")
            .doc(foodItemId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("❌ Food details not found"));
          }

          final food = snapshot.data!;
          final image = food['imageUrl'] ?? '';
          final name = food['name'] ?? 'Unknown';
          final prepTime = food['prepTimeMinutes'] ?? 0;
          final calories = food['calories'] ?? 0;
          final price = food['price'] ?? 0;
          final halfPrice = food["halfPrice"] ?? 0;
          final description = food['description'] ?? '';
          final isHalfAvailable = food['isHalfAvailable'] ?? false;

          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // 🟧 Header Image + Icons
                  Stack(
                    children: [
                      Container(
                        height: 350,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryOrange,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        right: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        left: 40,
                        right: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            image,
                            fit: BoxFit.fill,
                            height: 300,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image, size: 100),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Gap(30),
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ⭐ Info Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star,
                              size: 16, color: AppColors.primaryOrange),
                          const SizedBox(width: 8),
                          Text('4.5',
                              style: TextStyle(color: Colors.grey.shade700)),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 15,
                        color: Colors.black,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.timer_outlined,
                              size: 16, color: AppColors.primaryOrange),
                          const SizedBox(width: 8),
                          Text('$prepTime min',
                              style: TextStyle(color: Colors.grey.shade700)),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 15,
                        color: Colors.black,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.local_fire_department,
                              size: 16, color: AppColors.primaryOrange),
                          const SizedBox(width: 8),
                          Text('$calories Ka',
                              style: TextStyle(color: Colors.grey.shade700)),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // 📝 Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 🍛 Half / Full Buttons (Static UI)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (isHalfAvailable) // Only show if half portion exists
                        Container(
                          width: 140,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white, // static white background
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.primaryOrange),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  image,
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                "Half",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "₹$halfPrice.00",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Full portion (always visible)
                      Container(
                        width: 140,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white, // static white background
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.primaryOrange),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                image,
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "Full",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "₹$price.00",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          );
        },
      ),

      // 🛒 Add to Cart Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "✅ Added to cart successfully",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: AppColors.primaryOrange,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Add to cart",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
