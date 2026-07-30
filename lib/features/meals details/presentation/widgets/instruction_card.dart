import 'package:flutter/material.dart';

class InstructionCard extends StatelessWidget {
  const InstructionCard({
    super.key,
    required this.instruction,
  });

  final String instruction;

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
          Row(
            children: const [
              Icon(
                Icons.menu_book_rounded,
                color: Colors.orange,
              ),
              SizedBox(width: 8),
              Text(
                "Cooking Instructions",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            instruction,
            style: const TextStyle(
              fontSize: 15,
              height: 1.7,
              color: Colors.black87,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}