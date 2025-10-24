import 'package:flutter_bloc/flutter_bloc.dart';

/// true  -> half selected
/// false -> full selected
class FoodPortionCubit extends Cubit<bool> {
  FoodPortionCubit({bool initialIsHalf = false}) : super(initialIsHalf);

  void selectHalf() => emit(true);
  void selectFull() => emit(false);
  void toggle() => emit(!state);
}
