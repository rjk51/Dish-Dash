import 'package:flutter/material.dart';
import 'package:dish_dash/models/dish.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:dish_dash/widgets/dishh_item_trait.dart';

class DishItem extends StatelessWidget {
  const DishItem({
    super.key,
    required this.dish,
    required this.onSelectDish,
  });

  final Dish dish;
  final void Function(Dish dish) onSelectDish;

  String get complexityText {
    return dish.complexity.name[0].toUpperCase() + dish.complexity.name.substring(1);
  }

  String get affordabilityText {
    return dish.affordability.name[0].toUpperCase() + dish.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectDish(dish);
        },
        child: Stack(
          children: [
            Hero(
              tag: dish.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(dish.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children:[
                    Text(
                      dish.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DishItemTrait(
                          icon: Icons.schedule,
                          label: '${dish.duration} min',
                        ),
                        const SizedBox(width:7),
                        DishItemTrait(
                          icon: Icons.work,
                          label: complexityText, 
                        ),
                        const SizedBox(width:7),
                        DishItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText, 
                        ),
                        const SizedBox(width:7),
                        DishItemTrait(
                          icon: Icons.star_rate_rounded, 
                          label: '${dish.rating}',
                        )
                      ],
                    )
                  ]
                ),
              ),
            )
          ], 
        ),
      ),
    );
  }
}