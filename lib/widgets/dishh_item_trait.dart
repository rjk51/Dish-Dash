import 'package:flutter/material.dart';

class DishItemTrait extends StatelessWidget {
  const DishItemTrait({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: Colors.white,
        ),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            )),
      ],
    );
  }
}
