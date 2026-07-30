

import 'package:task2/features/meals%20details/data/models/meal_details_model.dart';

abstract class MealDetailsDataSource {
  Future<MealDetailsModel> getMealDetails(String mealId);
}