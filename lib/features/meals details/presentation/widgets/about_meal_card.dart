import 'package:flutter/material.dart';

import '../../domain/entities/meal_details_entity.dart';

class AboutMealCard extends StatelessWidget {
  const AboutMealCard({
    super.key,
    required this.meal,
  });

  final MealDetailsEntity meal;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.orange,
              ),
              SizedBox(width: 8),
              Text(
                "About Meal",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          _InfoTile(
            icon: Icons.restaurant_menu,
            title: "Category",
            value: meal.strCategory,
          ),

          const Divider(height: 24),

          _InfoTile(
            icon: Icons.public,
            title: "Area",
            value: meal.strArea,
          ),

          const Divider(height: 24),

          _InfoTile(
            icon: Icons.flag,
            title: "Country",
            value: meal.strCountry,
          ),

          if (meal.strSource != null &&
              meal.strSource!.isNotEmpty) ...[
            const Divider(height: 24),
            _InfoTile(
              icon: Icons.language,
              title: "Source",
              value: meal.strSource!,
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.orange.withOpacity(.12),
          child: Icon(
            icon,
            color: Colors.orange,
            size: 20,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}