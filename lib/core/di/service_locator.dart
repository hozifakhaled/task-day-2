import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:task2/features/categories/data/datasources/categories_data_sources.dart';
import 'package:task2/features/categories/data/datasources/categories_remote_data_sourse.dart';
import 'package:task2/features/categories/data/repositories/categories_repo_impli.dart';
import 'package:task2/features/categories/domain/repositories/caegories_repo.dart';
import 'package:task2/features/categories/domain/usecases/get_categories.dart';
import 'package:task2/features/categories/domain/usecases/get_products_by_category.dart';
import 'package:task2/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:task2/features/meals%20details/data/datasources/meal_details_data_source_remote.dart';
import 'package:task2/features/meals%20details/data/datasources/meal_details_data_sourse.dart';
import 'package:task2/features/meals%20details/data/repositories/meal_details_repo_impli.dart';
import 'package:task2/features/meals%20details/domain/repositories/meal_details_repo.dart';
import 'package:task2/features/meals%20details/domain/usecases/get_meals_use_case.dart';
import 'package:task2/features/meals%20details/presentation/cubit/meals_details_cubit.dart';


import '../network/api_consumer.dart';

import '../network/dio_consumer.dart';
import '../network/interceptors.dart';

final GetIt getIt = GetIt.instance;

/// Initialize all dependencies for the application
Future<void> initServiceLocator() async {
  _registerCoreServices();
  _registerRepositories();
  _registerCubits();
  _registerDataSourses();
  _registerUsecase();
}

/// Register core services that should be singletons
void _registerCoreServices() {
 

  getIt.registerLazySingleton<LoggerInterceptor>(() => LoggerInterceptor());

  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        logPrint: (object) => getIt<LoggerInterceptor>().logger.i(object.toString()),
      )
    );
    dio.interceptors.add(getIt<LoggerInterceptor>());
    return dio;
  });

  getIt.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(dio: getIt<Dio>()),
  );

}
void _registerDataSourses() {
  getIt.registerLazySingleton<CategoriesDataSource>(
    () => CategoriesRemoteDataSourse(dio:getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<MealDetailsDataSource>(
    () => MealDetailsDataSourceRemote(dio:getIt<ApiConsumer>()),
  );
}
void _registerRepositories() {
  getIt.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepoImpl(dataSource: getIt<CategoriesDataSource>()),
  );
  getIt.registerLazySingleton<MealDetailsRepo>(
    () => MealDetailsRepoImpli(dataSource: getIt<MealDetailsDataSource>()),
  );
 

}
  
void _registerUsecase() {
    getIt.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase( getIt<CategoriesRepository>()),
  );
    getIt.registerLazySingleton<GetProductsByCategoryUseCase>(
    () => GetProductsByCategoryUseCase( getIt<CategoriesRepository>()),
  );
  getIt.registerLazySingleton<GetMealsUseCase>(
    () => GetMealsUseCase( getIt<MealDetailsRepo>()),
  );
}

/// Register all cubits as factories (new instance each time)
void _registerCubits() {
  getIt.registerFactory<CategoriesCubit>(
    () => CategoriesCubit(
      getIt<GetProductsByCategoryUseCase>(),
      getIt<GetCategoriesUseCase>()
    ),
  );
  getIt.registerFactory<MealsDetailsCubit>(
    () => MealsDetailsCubit(
      getIt<GetMealsUseCase>()
    ),
    
  );
}
 


/// Reset all registrations (useful for testing)
Future<void> resetServiceLocator() async {
  await getIt.reset();
}

/// Check if service locator is ready
bool get isServiceLocatorReady => getIt.isRegistered<ApiConsumer>();
