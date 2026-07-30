part of 'meals_details_cubit.dart';

abstract class MealsDetailsState extends Equatable {
  const MealsDetailsState();

  @override
  List<Object> get props => [];
}

class MealsDetailsInitial extends MealsDetailsState {}

final class MealsDetailsLoadingState extends MealsDetailsState {}

final class MealsDetailsLoadedState extends MealsDetailsState {
  final MealDetailsEntity meals;

  const MealsDetailsLoadedState(this.meals);

  @override
  List<Object> get props => [meals];
}

final class MealsDetailsErrorState extends MealsDetailsState {
  final Failure failure;

  const MealsDetailsErrorState(this.failure);

  @override
  List<Object> get props => [failure];
}


