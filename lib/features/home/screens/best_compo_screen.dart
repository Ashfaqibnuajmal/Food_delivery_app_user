import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mera_app/core/theme/app_color.dart';
import 'package:mera_app/core/widgets/loading.dart';

class BestCompoScreen extends StatelessWidget {
  const BestCompoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Best Compo',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.black.withOpacity(0.1),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 🔍 Search Bar
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.black.withOpacity(0.2)),
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
                      style: TextStyle(color: Colors.black54, fontSize: 16),
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

            const SizedBox(height: 30),

            // 🍴 Grid Section
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("FoodItems")
                    .where("isCompo", isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: LoadingIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        "Something went wrong!",
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Compo Items Found",
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }

                  final foodItems = snapshot.data!.docs;

                  return GridView.builder(
                    itemCount: foodItems.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final food =
                          foodItems[index].data() as Map<String, dynamic>;

                      return Container(
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
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 15),
                                  Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        food["imageUrl"] ?? "",
                                        height: 90,
                                        width: 90,
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
                                  const SizedBox(height: 8),
                                  Text(
                                    food["name"] ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.timer,
                                          color: Colors.grey, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        "${food["prepTimeMinutes"] ?? 0} min",
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                      Container(
                                        height: 12,
                                        width: 1,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        color: Colors.grey.withOpacity(0.4),
                                      ),
                                      Text(
                                        "${food["calories"] ?? 0} kcal",
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "₹${food["price"] ?? 0}.00",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
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
                                                  )
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
                                          height: 35,
                                          width: 35,
                                          decoration: const BoxDecoration(
                                            color: AppColors.primaryOrange,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Positioned(
                                top: -3,
                                left: -8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 3),
                                  color: Colors.transparent,
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: AppColors.primaryOrange,
                                        size: 14,
                                      ),
                                      SizedBox(width: 3),
                                      Text(
                                        "4.5",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -12,
                                right: -10,
                                child: IconButton(
                                  onPressed: () {},
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: AppColors.primaryOrange,
                                    size: 30,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
