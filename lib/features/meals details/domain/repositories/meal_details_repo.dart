import 'package:dartz/dartz.dart';
import 'package:task2/core/error/failure.dart';

import 'package:task2/features/meals%20details/domain/entities/meal_details_entity.dart';

abstract class MealDetailsRepo {
  Future<Either<Failure, MealDetailsEntity>> getMealDetails (String category);
}