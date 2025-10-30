import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mera_app/features/cart/model/order_model.dart';
import 'package:mera_app/features/cart/services/cart_services.dart';
import 'package:mera_app/features/cart/services/order_service.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  Future<void> placeOrder({
    required double subtotal,
    required double discount,
    required double total,
  }) async {
    emit(CheckoutLoading());
    try {
      final cartItems = await CartServices.getCartItems();
      final user = FirebaseAuth.instance.currentUser;

      final orderModel = OrderModel(
        orderId: FirebaseFirestore.instance.collection('Orders').doc().id,
        userId: user?.uid ?? "guest_123",
        userName: user?.displayName ?? user?.email ?? "Guest User",
        phoneNumber: user?.phoneNumber ?? "9876543210",
        foodItems: cartItems,
        subTotal: subtotal,
        discount: discount,
        totalAmount: total,
        orderStatus: 'Making',
        createdAt: DateTime.now(),
      );

      await OrderService().placeOrder(orderModel);
      await CartServices.clearFirestoreCart();
      emit(CheckoutSuccess());
    } catch (e) {
      emit(CheckoutFailure(e.toString()));
    }
  }
}
