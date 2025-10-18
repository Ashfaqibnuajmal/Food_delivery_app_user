import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mera_app/core/theme/app_color.dart';
import 'package:mera_app/core/widgets/loading.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Category").snapshots(),
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
              final data = categories[index].data() as Map<String, dynamic>;
              final name = data['name'] ?? 'No Name';
              final imageUrl = data['imageUrl'] ?? "";

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primaryOrange.withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: imageUrl.isNotEmpty
                            ? Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, error, stack) => const Icon(
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
                    const SizedBox(height: 3),
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
