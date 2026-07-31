import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task2/core/connections/network_info.dart';
import 'package:task2/core/error/failure.dart';
import 'package:task2/features/categories/data/datasources/categories_data_sources.dart';
import 'package:task2/features/categories/data/datasources/categories_data_sourse_local.dart';
import 'package:task2/features/categories/data/models/category_model.dart';
import 'package:task2/features/categories/data/models/meal_model.dart';

import 'package:task2/features/categories/domain/repositories/caegories_repo.dart';

class CategoriesRepoImpl implements CategoriesRepository {
  final CategoriesDataSource dataSource;
  final NetworkInfo networkInfo;

  final CategoriesDatasourseLocal local;
  CategoriesRepoImpl(this.networkInfo, this.local, {required this.dataSource});
  @override
  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final categories = await dataSource.getCategories();
        await local.cacheCategories(categories);
        return Right(categories);
      } on Exception catch (e) {
        if (e is DioException) {
          return left(
            ServerFailure(e.response?.data['message'] ?? 'Server error'),
          );
        } else {
          return left(ServerFailure(e.toString()));
        }
      }
    } else {
      final categoriescached = await local.getLastCategories();
      return Right(categoriescached);
    }
  }

  @override
  Future<Either<Failure, List<MealModel>>> getProductsByCategory(
    String category,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final meals = await dataSource.getProductsByCategory(category);
        await local.cacheMeals(meals);
        return Right(meals);
      } on Exception catch (e) {
        if (e is DioException) {
          return left(
            ServerFailure(e.response?.data['message'] ?? 'Server error'),
          );
        } else {
          return left(ServerFailure(e.toString()));
        }
      }
    } else {
      final mealscached = await local.getLastMeals();
      return Right(mealscached);
    }
  }
}
