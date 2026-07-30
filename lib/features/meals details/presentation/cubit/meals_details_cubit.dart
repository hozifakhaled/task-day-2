import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task2/core/error/failure.dart';
import 'package:task2/features/meals%20details/domain/entities/meal_details_entity.dart';
import 'package:task2/features/meals%20details/domain/usecases/get_meals_use_case.dart';

part 'meals_details_state.dart';

class MealsDetailsCubit extends Cubit<MealsDetailsState> {
 
   MealsDetailsCubit(
    this.meal,
    
  ) : super(MealsDetailsInitial());
  GetMealsUseCase meal;

  Future<void> getMealDetails(String meals) async {
    emit(MealsDetailsLoadingState());
    final result = await meal.invoke(meals);
    result.fold(
      (failure) => emit(MealsDetailsErrorState(failure)),
      (meals) => emit(MealsDetailsLoadedState(meals)),
    );
  }
}
