import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task2/categ/models/categoies_model.dart';
import 'package:task2/categ/models/meals_model.dart';
import 'package:task2/categ/service/error_handler.dart';
import 'package:task2/categ/service/failure.dart';

class DioService {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://themealdb.com/api/json/v1/1/',
      headers: {'Content-Type': 'application/json'},
    ),
  );
  Future<Either<Failure, List<CategoryModel>>> getAllCategories() async {
    try {
      final response = await dio.get('categories.php');
      final allCategories = response.data['categories'] as List<dynamic>;
      final categories = allCategories
          .map(
            (category) =>
                CategoryModel.fromJson(category as Map<String, dynamic>),
          )
          .toList();

      return Right(categories);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
   Future<Either<Failure, List<MealModel>>> getFilterProducts(String category ) async {
    try {
      final response = await dio.get('filter.php?c=$category');
      final allMeals = response.data['meals'] as List<dynamic>;
      final meals = allMeals
          .map(
            (meal) =>
                MealModel.fromJson(meal  as Map<String, dynamic>),
          )
          .toList();

      return Right(meals);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

}
