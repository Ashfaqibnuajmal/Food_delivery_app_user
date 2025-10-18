import 'package:flutter/material.dart';
import 'package:mera_app/features/home/widgets/best_compo_grid.dart';
import 'package:mera_app/features/home/widgets/best_compo_title.dart';
import 'package:mera_app/features/home/widgets/category_list.dart';
import 'package:mera_app/features/home/widgets/food_item_list.dart';
import 'package:mera_app/features/home/widgets/home_appbar.dart';
import 'package:mera_app/features/home/widgets/recommended_title.dart';
import 'package:mera_app/features/home/widgets/search_bar_widget.dart';
import 'package:mera_app/features/home/widgets/today_offer_card.dart';
import 'package:mera_app/features/home/widgets/today_offer_footer.dart';
import 'package:mera_app/features/home/widgets/today_offer_title.dart';

// ──────────────────────────────────────────────
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchBarWidget(),
            const SizedBox(height: 30),
            const TodayOfferTitle(),
            const SizedBox(height: 25),
            const TodayOfferCard(),
            const SizedBox(height: 12),
            TodayOfferFooter(currentIndex: _currentIndex),
            const SizedBox(height: 40),
            const BestCompoHeading(),
            const SizedBox(height: 10),
            const BestCompoCardGrid(),
            const SizedBox(height: 30),
            const RecommendedTitle(),
            const SizedBox(height: 20),
            const SizedBox(
              height: 95,
              child: CategoryList(),
            ),
            const SizedBox(height: 20),
            const FoodItemsList(),
          ],
        ),
      ),
    );
  }
}
