part of 'categories_cubit.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoadingState extends CategoriesState {}

final class CategoriesLoadedState extends CategoriesState {
  final List<CategoryEntity> categories;

  const CategoriesLoadedState(this.categories);

  @override
  List<Object> get props => [categories];
}

final class CategoriesErrorState extends CategoriesState {
  final Failure failure;

  const CategoriesErrorState(this.failure);

  @override
  List<Object> get props => [failure];
}

final class ProductLoadedState extends CategoriesState {
  final List<MealEntity> meals;

  const ProductLoadedState(this.meals);
}

final class ProductLoadingState extends CategoriesState {}

final class ProductErrorState extends CategoriesState {
  final Failure failure;

  const ProductErrorState(this.failure);
}