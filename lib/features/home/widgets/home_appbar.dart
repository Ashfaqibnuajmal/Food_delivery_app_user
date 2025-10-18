import 'package:flutter/material.dart';
import 'package:mera_app/core/theme/app_color.dart';
import 'package:mera_app/features/home/screens/ai_chat.dart';
import 'package:mera_app/features/home/screens/notification.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AiChat()),
              );
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
                icon: const Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationPage()),
                  );
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
