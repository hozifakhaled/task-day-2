
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/categ/cubit/categories_cubit.dart';
import 'package:task2/categ/widgets/product_card.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
    
         else if (state is ProductErrorState) {
            return Text(state.failure.message);
          }
    
      else    if (state is ProductLoadedState) {
            final products = state.meals;
    
            return GridView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              itemCount: products.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: .72,
                  ),
              itemBuilder: (context, index) {
                final product = products[index];
    
                return ProductCard(
                  name: product.strMeal,
                  imageUrl: product.strMealThumb,
                  price: '',
                );
              },
            );
          }
          else {
            return const SizedBox(
              
            );
          }
        },
      ),
    );
  }
}
