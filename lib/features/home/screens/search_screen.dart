import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mera_app/core/blocs/favorite/favorite_bloc.dart';
import 'package:mera_app/core/blocs/favorite/favorite_event.dart';
import 'package:mera_app/core/blocs/favorite/favorite_state.dart';
import 'package:mera_app/core/blocs/search/search_bloc.dart';
import 'package:mera_app/core/blocs/search/search_event.dart';
import 'package:mera_app/core/blocs/search/search_state.dart';
import 'package:mera_app/core/theme/app_color.dart';
import 'package:mera_app/core/widgets/loading.dart';
import 'package:mera_app/features/home/screens/food_details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    // Listen to bloc state changes
    context.read<FoodSearchBloc>().stream.listen((state) {
      if (_controller.text != state.query) {
        _controller.text = state.query;
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            'Search Item',
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 20),

              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: AppColors.primaryOrange.withOpacity(0.2),
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
                    Expanded(
                      child: TextFormField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: "Search...",
                          hintStyle:
                              TextStyle(color: Colors.black54, fontSize: 16),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          context
                              .read<FoodSearchBloc>()
                              .add(UpdateQuery(value));
                        },
                      ),
                    ),
                    BlocBuilder<FoodSearchBloc, FoodSearchState>(
                      builder: (context, state) {
                        if (state.query.isEmpty) {
                          return const SizedBox(width: 0);
                        }
                        return Container(
                          height: 30,
                          width: 30,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFE0B2),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              context
                                  .read<FoodSearchBloc>()
                                  .add(const UpdateQuery('')); // reset search
                            },
                            icon: const Icon(
                              Icons.close,
                              color: AppColors.primaryOrange,
                              size: 20,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 🔸 Category list
              SizedBox(
                height: 110,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Category')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("No categories found"));
                    }

                    final categories = snapshot.data!.docs;

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final data =
                            categories[index].data() as Map<String, dynamic>;
                        final name = data['name'] ?? 'No Name';
                        final imageUrl = data['imageUrl'] ?? '';

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
                                              const Icon(Icons.broken_image,
                                                  size: 40),
                                        )
                                      : const Icon(Icons.image, size: 40),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              // 🔸 Grid of food items
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("FoodItems")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: LoadingIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("No Food Items Found"));
                    }

                    final items = snapshot.data!.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      data['id'] = doc.id;
                      return data;
                    }).toList();

                    // Send items to Bloc (once)
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.read<FoodSearchBloc>().add(SetFoodItems(items));
                    });

                    return BlocBuilder<FoodSearchBloc, FoodSearchState>(
                      builder: (context, state) {
                        final filteredItems = state.filteredItems;

                        if (filteredItems.isEmpty) {
                          return const Center(
                            child: Column(
                              children: [
                                SizedBox(height: 100),
                                Icon(
                                  Icons.search_off_rounded,
                                  size: 50,
                                  color: AppColors.primaryOrange,
                                ),
                                Text(
                                  "No Food Items Found!",
                                  style: TextStyle(
                                      fontSize: 16,
                                      letterSpacing: -1,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        }

                        return GridView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: filteredItems.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.72,
                          ),
                          itemBuilder: (context, index) {
                            final food = filteredItems[index];
                            final id = food['id'];

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FoodDetails(foodItemId: id),
                                  ),
                                );
                              },
                              child: Stack(children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.2)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 3,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.star,
                                                    color:
                                                        AppColors.primaryOrange,
                                                    size: 18),
                                                SizedBox(width: 4),
                                                Text("4.5",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Center(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.network(
                                              food["imageUrl"] ?? "",
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  const Icon(Icons
                                                      .image_not_supported),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          food["name"] ?? "",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "₹${food["price"]}.00",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
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
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .check_circle_outline,
                                                          color: AppColors
                                                              .primaryOrange,
                                                        )
                                                      ],
                                                    ),
                                                    backgroundColor:
                                                        Colors.white,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    duration: const Duration(
                                                        seconds: 2),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: 35,
                                                width: 35,
                                                decoration: const BoxDecoration(
                                                  color:
                                                      AppColors.primaryOrange,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(Icons.add,
                                                    color: Colors.white,
                                                    size: 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                BlocBuilder<FavoriteBloc, FavoriteState>(
                                  builder: (context, favState) {
                                    final isFav = favState.favorites
                                        .any((item) => item['id'] == id);
                                    return Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: const BoxDecoration(
                                          color: AppColors.primaryOrange,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            if (isFav) {
                                              context
                                                  .read<FavoriteBloc>()
                                                  .add(RemoveFromFavorite(id));
                                            } else {
                                              final favItems = {
                                                'id': id,
                                                'name': food['name'],
                                                'price': food['price'],
                                                'prepTimeMinutes':
                                                    food['prepTimeMinutes'],
                                                "imageUrl": food['imageUrl']
                                              };
                                              context
                                                  .read<FavoriteBloc>()
                                                  .add(AddToFavorite(favItems));
                                            }
                                          },
                                          icon: Icon(
                                            isFav
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: Colors.white,
                                          ),
                                          padding: EdgeInsets
                                              .zero, // centers the icon properly
                                          constraints:
                                              const BoxConstraints(), // removes default extra padding
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ]),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
