import 'package:flutter/material.dart';
import 'package:dish_dash/models/dish.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dish_dash/providers/favorites_provider.dart';

class DishDetailsScreen extends ConsumerWidget {
  const DishDetailsScreen({
    super.key,
    required this.dish,
    });

  final Dish dish;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteDish = ref.watch(favoriteDishProvider);

    final isFavorite = favoriteDish.contains(dish);

    return Scaffold(
      appBar: AppBar(
        title: Text(dish.title),
        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween(begin: 0.8, end: 1.0).animate(animation),
                  child: child
                );
              },
              child: Icon(isFavorite ? Icons.star : Icons.star_border, key: ValueKey(isFavorite),),
            ),
            onPressed: () {
              final wasAdded = ref.read(favoriteDishProvider.notifier).toggleDishFavoriteStatus(dish);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded ? 'Dish added as a favorite' : 'Removed from favorites'),
                ),
              );
            },
          ),],
      ),
      body: SingleChildScrollView(
        child: Column(
          children:[
            Hero(
              tag: dish.id,
              child: Image.network(
                dish.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 14),
            Text('Ingredients', style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),),
      
            const SizedBox(height: 14),
      
            for (final ingredient in dish.ingredients)
              Text(ingredient, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),),
      
            const SizedBox(height: 24),
      
            Text('Steps', style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),),
      
            const SizedBox(height: 14),
      
            for (final step in dish.steps)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Text(
                  textAlign : TextAlign.center,
                  step, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),),
              ),
          ],
        ),
      ) 
    );
  }
}