import 'package:dartz/dartz.dart';
import 'package:task2/core/error/failure.dart';
import 'package:task2/features/categories/domain/entities/category_entity.dart';
import 'package:task2/features/categories/domain/entities/meal_entity.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, List<MealEntity>>> getProductsByCategory(String category);
}