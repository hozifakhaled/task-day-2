import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task2/categ/models/categoies_model.dart';
import 'package:task2/categ/models/meals_model.dart';
import 'package:task2/categ/service/dio_service.dart';
import 'package:task2/categ/service/failure.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());
  DioService dioService = DioService();

  Future<void> getAllCategories() async {
    emit(CategoriesLoadingState());
    final result = await dioService.getAllCategories();
    result.fold(
      (failure) => emit(CategoriesErrorState(failure)),
      (categories) => emit(CategoriesLoadedState(categories)),
    );
  }

  Future<void> getFilterProducts(String category) async {
    emit(ProductLoadingState());
    final result = await dioService.getFilterProducts(category);
    result.fold(
      (failure) => emit(ProductErrorState(failure)),
      (meals) => emit(ProductLoadedState(meals)),
    );
  }
}
