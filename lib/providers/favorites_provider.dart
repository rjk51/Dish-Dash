import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dish_dash/models/dish.dart';

class FavoriteDishNotifier extends StateNotifier<List<Dish>> {
  FavoriteDishNotifier() : super([]);

  bool toggleDishFavoriteStatus(Dish dish) {
    final dishIsFavorite = state.contains(dish);

    if (dishIsFavorite) {
      state = state.where((m) => m.id != dish.id).toList();
      return false;
    } else {
      state = [...state, dish];
      return true;
    }
  }
}

final favoriteDishProvider =
    StateNotifierProvider<FavoriteDishNotifier, List<Dish>>((ref) {
  return FavoriteDishNotifier();
});