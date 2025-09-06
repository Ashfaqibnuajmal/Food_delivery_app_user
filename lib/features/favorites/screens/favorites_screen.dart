import 'package:flutter/material.dart';
import 'package:mera_app/core/theme/app_color.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> foodItems = [
      {
        'image': 'assets/intro_image1.jpeg',
        'name': "Chicken Biriyani",
        'portion': "(half)",
        "price": "120",
        "rating": 5.0
      },
      {
        'image': 'assets/intro_image1.jpeg',
        'name': "Chicken Biriyani",
        'portion': "(half)",
        "price": "120",
        "rating": 5.0
      },
      {
        'image': 'assets/intro_image1.jpeg',
        'name': "Chicken Biriyani",
        'portion': "(half)",
        "price": "120",
        "rating": 5.0
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       const Icon(
      //         Icons.favorite_border_rounded,
      //         size: 40,
      //         color: AppColors.primaryOrange,
      //       ),
      //       const SizedBox(height: 10),
      //       const Text(
      //         "No Favorites Items!",
      //         style: TextStyle(
      //             color: Colors.black,
      //             fontWeight: FontWeight.bold,
      //             fontSize: 16),
      //       ),
      //       const Text(
      //         '''You don't have any favorites items.
      // Go to home and add store''',
      //         style: TextStyle(color: Colors.black45, fontSize: 12),
      //         textAlign: TextAlign.center,
      //       ),
      //       const SizedBox(height: 10),
      //       ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //               foregroundColor: Colors.black,
      //               backgroundColor: AppColors.primaryOrange,
      //               padding: const EdgeInsets.symmetric(
      //                   horizontal: 20, vertical: 10),
      //               shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(12))),
      //           onPressed: () {},
      //           child: const Text(
      //             "Add Now",
      //             style: TextStyle(fontWeight: FontWeight.bold),
      //           )),
      //     ],
      //   ),
      // ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          final item = foodItems[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Card(
              elevation: 4,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  color: AppColors.primaryOrange,
                  width: 0.5,
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          item['image'],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(item['portion']),
                              Text(
                                item["price"],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: AppColors.primaryOrange,
                                    size: 16,
                                  ),
                                  Text(
                                    "${item['rating']}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite,
                        size: 25,
                        color: AppColors.primaryOrange,
                      ),
                    ),
                  ),
                  // Add button - bottom right
                  Positioned(
                      bottom: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Food item successfully added',
                                    style: TextStyle(
                                        color: AppColors.primaryOrange,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(Icons.check_circle_outline,
                                      color: AppColors.primaryOrange),
                                ],
                              ),
                              backgroundColor: Colors.white,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryOrange,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add,
                              color: Colors.white, size: 20),
                        ),
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
