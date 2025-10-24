import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mera_app/core/theme/app_color.dart';
import 'package:mera_app/features/bottom_nav/cubit/main_navigation_bar_cubit.dart';
import 'package:mera_app/features/cart/screens/cart_screen.dart';
import 'package:mera_app/features/favorites/screens/favorites_screen.dart';
import 'package:mera_app/features/home/screens/home_screen.dart';
import 'package:mera_app/features/profile/screens/profile_screens.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  final List<Widget> _pages = const [
    HomeScreen(),
    FavoritesScreen(),
    CartScreen(),
    ProfileScreens(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavCubit(),
      child: BlocBuilder<BottomNavCubit, int>(
        builder: (context, selectedIndex) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: _pages[selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favorites'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), label: 'Cart'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ],
              currentIndex: selectedIndex,
              selectedItemColor: AppColors.primaryOrange,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                context.read<BottomNavCubit>().updateIndex(index);
              },
              type: BottomNavigationBarType.fixed,
            ),
          );
        },
      ),
    );
  }
}
