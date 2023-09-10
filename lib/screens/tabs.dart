import 'package:dish_dash/screens/dishes.dart';
import 'package:dish_dash/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:dish_dash/screens/categories.dart';
import 'package:dish_dash/screens/filters.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dish_dash/providers/favorites_provider.dart';
import 'package:dish_dash/providers/filters_provider.dart';
import 'package:dish_dash/screens/search.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class Tabs extends ConsumerStatefulWidget {
  const Tabs({super.key});

  @override
  ConsumerState<Tabs> createState() => _TabsState();
}

class _TabsState extends ConsumerState<Tabs> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableDishes = ref.watch(filteredDishesProvider);

    Widget activePage = CategoriesScreen(
      availableDishes: availableDishes,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteDishes = ref.watch(favoriteDishProvider);
      activePage = DishesScreen(
        dishes: favoriteDishes,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const SearchScreen(),
                ),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
