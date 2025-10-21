import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mera_app/core/theme/app_color.dart';
import 'package:mera_app/core/widgets/loading.dart';
import 'package:mera_app/features/home/cubit/today_offer_cubit.dart';

class TodayOfferCard extends StatelessWidget {
  const TodayOfferCard({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("FoodItems")
          .where("isTodayOffer", isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoadingIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("Today no offer available!"),
          );
        }

        final foodItems = snapshot.data!.docs;

        return CarouselSlider.builder(
          itemCount: foodItems.length,
          itemBuilder: (context, index, realIdx) {
            final food = foodItems[index].data()! as Map<String, dynamic>;

            return Container(
              width: 460,
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.primaryOrange,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 130,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  food['imageUrl'] ?? "",
                                  height: 90,
                                  width: 90,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                    Icons.image_not_supported,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                food["name"] ?? "",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -15,
                          left: -10,
                          child: Image.asset(
                            'assets/offer.png',
                            height: 80,
                            width: 80,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        color: AppColors.primaryOrange,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "GET 50% OFFER TODAY!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 30,
                              width: 90,
                              child: Material(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(25),
                                elevation: 3,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(25),
                                  splashColor:
                                      AppColors.primaryOrange.withOpacity(0.2),
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    // You can add navigation or order logic here
                                  },
                                  child: const Center(
                                    child: Text(
                                      "Order Now",
                                      style: TextStyle(
                                        color: AppColors.primaryOrange,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          options: CarouselOptions(
              height: 190,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              enlargeCenterPage: true,
              enlargeFactor: 0.18,
              viewportFraction: 0.8,
              onPageChanged: (index, reason) {
                context.read<TodayOfferCubit>().changeIndex(index);
              }),
        );
      },
    );
  }
}
