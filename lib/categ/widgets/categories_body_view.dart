
import 'package:flutter/material.dart';
import 'package:task2/categ/widgets/categories_list.dart';
import 'package:task2/categ/widgets/produc_grid_view.dart';

class CategoriesBodyView extends StatelessWidget {
  const CategoriesBodyView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
    
        /// Categories Title
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Categories',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
    
        const SizedBox(height: 12),
    
        /// Categories List
        CategoriesList(),
    
        const SizedBox(height: 24),
    
        /// Products Title
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Products',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
    
        const SizedBox(height: 12),
    
        /// Products Grid
        ProductsGridView(),
      ],
    );
  }
}
