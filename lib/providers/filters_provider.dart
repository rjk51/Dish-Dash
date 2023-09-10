import 'package:dish_dash/providers/dish_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier() : super({
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  });

  void setFilters(Map<Filter, bool> chosenfilters) {
    state = chosenfilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider = StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>((ref) {
  return FiltersNotifier();
});

final filteredDishesProvider = Provider((ref) {
  final dishes = ref.watch(dishProvider);
  final activeFilters = ref.watch(filtersProvider);

  return dishes.where((dish) {
      if (activeFilters[Filter.glutenFree]! && !dish.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !dish.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !dish.isVegetarian) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !dish.isVegan) {
        return false;
      }
      return true;
    }).toList();
});