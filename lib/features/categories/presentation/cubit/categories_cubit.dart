import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:task2/core/error/failure.dart';

import 'package:task2/features/categories/domain/entities/category_entity.dart';
import 'package:task2/features/categories/domain/entities/meal_entity.dart';
import 'package:task2/features/categories/domain/usecases/get_categories.dart';
import 'package:task2/features/categories/domain/usecases/get_products_by_category.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {

  CategoriesCubit(
    this.getProductsByCategoryUseCase,
    this.getAllCategoriesUseCase
  ) : super(CategoriesInitial());
  GetProductsByCategoryUseCase getProductsByCategoryUseCase;
  GetCategoriesUseCase getAllCategoriesUseCase;

  Future<void> getAllCategories() async {
    emit(CategoriesLoadingState());
    final result = await getAllCategoriesUseCase.invoke();
    result.fold(
      (failure) => emit(CategoriesErrorState(failure)),
      (categories) => emit(CategoriesLoadedState(categories)),
    );
  }

  Future<void> getFilterProducts(String category) async {
    emit(ProductLoadingState());
    final result = await getProductsByCategoryUseCase.invoke(category);
    result.fold(
      (failure) => emit(ProductErrorState(failure)),
      (meals) => emit(ProductLoadedState(meals)),
    );
  }
}
