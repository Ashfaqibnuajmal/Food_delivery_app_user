import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mera_app/core/theme/app_color.dart';
import 'package:mera_app/features/cart/bloc/cart_bloc.dart';
import 'package:mera_app/features/cart/bloc/cart_event.dart';

class CartServices {
  /// ✅ Add multiple items to cart
  static void addMultipleToCart(
      BuildContext context, List<Map<String, dynamic>> items) {
    if (items.isEmpty) return;

    final cartBloc = context.read<CartBloc>();

    for (var item in items) {
      cartBloc.add(AddToCart(item));
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Added to cart successfully",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryOrange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// ✅ Add single item to cart
  static void addSingleToCart(BuildContext context, Map<String, dynamic> item) {
    final cartBloc = context.read<CartBloc>();
    cartBloc.add(AddToCart(item));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Item added to cart",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryOrange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// ✅ Remove item from cart
  static void removeFromCart(BuildContext context, String id) {
    final cartBloc = context.read<CartBloc>();
    cartBloc.add(RemoveCartItems(id));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Item removed from cart",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// ✅ Clear all items from cart
  static void clearCart(BuildContext context) {
    final cartBloc = context.read<CartBloc>();
    cartBloc.add(ClearCart());

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Cart cleared",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
