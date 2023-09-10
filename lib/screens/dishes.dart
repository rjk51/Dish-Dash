import 'package:flutter/material.dart';

import 'package:dish_dash/models/dish.dart';
import 'package:dish_dash/widgets/dish_item.dart';
import 'package:dish_dash/screens/dish_details.dart';

class DishesScreen extends StatelessWidget {
  const DishesScreen({
    super.key,
    this.title,
    required this.dishes,
  });

  final String? title;
  final List<Dish> dishes;

  void selectDish(BuildContext context,Dish dish) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => DishDetailsScreen(
          dish: dish,
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );

    if (dishes.isNotEmpty) {
      content = ListView.builder(
        itemCount: dishes.length,
        itemBuilder: (ctx, index) => DishItem(
          dish: dishes[index],
          onSelectDish: (dish) {
            selectDish(context, dish);
          },
        )
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}