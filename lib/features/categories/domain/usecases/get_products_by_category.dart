import 'package:dartz/dartz.dart';
import 'package:task2/core/error/failure.dart';
import 'package:task2/features/categories/domain/entities/meal_entity.dart';
import 'package:task2/features/categories/domain/repositories/caegories_repo.dart';

class GetProductsByCategoryUseCase {
  final CategoriesRepository repository;
  GetProductsByCategoryUseCase(this.repository);

  Future<Either<Failure, List<MealEntity>>> invoke(String category) async {
    return await repository.getProductsByCategory(category);
  }
} 