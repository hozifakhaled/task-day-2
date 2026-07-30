import '../../domain/entities/meal_entity.dart';

class MealModel extends MealEntity {
  const MealModel({
    required super.strMeal,
    required super.strMealThumb,
    required super.idMeal,
    required super.strArea,
    required super.strCountry,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      strMeal: json['strMeal'] ?? '',
      strMealThumb: json['strMealThumb'] ?? '',
      idMeal: json['idMeal'] ?? '',
      strArea: json['strArea'],
      strCountry: json['strCountry'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'strMeal': strMeal,
      'strMealThumb': strMealThumb,
      'idMeal': idMeal,
      'strArea': strArea,
      'strCountry': strCountry,
    };
  }

  MealModel copyWith({
    String? strMeal,
    String? strMealThumb,
    String? idMeal,
    String? strArea,
    String? strCountry,
  }) {
    return MealModel(
      strMeal: strMeal ?? this.strMeal,
      strMealThumb: strMealThumb ?? this.strMealThumb,
      idMeal: idMeal ?? this.idMeal,
      strArea: strArea ?? this.strArea,
      strCountry: strCountry ?? this.strCountry,
    );
  }
}