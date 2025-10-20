import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mera_app/core/blocs/search_event.dart';
import 'package:mera_app/core/blocs/search_state.dart';

class FoodSearchBloc extends Bloc<FoodSearchEvent, FoodSearchState> {
  FoodSearchBloc() : super(const FoodSearchState()) {
    on<SetFoodItems>((event, emit) {
      emit(state.copyWith(allItems: event.items));
    });

    on<UpdateQuery>((event, emit) {
      emit(state.copyWith(query: event.query));
    });
  }
}
