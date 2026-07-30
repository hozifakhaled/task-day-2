import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task2/core/error/failure.dart';
import 'package:task2/features/categories/data/datasources/categories_data_sources.dart';
import 'package:task2/features/categories/data/models/category_model.dart';
import 'package:task2/features/categories/data/models/meal_model.dart';

import 'package:task2/features/categories/domain/repositories/caegories_repo.dart';

class CategoriesRepoImpl  implements CategoriesRepository{
  final CategoriesDataSource dataSource;
  CategoriesRepoImpl({required this.dataSource});
  @override

@override
Future<Either<Failure, List<CategoryModel>>> getCategories() async {
 try {
      final categories = await dataSource.getCategories();
      return Right(categories);
    }on Exception catch (e) {
      if (e is DioException) {
           return left(ServerFailure( e.response?.data['message'] ?? 'Server error'));
      }else {
        return left(ServerFailure(e.toString()));
      }
   
    }
}

  @override
  Future<Either<Failure, List<MealModel>>> getProductsByCategory(String category)async {
    try {
      final meals = await dataSource.getProductsByCategory(category);
      return Right(meals);
    }on Exception catch (e) {
      if (e is DioException) {
           return left(ServerFailure( e.response?.data['message'] ?? 'Server error'));
      }else {
        return left(ServerFailure(e.toString()));
      }
   
    }
  }
}