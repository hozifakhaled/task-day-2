import 'package:task2/core/network/api_consumer.dart';
import 'package:task2/core/network/endpoints.dart';
import 'package:task2/features/meals%20details/data/datasources/meal_details_data_sourse.dart';
import 'package:task2/features/meals%20details/data/models/meal_details_model.dart';

class MealDetailsDataSourceRemote implements MealDetailsDataSource {
  final ApiConsumer dio;

  MealDetailsDataSourceRemote({required this.dio});
  @override
  Future<MealDetailsModel> getMealDetails(String mealId) async {
    final response = await dio.get(path: Endpoints.mealDetails(mealId));
    return response.fold(
      (f) {
        throw Exception(f.message);
      },
      (response) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          
final meal = MealDetailsModel.fromJson(
  response.data["meals"][0],
);

return meal;
        } else {
          final errorMessage = response.data["message"];
          throw Exception(errorMessage);
        }
      },
    );
  }
}
