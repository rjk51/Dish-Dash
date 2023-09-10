import 'package:flutter/material.dart';
import 'package:dish_dash/models/dish.dart';
import 'package:dish_dash/data/dummy_data.dart';
import 'package:dish_dash/widgets/dish_item.dart';
import 'package:dish_dash/screens/dish_details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _ingredientController = TextEditingController();
  String _selectedSortingOption = 'Relevancy';
  List<Dish> searchResults = [];

  void _performIngredientSearch() {
    String ingredient = _ingredientController.text.trim().toLowerCase();
    List<String> ingredients = ingredient.split(', ');

    List<Dish> results = [];

    if (ingredients.isNotEmpty && !RegExp(r'^[0-9]+$').hasMatch(ingredient)) {
      for (var dish in dummyDishes) {
        bool matchesAllIngredients = true;
        for (var ingredient in ingredients) {
          bool containsIngredient = false;
          for (var dishIngredient in dish.ingredients) {
            if (dishIngredient.toLowerCase().contains(ingredient.toLowerCase())) {
              containsIngredient = true;
              break;
            }
          }
          if (!containsIngredient) {
            matchesAllIngredients = false;
            break;
          }
        }
        if (matchesAllIngredients) {
          results.add(dish);
        }
      }
    }
    if (_selectedSortingOption == 'User Rating') {
    results.sort((a, b) => b.rating.compareTo(a.rating));
    }
    setState(() {
      searchResults = results;
    });
  }

  void selectDish(BuildContext context, Dish dish) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => DishDetailsScreen(
              dish: dish,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search by Ingredient'),
      ),
      body: Column(children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                alignment: Alignment.center,
                child: TextField(
                  controller: _ingredientController,
                  onSubmitted: (_) {
                    _performIngredientSearch();
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Ingredients (, separated)',
                    contentPadding: const EdgeInsets.all(10),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _performIngredientSearch,
                    ),
                    prefixIcon: PopupMenuButton<String>(
                      icon: const Icon(Icons.sort),
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'Relevancy',
                            child: Text('Sort by Relevancy'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'User Rating',
                            child: Text('Sort by User Rating'),
                          ),
                        ];
                      },
                      onSelected: (String value) {
                        setState(() {
                          _selectedSortingOption = value;
                        });
                        _performIngredientSearch();
                      },
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: searchResults.isEmpty ? 1 : searchResults.length,
            itemBuilder: (context, index) {
              if (searchResults.isEmpty) {
                return const Center(
                  heightFactor: 20,
                  child: Text(
                    "Nothing here...",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                return DishItem(
                  dish: searchResults[index],
                  onSelectDish: (dish) {
                    selectDish(context, dish);
                  },
                );
              }
            },
          ),
        )
      ]),
    );
  }
}
