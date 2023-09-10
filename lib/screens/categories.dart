import 'package:dish_dash/screens/dishes.dart';
import 'package:flutter/material.dart';
import 'package:dish_dash/data/dummy_data.dart';
import 'package:dish_dash/widgets/category_grid_item.dart';
import 'package:dish_dash/models/category.dart';
import 'package:dish_dash/models/dish.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableDishes,
    });

  final List<Dish> availableDishes;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin{

  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animationController.forward();

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredDishes = widget.availableDishes
      .where((dish) => dish.categories.contains(category.id))
      .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => DishesScreen(
          title: category.title,
          dishes : filteredDishes,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            }
            ),
      ],
    ), 
      builder: (context,child) => SlideTransition(
        position: Tween(
          begin: const Offset(0,0.3),
          end: const Offset(0,0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          )
        ),
        child: child,
      )
    );
  }
}