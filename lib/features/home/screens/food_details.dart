import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mera_app/core/blocs/favorite/favorite_bloc.dart';
import 'package:mera_app/core/blocs/favorite/favorite_event.dart';
import 'package:mera_app/core/theme/app_color.dart';
import 'package:mera_app/core/widgets/loading.dart';

class FoodDetails extends StatefulWidget {
  final String foodItemId;
  const FoodDetails({super.key, required this.foodItemId});

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  bool isHalfSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("FoodItems")
            .doc(widget.foodItemId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("❌ Food details not found"));
          }

          final food = snapshot.data!;
          // SAFE extraction with defaults
          final image =
              (food.data() as Map<String, dynamic>?)?['imageUrl'] ?? '';
          final name =
              (food.data() as Map<String, dynamic>?)?['name'] ?? 'Unknown';
          final prepTime =
              (food.data() as Map<String, dynamic>?)?['prepTimeMinutes'] ?? 0;
          final calories =
              (food.data() as Map<String, dynamic>?)?['calories'] ?? 0;
          final price = (food.data() as Map<String, dynamic>?)?['price'] ?? 0;
          final halfPrice =
              (food.data() as Map<String, dynamic>?)?['halfPrice'] ?? 0;
          final description =
              (food.data() as Map<String, dynamic>?)?['description'] ?? '';
          final isHalfAvailable =
              (food.data() as Map<String, dynamic>?)?['isHalfAvailable'] ??
                  false;

          // helper to build favorite map (keeps id as string)
          Map<String, dynamic> buildFavMap() {
            return {
              'id': widget.foodItemId.toString(),
              'name': name.toString(),
              'price': price,
              'halfPrice': halfPrice,
              'imageUrl': image.toString(),
              'prepTimeMinutes': prepTime,
              'isHalfAvailable': isHalfAvailable,
            };
          }

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

                            // FAVORITE BUTTON: uses FavoriteBloc
                            BlocBuilder<FavoriteBloc, dynamic>(
                              builder: (context, favState) {
                                // safe check: favState.favorites should be List<Map<String,dynamic>>
                                final favList =
                                    (favState is Map || favState == null)
                                        ? <Map<String, dynamic>>[]
                                        : (favState.favorites ??
                                            <Map<String, dynamic>>[]);

                                // fallback if bloc has different type (defensive)
                                List<Map<String, dynamic>> favorites =
                                    <Map<String, dynamic>>[];
                                try {
                                  favorites =
                                      List<Map<String, dynamic>>.from(favList);
                                } catch (_) {
                                  // ignore and use empty
                                }

                                final bool isFav = favorites.any((item) =>
                                    item['id']?.toString() ==
                                    widget.foodItemId.toString());

                                return IconButton(
                                  onPressed: () {
                                    final bloc = context.read<FavoriteBloc>();
                                    if (isFav) {
                                      bloc.add(RemoveFromFavorite(
                                          widget.foodItemId.toString()));
                                    } else {
                                      final favMap = buildFavMap();
                                      bloc.add(AddToFavorite(favMap));
                                    }
                                  },
                                  icon: Icon(
                                    isFav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                );
                              },
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
                          child: image.toString().isNotEmpty
                              ? Image.network(
                                  image,
                                  fit: BoxFit.fill,
                                  height: 300,
                                  width: double.infinity,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.image, size: 100),
                                )
                              : Container(
                                  height: 300,
                                  color: Colors.grey[200],
                                  child: const Center(
                                      child: Icon(Icons.fastfood, size: 100)),
                                ),
                        ),
                      ),
                    ],
                  ),

                  const Gap(30),
                  Text(
                    name.toString(),
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
                          margin: const EdgeInsets.symmetric(horizontal: 10)),
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
                          margin: const EdgeInsets.symmetric(horizontal: 10)),
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
                      description.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14, color: Colors.black87, height: 1.4),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 🍛 Half / Full Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (isHalfAvailable) // Only show if half portion exists
                        GestureDetector(
                          onTap: () => setState(() => isHalfSelected = true),
                          child: Container(
                            width: 140,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: isHalfSelected
                                  ? AppColors.primaryOrange.withOpacity(0.12)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: AppColors.primaryOrange),
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: image.toString().isNotEmpty
                                      ? Image.network(image,
                                          height: 70,
                                          width: 70,
                                          fit: BoxFit.cover)
                                      : Container(
                                          width: 70,
                                          height: 70,
                                          color: Colors.grey[200]),
                                ),
                                const SizedBox(height: 5),
                                const Text("Half",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 5),
                                Text("₹${halfPrice.toString()}.00",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ),

                      // Full portion (always visible)
                      GestureDetector(
                        onTap: () => setState(() => isHalfSelected = false),
                        child: Container(
                          width: 140,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: !isHalfSelected
                                ? AppColors.primaryOrange.withOpacity(0.12)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.primaryOrange),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: image.toString().isNotEmpty
                                    ? Image.network(
                                        image,
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error,
                                                stackTrace) =>
                                            const Icon(Icons.image, size: 100),
                                      )
                                    : Container(
                                        width: 70,
                                        height: 70,
                                        color: Colors.grey[200]),
                              ),
                              const SizedBox(height: 5),
                              const Text("Full",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              Text("₹${price.toString()}.00",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ],
                          ),
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
                  content: Text("✅ Added to cart successfully",
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: AppColors.primaryOrange,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryOrange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Add to cart",
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
