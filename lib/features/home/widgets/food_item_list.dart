import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mera_app/features/favorites/bloc/favorite_bloc.dart';
import 'package:mera_app/features/favorites/bloc/favorite_event.dart';
import 'package:mera_app/features/favorites/bloc/favorite_state.dart';
import 'package:mera_app/core/theme/app_color.dart';
import 'package:mera_app/core/widgets/loading.dart';
import 'package:mera_app/features/home/screens/food_details.dart';

class FoodItemsList extends StatelessWidget {
  const FoodItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("FoodItems").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoadingIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              "No Food Items Found",
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        final foodItems = snapshot.data!.docs;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: foodItems.length,
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemBuilder: (context, index) {
            final food = foodItems[index].data()! as Map<String, dynamic>;
            final doc = foodItems[index];
            final id = doc.id;
            final bool isBestSeller = food["isBestSeller"] == true;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Stack(
                children: [
                  // Main Container
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FoodDetails(foodItemId: id)));
                    },
                    child: Stack(children: [
                      Container(
                        height: 124,
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: AppColors.primaryOrange.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryOrange.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(1, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Image Section
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                food["imageUrl"] ?? "",
                                height: 80,
                                width: 80,
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.image_not_supported),
                              ),
                            ),
                            const SizedBox(width: 20),

                            // Details Column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          food["name"] ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      const Icon(Icons.timer_outlined,
                                          size: 15, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text(
                                        "${food["prepTimeMinutes"]} min",
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  const Row(
                                    children: [
                                      Icon(Icons.star,
                                          size: 15,
                                          color: AppColors.primaryOrange),
                                      SizedBox(width: 4),
                                      Text(
                                        "4.5",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        " ₹ ${food["price"]}.00",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryOrange,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 2,
                                              offset: Offset(1, 2),
                                            ),
                                          ],
                                        ),
                                        child: const Row(
                                          children: [
                                            Text(
                                              "Add",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(width: 4),
                                            Icon(Icons.add_circle_rounded,
                                                color: Colors.black),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<FavoriteBloc, FavoriteState>(
                        builder: (context, favState) {
                          final isFav = favState.favorites
                              .any((item) => item['id'] == id);
                          return Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryOrange,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  if (isFav) {
                                    context
                                        .read<FavoriteBloc>()
                                        .add(RemoveFromFavorite(id));
                                  } else {
                                    final favItems = {
                                      'id': id,
                                      'name': food['name'],
                                      'price': food['price'],
                                      "imageUrl": food['imageUrl']
                                    };
                                    context
                                        .read<FavoriteBloc>()
                                        .add(AddToFavorite(favItems));
                                  }
                                },
                                icon: Icon(
                                  isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets
                                    .zero, // centers the icon properly
                                constraints:
                                    const BoxConstraints(), // removes default extra padding
                              ),
                            ),
                          );
                        },
                      )
                    ]),
                  ),
                  if (isBestSeller)
                    Positioned(
                      top: -10,
                      left: 4,
                      child: Image.asset(
                        "assets/best-seller.png",
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
