import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mera_app/features/cart/bloc/cart_bloc.dart';
import 'package:mera_app/features/cart/bloc/cart_event.dart';
import 'package:mera_app/features/cart/bloc/cart_state.dart';
import 'package:mera_app/features/favorites/bloc/favorite_bloc.dart';
import 'package:mera_app/features/favorites/bloc/favorite_event.dart';
import 'package:mera_app/core/theme/app_color.dart';
import 'package:mera_app/core/widgets/loading.dart';
import 'package:mera_app/text.dart';

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
          final data = food.data() as Map<String, dynamic>;

          final image = data['imageUrl'] ?? '';
          final name = data['name'] ?? 'Unknown';
          final prepTime = data['prepTimeMinutes'] ?? 0;
          final calories = data['calories'] ?? 0;
          final price = data['price'] ?? 0;
          final halfPrice = data['halfPrice'] ?? 0;
          final description = data['description'] ?? '';
          final isHalfAvailable = data['isHalfAvailable'] ?? false;

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

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
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
                              BlocBuilder<FavoriteBloc, dynamic>(
                                builder: (context, favState) {
                                  final favList =
                                      (favState is Map || favState == null)
                                          ? <Map<String, dynamic>>[]
                                          : (favState.favorites ??
                                              <Map<String, dynamic>>[]);

                                  List<Map<String, dynamic>> favorites =
                                      <Map<String, dynamic>>[];
                                  try {
                                    favorites = List<Map<String, dynamic>>.from(
                                        favList);
                                  } catch (_) {}

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
                                    errorBuilder:
                                        (context, error, stackTrace) =>
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
                    BlocBuilder<FoodPortionCubit, bool>(
                      builder: (context, isHalfSelected) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (isHalfAvailable)
                              GestureDetector(
                                onTap: () => context
                                    .read<FoodPortionCubit>()
                                    .selectHalf(),
                                child: Container(
                                  width: 140,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: isHalfSelected
                                        ? AppColors.primaryOrange
                                            .withOpacity(0.12)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: isHalfSelected
                                            ? AppColors.primaryOrange
                                            : Colors.grey.shade300,
                                        width: isHalfSelected ? 2 : 1),
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

                            // Full Portion
                            GestureDetector(
                              onTap: () =>
                                  context.read<FoodPortionCubit>().selectFull(),
                              child: Container(
                                width: 140,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: !isHalfSelected
                                      ? AppColors.primaryOrange
                                          .withOpacity(0.12)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: !isHalfSelected
                                        ? AppColors.primaryOrange
                                        : Colors.grey.shade300,
                                    width: !isHalfSelected ? 2 : 1,
                                  ),
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
                                                  const Icon(Icons.image,
                                                      size: 100),
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
                        );
                      },
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),

            // ✅ Add to Cart Button (Now inside StreamBuilder)
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, cartState) {
                    final bool inCart = cartState.cartItems.any(
                      (it) =>
                          it['id']?.toString() == widget.foodItemId.toString(),
                    );

                    return ElevatedButton(
                      onPressed: inCart
                          ? null
                          : () {
                              final cartItem = {
                                'id': widget.foodItemId.toString(),
                                'name': name.toString(),
                                'price': isHalfSelected ? halfPrice : price,
                                'prepTimeMinutes': prepTime,
                                'imageUrl': image.toString(),
                                'isHalf':
                                    isHalfSelected, // important flags/metadata
                                'halfPrice': halfPrice,
                                'isHalfAvailable': isHalfAvailable,
                                'isTodayOffer': data['isTodayOffer'] ?? false,
                                'quantity': 1,
                              };

                              context.read<CartBloc>().add(AddToCart(cartItem));

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    " Added to cart successfully",
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
                        disabledBackgroundColor: Colors.grey.shade300,
                        disabledForegroundColor: Colors.white,
                      ),
                      child: Text(
                        inCart ? "Added" : "Add to cart",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
