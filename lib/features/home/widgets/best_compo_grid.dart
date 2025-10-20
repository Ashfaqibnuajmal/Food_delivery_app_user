import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mera_app/core/blocs/favorite/favorite_bloc.dart';
import 'package:mera_app/core/blocs/favorite/favorite_event.dart';
import 'package:mera_app/core/blocs/favorite/favorite_state.dart';
import 'package:mera_app/core/theme/app_color.dart';
import 'package:mera_app/core/widgets/loading.dart';
import 'package:mera_app/features/home/screens/food_details.dart';

class BestCompoCardGrid extends StatelessWidget {
  const BestCompoCardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("FoodItems")
            .where("isCompo", isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: LoadingIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No Compo items found!"),
            );
          }

          final foodItems = snapshot.data!.docs;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: foodItems.length > 4 ? 4 : foodItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.74,
            ),
            itemBuilder: (context, index) {
              final food = foodItems[index].data()! as Map<String, dynamic>;
              final doc = foodItems[index];
              final id = doc.id;

              return AspectRatio(
                aspectRatio: 0.8,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FoodDetails(foodItemId: id)));
                  },
                  child: Stack(children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.2)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 25),
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    food['imageUrl'] ?? "",
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.fill,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                food["name"] ?? "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          "₹${food["price"]}.00",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Food item successfully added',
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .primaryOrange,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.check_circle_outline,
                                                    color:
                                                        AppColors.primaryOrange,
                                                  ),
                                                ],
                                              ),
                                              backgroundColor: Colors.white,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              duration:
                                                  const Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: const BoxDecoration(
                                            color: AppColors.primaryOrange,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 0,
                            left: -3,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.star,
                                      color: AppColors.primaryOrange, size: 14),
                                  SizedBox(width: 3),
                                  Text(
                                    "4.5",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<FavoriteBloc, FavoriteState>(
                      builder: (context, favState) {
                        final bool isFav =
                            favState.favorites.any((item) => item['id'] == id);
                        return Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryOrange,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
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
                                    'prepTimeMinutes': food['prepTimeMinutes'],
                                    'imageUrl': food['imageUrl']
                                  };
                                  context
                                      .read<FavoriteBloc>()
                                      .add(AddToFavorite(favItems));
                                }
                              },
                              icon: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: Colors.white,
                              ),
                              padding:
                                  EdgeInsets.zero, // centers the icon properly
                              constraints:
                                  const BoxConstraints(), // removes default extra padding
                            ),
                          ),
                        );
                      },
                    )
                  ]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
