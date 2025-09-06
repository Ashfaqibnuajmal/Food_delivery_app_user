import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mera_app/core/theme/app_color.dart';

class FoodDetails extends StatefulWidget {
  const FoodDetails({super.key});

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  bool isHalfSelected = false;
  bool isFullSelected = false;
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 400,
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
                    top: 30,
                    left: 15,
                    right: 16,
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
                          onPressed: () {
                            setState(() {
                              isFav = !isFav;
                            });
                          },
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -5,
                    left: 30,
                    right: 30,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      child: Image.asset(
                        "assets/intro_image1.jpeg",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(10),
              const Text(
                "Chicken Biriyani",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _infoItem(Icons.star, '4.5'),
                  _verticalDivier(),
                  _infoItem(Icons.timer_outlined, '8-10 min'),
                  _verticalDivier(),
                  _infoItem(Icons.local_fire_department, "124 Ka"),
                ],
              ),
              const SizedBox(height: 14),

              // ---------- Description ----------
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Rich in protein, carbohydrates, and healthy fats, this dish fuels both body and taste. "
                  "Prepared with fresh Malabar spices, tender chicken is slow-cooked and layered with aromatic short-grain rice. "
                  "Served with raita and salad, our Chicken Biriyani is a flavorful and satisfying hometown classic.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _portionButton("Half", "6-8 min", isHalfSelected, () {
                    setState(() {
                      isHalfSelected = !isHalfSelected;
                      if (isHalfSelected) isFullSelected = false;
                    });
                  }),
                  _portionButton("Full", "8-10 min", isFullSelected, () {
                    setState(() {
                      isFullSelected = !isFullSelected;
                      if (isFullSelected) isHalfSelected = false;
                    });
                  }),
                ],
              ),

              const SizedBox(height: 100), // instead of Spacer()
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {},
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

Widget _infoItem(IconData icon, String text) {
  return Row(
    children: [
      Icon(
        icon,
        size: 16,
        color: Colors.grey.shade700,
      ),
      const SizedBox(width: 8),
      Text(
        text,
        style: TextStyle(color: Colors.grey.shade700),
      ),
    ],
  );
}

Widget _verticalDivier() {
  return Container(
    width: 1,
    height: 15,
    color: Colors.black,
    margin: const EdgeInsets.symmetric(horizontal: 10),
  );
}

// Portion button widget
Widget _portionButton(
    String title, String time, bool isSelected, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 120,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange),
      ),
      child: Column(
        children: [
          Image.asset(
            "assets/intro_image1.jpeg",
            height: 50,
            width: 50,
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black54,
            ),
          ),
        ],
      ),
    ),
  );
}
