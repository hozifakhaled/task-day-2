import 'package:flutter/material.dart';

class IngredientList extends StatelessWidget {
  const IngredientList({
    super.key,
    required this.ingredients,
    required this.measures,
  });

  final List<String> ingredients;
  final List<String> measures;

  @override
  Widget build(BuildContext context) {
    if (ingredients.isEmpty) {
      return const Center(
        child: Text("No ingredients found"),
      );
    }

    return Container(
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
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: ingredients.length,
        separatorBuilder: (_, __) => const Divider(height: 22),
        itemBuilder: (context, index) {
          final ingredient = ingredients[index];

          final measure = index < measures.length
              ? measures[index]
              : "";

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.orange.withOpacity(.12),
                child: const Icon(
                  Icons.check,
                  color: Colors.orange,
                  size: 18,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Text(
                  ingredient,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              if (measure.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    measure,
                    style: TextStyle(
                      color: Colors.orange.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}