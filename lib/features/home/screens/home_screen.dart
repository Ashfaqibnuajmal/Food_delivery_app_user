import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mera_app/core/theme/app_color.dart';
import 'package:mera_app/core/widgets/loading.dart';
import 'package:mera_app/features/home/screens/ai_chat.dart';
import 'package:mera_app/features/home/screens/best_compo_screen.dart';
import 'package:mera_app/features/home/screens/food_details.dart';
import 'package:mera_app/features/home/screens/notification.dart';
import 'package:mera_app/features/home/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final foodNames = [
      "Chicken Biriyani",
      "Veg Pizza",
      "Cheese Burger",
      "Pasta Combo",
    ];

    final foodImages = [
      "assets/intro_image1.jpeg",
      "assets/intro_image1.jpeg",
      "assets/intro_image1.jpeg",
      "assets/intro_image1.jpeg",
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        // Left logo
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Image.asset(
            "assets/Logo.jpeg", // replace with your logo
            height: 50,
            width: 50,
          ),
        ),

        actions: [
          // AI button
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: Colors.orange[200],
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: const Offset(1, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.smart_toy_outlined, color: Colors.black),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AiChat()));
              },
            ),
          ),

          // Notification button with badge
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: Colors.orange[200],
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      spreadRadius: 2,
                      offset: const Offset(1, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon:
                      const Icon(Icons.notifications_none, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationPage()));
                  },
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryOrange,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchScreen()));
                  },
                  child: Container(
                    height: 50,
                    width: 340,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          spreadRadius: 1,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        const Icon(Icons.search, color: Colors.black54),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            "Search....",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                        ),
                        Container(
                          height: 36,
                          width: 36,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFE0B2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.mic,
                            color: Colors.deepOrange,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 1.5,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
                const Text(
                  "Today Offer",
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
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 1.5,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // 🔸 Carousel
            CarouselSlider.builder(
              itemCount: foodNames.length,
              itemBuilder: (context, index, realIdx) {
                return DiscountVoucherCard(
                  foodName: foodNames[index],
                  imagePath: foodImages[index],
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
                  // setState(() {
                  //   _currentIndex = index;
                  // });
                },
              ),
            ),

            const SizedBox(height: 12),

            // 🔸 Indicator Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: foodNames.asMap().entries.map((entry) {
                final isActive = _currentIndex == entry.key;
                return Container(
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
              }).toList(),
            ),

            const SizedBox(height: 30),

            const SizedBox(height: 10),
            Row(
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
                            builder: (context) => const BestCompoScreen()));
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
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio:
                      0.74, // ✅ tuned aspect ratio for no overflow
                ),
                itemBuilder: (context, index) {
                  return AspectRatio(
                    aspectRatio:
                        0.8, // ensures each card sizes correctly inside grid cell
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FoodDetails()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // ⭐ Rating + Favorite
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: AppColors.primaryOrange,
                                        size: 16),
                                    SizedBox(width: 3),
                                    Text(
                                      "4.5",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () {},
                                  icon: const Icon(Icons.favorite,
                                      color: AppColors.primaryOrange, size: 30),
                                ),
                              ],
                            ),

                            // 🖼️ Image
                            Center(
                              child: Image.asset(
                                "assets/intro_image1.jpeg",
                                height: 65,
                                width: 65,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 6),

                            // 🍗 Title
                            const Text(
                              "Chicken Biriyani",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 3),

                            // ⏰ Time + Calories
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.timer,
                                    color: Colors.grey, size: 13),
                                const SizedBox(width: 3),
                                const Text("15 min",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 11)),
                                Container(
                                  height: 11,
                                  width: 1,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  color: Colors.grey.withOpacity(0.4),
                                ),
                                const Text("500 Kal",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 11)),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // 💰 Price + Add Button
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "₹ 120.00",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
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
                                                          FontWeight.bold),
                                                ),
                                                Icon(Icons.check_circle_outline,
                                                    color: AppColors
                                                        .primaryOrange),
                                              ],
                                            ),
                                            backgroundColor: Colors.white,
                                            behavior: SnackBarBehavior.floating,
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
                                        child: const Icon(Icons.add,
                                            color: Colors.white, size: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 1.5,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
                const Text(
                  "Recommended",
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
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 1.5,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 95,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Category")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: LoadingIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text("No categories found"),
                      );
                    }
                    final categories = snapshot.data!.docs;
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final data =
                              categories[index].data() as Map<String, dynamic>;
                          final name = data['name'] ?? 'No Name';
                          final imageUrl = data['imageUrl'] ?? "";
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColors.primaryOrange
                                          .withOpacity(0.2),
                                      width: 2),
                                ),
                                child: ClipOval(
                                  child: imageUrl.isNotEmpty
                                      ? Image.network(
                                          imageUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder: (ctx, error, stack) =>
                                              const Icon(
                                            Icons.broken_image,
                                            size: 40,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.image,
                                          size: 40,
                                        ),
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                name,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              )
                            ]),
                          );
                        });
                  }),
            ),
            const SizedBox(height: 20),

            Column(
              children: List.generate(3, (index) {
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Stack(
                      children: [
                        // 🟢 Your existing container
                        Container(
                          height: 120,
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color:
                                    AppColors.primaryOrange.withOpacity(0.3)),
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
                              // 🟠 Left Section – Tag + Image
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                      height: 26), // space for top image
                                  Image.asset(
                                    "assets/intro_image1.jpeg",
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 12),

                              // 🟠 Right Section – Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Chicken Biriyani",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Icon(
                                          Icons.favorite,
                                          color: AppColors.primaryOrange,
                                          size: 25,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    const Row(
                                      children: [
                                        Icon(Icons.timer_outlined,
                                            size: 15, color: Colors.grey),
                                        SizedBox(width: 4),
                                        Text(
                                          "15 min",
                                          style: TextStyle(
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
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "₹ 120.00",
                                          style: TextStyle(
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

                        // 🟣 Top-left “Best Seller” badge
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
                    ));
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class DiscountVoucherCard extends StatelessWidget {
  final String imagePath;
  final String foodName;

  const DiscountVoucherCard({
    super.key,
    required this.imagePath,
    required this.foodName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 460, // ⬅️ increased width
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
            // 🟧 Left section – Image + Name
            Stack(
              clipBehavior: Clip.none,
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
                          Image.asset(
                            imagePath,
                            height: 65,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            foodName,
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

                    // 🟡 Offer badge image (top-right)
                    Positioned(
                      top: -10,
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

                // 🟡 Offer badge image (top-right)
                Positioned(
                  top: -10,
                  left: -10,
                  child: Image.asset(
                    'assets/offer.png',
                    height: 80,
                    width: 8,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            // 🟧 Right section – Offer text on top, button below
            Expanded(
              child: Container(
                color: AppColors.primaryOrange,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                        elevation: 3, // soft shadow under button
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25),
                          splashColor: AppColors.primaryOrange.withOpacity(0.2),
                          highlightColor: Colors.transparent,
                          onTap: () {
                            // handle press
                          },
                          child: const Center(
                            child: Text(
                              "Order Now",
                              style: TextStyle(
                                color: AppColors.primaryOrange,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                // letterSpacing: 0.5
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
  }
}
