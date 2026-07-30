import 'package:dartz/dartz.dart';
import 'package:task2/core/error/failure.dart';
import 'package:task2/features/meals%20details/domain/entities/meal_details_entity.dart';
import 'package:task2/features/meals%20details/domain/repositories/meal_details_repo.dart';

class GetMealsUseCase {
    final MealDetailsRepo repository;

  GetMealsUseCase(this.repository);

  Future<Either<Failure, MealDetailsEntity>> invoke(String meal) async {
    return await repository.getMealDetails(meal);
  }
}