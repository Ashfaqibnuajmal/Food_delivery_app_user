import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mera_app/core/theme/app_color.dart';
import 'package:mera_app/features/cart/bloc/cart_bloc.dart';
import 'package:mera_app/features/cart/bloc/cart_event.dart';
import 'package:mera_app/features/cart/bloc/cart_state.dart';
import 'package:mera_app/features/cart/cubit/cart_quantity_cubit.dart';
import 'package:mera_app/features/cart/screens/checkout_screen.dart';
import 'package:mera_app/features/cart/screens/drinks_bottom_sheet.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Map<String, int> quantities = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Order History',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 🛒 CART LIST
          Expanded(
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                final cartItems = state.cartItems;

                if (cartItems.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.shopping_cart_rounded,
                          size: 70,
                          color: AppColors.primaryOrange,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "No Order Yet!",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const Text(
                          "When you add foods, they’ll\n appear here.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: AppColors.primaryOrange,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Order Now",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cart = cartItems[index];
                    final id = cart['id']?.toString() ?? '';
                    final name = (cart['name'] ?? '') as String;
                    final imageUrl =
                        (cart['imageUrl'] ?? cart['image'] ?? '') as String;
                    final price =
                        double.tryParse(cart['price']?.toString() ?? '0') ?? 0;
                    final halfPrice =
                        double.tryParse(cart['halfPrice']?.toString() ?? '0') ??
                            0;
                    final isHalfAvailable = cart['isHalfAvailable'] == true;
                    final double actualPrice =
                        isHalfAvailable ? halfPrice : price;
                    final bool isTodayOffer = cart['isTodayOffer'] == true;

// Apply 50% off if today offer
                    final double finalPrice =
                        isTodayOffer ? (actualPrice * 0.5) : actualPrice;

                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: imageUrl.isNotEmpty
                                  ? Image.network(
                                      imageUrl,
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                        width: 60,
                                        height: 60,
                                        color: Colors.grey[200],
                                        child: const Icon(
                                          Icons.image_not_supported,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.grey[200],
                                      child: const Icon(
                                        Icons.fastfood,
                                        color: Colors.grey,
                                      ),
                                    ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    isHalfAvailable ? "(Half)" : "(Full)",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(height: 5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "₹ ${finalPrice.toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: isTodayOffer
                                              ? Colors.redAccent
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color: AppColors.primaryOrange,
                                      ),
                                      SizedBox(width: 3),
                                      Text("5.0"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // 🗑 DELETE BUTTON
                                IconButton(
                                  onPressed: () {
                                    _showDeleteDialog(context, id);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                  ),
                                ),

                                // 🔢 QUANTITY CONTROLS
                                BlocBuilder<CartQuantityCubit,
                                    Map<String, int>>(
                                  builder: (context, quantityState) {
                                    final quantity = quantityState[id] ?? 1;
                                    return Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            context
                                                .read<CartQuantityCubit>()
                                                .decrease(id, context);
                                          },
                                          icon: const Icon(
                                              Icons.remove_circle_outline),
                                        ),
                                        Text(
                                          "$quantity",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            context
                                                .read<CartQuantityCubit>()
                                                .increase(id, context);
                                          },
                                          icon: const Icon(Icons
                                              .add_circle_outline_outlined),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              final cartItems = state.cartItems;

              double subtotal = 0.0;
              double discountTotal = 0.0;
              for (var item in cartItems) {
                final id = item['id']?.toString() ?? '';
                final isHalf = item['isHalf'] == true;
                final double price = double.tryParse(
                      isHalf
                          ? (item['halfPrice'] ?? '0').toString()
                          : (item['price'] ?? '0').toString(),
                    ) ??
                    0.0;
                final isTodayOffer = item['isTodayOffer'] == true;
                final quantity =
                    context.read<CartQuantityCubit>().state[id] ?? 1;

                double finalPrice = price;
                double itemDiscount = 0.0;

                if (isTodayOffer) {
                  itemDiscount = price * 0.5; // 50% off per item
                  finalPrice = price - itemDiscount;
                }

// add to totals
                subtotal += finalPrice * quantity;
                discountTotal +=
                    itemDiscount * quantity; // 🆕 add total discount
              }

              const deliveryFee = 30.0;
              const discount = 0.0;
              final total =
                  subtotal + deliveryFee; // subtotal already excludes discount

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _priceRow("Subtotal", "₹${subtotal.toStringAsFixed(2)}"),
                    _priceRow(
                        "Discount", "₹${discountTotal.toStringAsFixed(2)}"),
                    _priceRow(
                        "Delivery fee", "₹${deliveryFee.toStringAsFixed(2)}"),
                    const Divider(thickness: 1),
                    _priceRow("Total", "₹${total.toStringAsFixed(2)}",
                        isBold: true, fontSize: 20),
                    const Divider(thickness: 1),
                    const SizedBox(height: 15),
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: 50,
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(25),
                    //       ),
                    //       backgroundColor: AppColors.primaryOrange,
                    //     ),
                    //     onPressed: () async {
                    //       // ✅ Access cart items from Bloc
                    //       final cartItems =
                    //           context.read<CartBloc>().state.cartItems;

                    //       // ✅ Check if there’s any Cool Drink
                    //       final hasCoolDrink = cartItems.any(
                    //         (item) =>
                    //             (item['category']?.toString().toLowerCase() ??
                    //                 '') ==
                    //             'cool drinks',
                    //       );
                    //       final prefs = await SharedPreferences.getInstance();
                    //       final bottomSheetShown =
                    //           prefs.getBool('coolDrinkBottomSheetShown') ??
                    //               false;

                    //       if (hasCoolDrink || bottomSheetShown) {
                    //         // ✅ If cool drink exists, go to checkout page
                    //         Navigator.push(
                    //           // ignore: use_build_context_synchronously
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => CheckoutScreen(
                    //               subtotal: subtotal,
                    //               discount: discount,
                    //               deliveryFee: deliveryFee,
                    //               total: total,
                    //             ),
                    //           ),
                    //         );
                    //       } else {
                    //         await prefs.setBool(
                    //             'coolDrinkBottomSheetShown', true);
                    //         showModalBottomSheet(
                    //           // ignore: use_build_context_synchronously
                    //           context: context,
                    //           isScrollControlled: true,
                    //           backgroundColor: Colors.transparent,
                    //           builder: (context) =>
                    //               const CoolDrinksBottomSheet(),
                    //         ).then((_) {
                    //           Navigator.push(
                    //               // ignore: use_build_context_synchronously
                    //               context,
                    //               MaterialPageRoute(
                    //                   builder: (context) => CheckoutScreen(
                    //                       subtotal: subtotal,
                    //                       discount: discount,
                    //                       deliveryFee: deliveryFee,
                    //                       total: total)));
                    //         });
                    //       }
                    //     },
                    //     child: const Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           "Go to Checkout",
                    //           style: TextStyle(
                    //             fontSize: 16,
                    //             color: Colors.black,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //         SizedBox(width: 5),
                    //         Icon(
                    //           Icons.arrow_forward_rounded,
                    //           color: Colors.black,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          backgroundColor: AppColors.primaryOrange,
                        ),
                        onPressed: () {
                          // ✅ Access cart items from Bloc
                          final cartItems =
                              context.read<CartBloc>().state.cartItems;

                          // ✅ Check if there’s any Cool Drink
                          final hasCoolDrink = cartItems.any(
                            (item) =>
                                (item['category']?.toString().toLowerCase() ??
                                    '') ==
                                'cool drinks',
                          );

                          if (hasCoolDrink) {
                            // ✅ If cool drink exists, go to checkout page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckoutScreen(
                                  subtotal: subtotal,
                                  discount: discount,
                                  deliveryFee: deliveryFee,
                                  total: total,
                                ),
                              ),
                            );
                          } else {
                            // 🚫 Otherwise, show the CoolDrinks bottom sheet
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) =>
                                  const CoolDrinksBottomSheet(),
                            );
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Go to Checkout",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE53E3E),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.question_mark,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Remove food?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Are you sure you want to remove \nthis food?',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFE5E5E5),
                          foregroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'NO',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<CartBloc>().add(RemoveCartItems(id));
                          context.read<CartBloc>().add(RemoveCartItems(id));

                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Removed from Cart!',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.white,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE53E3E),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'YES',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _priceRow(String title, String value,
    {bool isBold = false, double fontSize = 15}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}
