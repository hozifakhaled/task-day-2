import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/categ/cubit/categories_cubit.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  String? selectedCategory;
  bool _loadedFirstCategory = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
         buildWhen: (previous, current) {
    return current is CategoriesLoadingState ||
        current is CategoriesLoadedState ||
        current is CategoriesErrorState;
  },
        builder: (context, state) {
          if (state is CategoriesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CategoriesErrorState) {
            return Center(
              child: Text(state.failure.message),
            );
          }

          if (state is CategoriesLoadedState) {
            final categories = state.categories;

            if (categories.isEmpty) {
              return const Center(
                child: Text("No Categories"),
              );
            }

            // أول مرة فقط
            if (!_loadedFirstCategory) {
              selectedCategory = categories.first.strCategory;
              _loadedFirstCategory = true;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                context
                    .read<CategoriesCubit>()
                    .getFilterProducts(selectedCategory!);
              });
            }

            return ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];

                final isSelected =
                    selectedCategory == category.strCategory;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category.strCategory;
                    });

                    context
                        .read<CategoriesCubit>()
                        .getFilterProducts(category.strCategory);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.orange
                          : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isSelected
                            ? Colors.orange
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Text(
                      category.strCategory,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox(

            child: Center(
              child: Text("No Categories"),
            ),
          );
        },
      ),
    );
  }
}