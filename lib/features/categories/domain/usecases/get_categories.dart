import 'package:dartz/dartz.dart';
import 'package:task2/core/error/failure.dart';
import 'package:task2/features/categories/domain/entities/category_entity.dart';
import 'package:task2/features/categories/domain/repositories/caegories_repo.dart';

class GetCategoriesUseCase {
  final CategoriesRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> invoke() async {
    return await repository.getCategories();
  }
}