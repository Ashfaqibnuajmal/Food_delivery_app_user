import 'package:flutter_bloc/flutter_bloc.dart';

class FoodPortionCubit extends Cubit<bool> {
  FoodPortionCubit({bool intialIsHalf = false}) : super(intialIsHalf);
  void selectHalf() => emit(false);
  void selectFull() => emit(true);
  void toggle() => emit(!state);
}
