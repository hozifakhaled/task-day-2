import 'package:flutter/material.dart';

class MealInfoChips extends StatelessWidget {
  const MealInfoChips({
    super.key,
    required this.category,
    required this.area,
    required this.country,
  });

  final String category;
  final String area;
  final String country;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _InfoChip(
          icon: Icons.restaurant_menu,
          text: category,
          color: Colors.orange,
        ),
        _InfoChip(
          icon: Icons.public,
          text: area,
          color: Colors.green,
        ),
        _InfoChip(
          icon: Icons.flag,
          text: country,
          color: Colors.blue,
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: color.withOpacity(.25),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: color,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}