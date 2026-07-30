import 'package:task2/core/network/api_consumer.dart';
import 'package:task2/core/network/endpoints.dart';
import 'package:task2/features/categories/data/datasources/categories_data_sources.dart';
import 'package:task2/features/categories/data/models/category_model.dart';
import 'package:task2/features/categories/data/models/meal_model.dart';

class CategoriesRemoteDataSourse implements CategoriesDataSource {
  final ApiConsumer dio;

  CategoriesRemoteDataSourse({required this.dio});
  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await dio.get(path: Endpoints.categories);
   return response.fold(
      (f) {
        throw Exception(f.message);
      },
      (response) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final jsonRes = response.data["categories"] as List;
          final modelRes = jsonRes
              .map(((e) => CategoryModel.fromJson(e)))
              .toList();
          return modelRes;
        } else {
          final errorMessage = response.data["message"];
          throw Exception(errorMessage);
        }
      },
    );
  }

  @override
  Future< List<MealModel>> getProductsByCategory (
    String category,
  )async {
     final response = await dio.get(path: Endpoints.filterProducts(category));
   return response.fold(
      (f) {
        throw Exception(f.message);
      },
      (response) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final jsonRes = response.data["meals"] as List;
          final modelRes = jsonRes
              .map(((e) => MealModel  .fromJson(e)))
              .toList();
          return modelRes;
        } else {
          final errorMessage = response.data["message"];
          throw Exception(errorMessage);
        }
      },
    );
  }
}
