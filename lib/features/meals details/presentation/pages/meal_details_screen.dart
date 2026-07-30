import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/core/di/service_locator.dart';
import 'package:task2/features/meals%20details/presentation/cubit/meals_details_cubit.dart';

import '../widgets/about_meal_card.dart';
import '../widgets/ingredient_list.dart';
import '../widgets/instruction_card.dart';
import '../widgets/meal_header.dart';
import '../widgets/meal_info_chips.dart';
import '../widgets/source_buttons.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key, required this.mealId});

  final String mealId;

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (context) => getIt<MealsDetailsCubit>()..getMealDetails(mealId),
      child: Scaffold(
        backgroundColor: const Color(0xffF8F8F8),

        body: BlocBuilder<MealsDetailsCubit, MealsDetailsState>(
          builder: (context, state) {
            if (state is MealsDetailsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is MealsDetailsErrorState) {
              return Center(child: Text(state.failure.message));
            }

            if (state is MealsDetailsLoadedState) {
              final meal = state.meals;

              return CustomScrollView(
                physics: const BouncingScrollPhysics(),

                slivers: [
                  /// Header Image
                  SliverToBoxAdapter(
                    child: MealHeader(
                      image: meal.strMealThumb,
                      title: meal.strMeal,
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Name
                          Text(
                            meal.strMeal,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 18),

                          /// Chips
                          MealInfoChips(
                            category: meal.strCategory,
                            area: meal.strArea,
                            country: meal.strCountry,
                          ),

                          const SizedBox(height: 25),

                          /// Youtube & Source
                          SourceButtons(
                            youtube: meal.strYoutube,
                            source: meal.strSource ?? "",
                          ),

                          const SizedBox(height: 30),

                          const Text(
                            "Ingredients",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 15),

                          IngredientList(
                            ingredients: meal.ingredients,
                            measures: meal.measures,
                          ),

                          const SizedBox(height: 30),

                          const Text(
                            "Instructions",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 15),

                          InstructionCard(instruction: meal.strInstructions),

                          const SizedBox(height: 30),

                          AboutMealCard(meal: meal),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
