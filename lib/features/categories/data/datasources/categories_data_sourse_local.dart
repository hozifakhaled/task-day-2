import 'dart:convert';

import 'package:task2/core/cache/cache_helper.dart';
import 'package:task2/features/categories/data/datasources/categories_data_sources.dart';
import 'package:task2/features/categories/data/models/category_model.dart';
import 'package:task2/features/categories/data/models/meal_model.dart';

class CategoriesDatasourseLocal  extends CategoriesDataSource {
  final CacheHelper cache;
  final String keys = "Cachedcategories";
  final String keys2 = "Cachedmeals";
  CategoriesDatasourseLocal({required this.cache});

  cacheCategories(List<CategoryModel>? categoriesToCache) {
    if (categoriesToCache != null) {
      cache.saveData(
        key:keys,
        value: json.encode(
          categoriesToCache.map((category)=>category.toJson()).toList(),
        ),
      );
    } else {
        throw Exception("No Internet Connection");
      }
  }

  Future<List<CategoryModel>> getLastCategories() {
    final jsonString = cache.getDataString(key:keys);

    if (jsonString != null) {
  final List<dynamic> decodedJson = json.decode(jsonString);
    final List<CategoryModel> categoryList = decodedJson.map((jsonItem) => CategoryModel.fromJson(jsonItem)).toList();
     
      return Future.value(categoryList);
    } else {
      throw Exception("No Internet Connection");
    }
  }
 
 
    cacheMeals(List<MealModel>? meals) {
    if (meals != null) {
      cache.saveData(
        key:keys,
        value: json.encode(
          meals.map((meal)=>meal.toJson()).toList(),
        ),
      );
    } else {
        throw Exception("No Internet Connection");
      }
  }
  Future<List<MealModel>> getLastMeals() {
    final jsonString = cache.getDataString(key:keys);

    if (jsonString != null) {
  final List<dynamic> decodedJson = json.decode(jsonString);
    final List<MealModel> mealList = decodedJson.map((jsonItem) => MealModel.fromJson(jsonItem)).toList();
     
      return Future.value(mealList);
    } else {
      throw Exception("No Internet Connection");
    }
  }
  
  @override
  Future<List<CategoryModel>> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }
  
  @override
  Future<List<MealModel>> getProductsByCategory(String category) {
    // TODO: implement getProductsByCategory
    throw UnimplementedError();
  }
  
}
