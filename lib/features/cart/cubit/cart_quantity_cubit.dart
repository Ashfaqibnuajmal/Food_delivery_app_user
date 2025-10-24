import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mera_app/features/cart/bloc/cart_bloc.dart';
import 'package:mera_app/features/cart/bloc/cart_event.dart';
import 'package:flutter/material.dart';

class CartQuantityCubit extends Cubit<Map<String, int>> {
  CartQuantityCubit() : super({});

  void increase(String id, BuildContext context) {
    final current = state[id] ?? 1;
    final newQty = current + 1;
    emit({...state, id: newQty});

    context
        .read<CartBloc>()
        .add(UpdateCartItemQuantity(id: id, quantity: newQty));
  }

  void decrease(String id, BuildContext context) {
    final current = state[id] ?? 1;
    if (current > 1) {
      final newQty = current - 1;
      emit({...state, id: newQty});

      // ✅ Update CartBloc
      context
          .read<CartBloc>()
          .add(UpdateCartItemQuantity(id: id, quantity: newQty));
    }
  }
}
