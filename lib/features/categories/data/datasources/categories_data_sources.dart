import 'package:task2/features/categories/data/models/category_model.dart';
import 'package:task2/features/categories/data/models/meal_model.dart';

abstract class CategoriesDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<MealModel>> getProductsByCategory(String category);
  cacheCategories(List<CategoryModel>? categoriesToCache);
  Future<List<CategoryModel>> getLastCategories();
  cacheMeals(List<MealModel>? meals);
  Future<List<MealModel>> getLastMeals();

}
