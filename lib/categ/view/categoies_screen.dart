import 'package:dartz/dartz.dart' show Either;


import 'package:flutter/material.dart';
import 'package:task2/categ/models/categoies_model.dart';
import 'package:task2/categ/models/meals_model.dart';
import 'package:task2/categ/service/dio_service.dart';
import 'package:task2/categ/service/failure.dart';
import 'package:task2/categ/widgets/product_card.dart';

class CategoriesProductsScreen extends StatefulWidget {
  const CategoriesProductsScreen({super.key});

  @override
  State<CategoriesProductsScreen> createState() =>
      _CategoriesProductsScreenState();
}

class _CategoriesProductsScreenState
    extends State<CategoriesProductsScreen> {
  final DioService dioService = DioService();

  String selectedCategory = 'Beef';

  late Future<Either<Failure, List<CategoryModel>>> categoriesFuture;
  late Future<Either<Failure, List<MealModel>>> productsFuture;

  @override
  void initState() {
    super.initState();

    categoriesFuture = dioService.getAllCategories();
    productsFuture = dioService.getFilterProducts(selectedCategory);
  }

  void _onCategoryTap(String categoryName) {
    if (selectedCategory == categoryName) return;

    setState(() {
      selectedCategory = categoryName;
      productsFuture = dioService.getFilterProducts(categoryName);
    });
  }

  Widget _loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _error(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Store',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          /// Categories Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// Categories List
          SizedBox(
            height: 45,
            child: FutureBuilder<Either<Failure, List<CategoryModel>>>(
              future: categoriesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _loading();
                }

                if (snapshot.hasError) {
                  return _error(snapshot.error.toString());
                }

                final result = snapshot.data;

                if (result == null) {
                  return const SizedBox();
                }

                return result.fold(
                  (failure) => _error(failure.message),
                  (categories) {
                    if (categories.isEmpty) {
                      return const Center(
                        child: Text('No Categories Found'),
                      );
                    }

                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: 10),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];

                        final isSelected =
                            selectedCategory == category.strCategory;

                        return GestureDetector(
                          onTap: () =>
                              _onCategoryTap(category.strCategory),
                          child: AnimatedContainer(
                            duration:
                                const Duration(milliseconds: 250),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.black
                                  : Colors.white,
                              borderRadius:
                                  BorderRadius.circular(25),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.black
                                    : Colors.grey.shade300,
                              ),
                            ),
                            child: Text(
                              category.strCategory,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          /// Products Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Products',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// Products Grid
          Expanded(
            child: FutureBuilder<Either<Failure, List<MealModel>>>(
              future: productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _loading();
                }

                if (snapshot.hasError) {
                  return _error(snapshot.error.toString());
                }

                final result = snapshot.data;

                if (result == null) {
                  return const SizedBox();
                }

                return result.fold(
                  (failure) => _error(failure.message),
                  (products) {
                    if (products.isEmpty) {
                      return const Center(
                        child: Text('No Products Found'),
                      );
                    }

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
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}