import 'package:flutter/material.dart';

class MealHeader extends StatelessWidget {
  const MealHeader({
    super.key,
    required this.image,
    required this.title,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Stack(
        children: [
          // Image
          Positioned.fill(
            child: Hero(
              tag: image,
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black26,
                    Colors.transparent,
                    Colors.black54,
                  ],
                ),
              ),
            ),
          ),

          // Back Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          // Favorite Button
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Title
          Positioned(
            left: 20,
            right: 20,
            bottom: 25,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}