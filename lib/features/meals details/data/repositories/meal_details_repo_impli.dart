import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task2/core/error/failure.dart';
import 'package:task2/features/meals%20details/data/datasources/meal_details_data_sourse.dart';
import 'package:task2/features/meals%20details/data/models/meal_details_model.dart';
import 'package:task2/features/meals%20details/domain/repositories/meal_details_repo.dart';

class MealDetailsRepoImpli implements MealDetailsRepo {
  final MealDetailsDataSource dataSource;
  MealDetailsRepoImpli({required this.dataSource});
  @override
  @override
  Future<Either<Failure, MealDetailsModel>> getMealDetails(
    String category,
  ) async {
    try {
      final meals = await dataSource.getMealDetails(category);
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
  }
}
