import '../../domain/entities/meal_details_entity.dart';

class MealDetailsModel extends MealDetailsEntity {
  const MealDetailsModel({
    required super.idMeal,
    required super.strMeal,
    required super.strCategory,
    required super.strArea,
    required super.strCountry,
    required super.strInstructions,
    required super.strMealThumb,
    required super.strYoutube,
    required super.strSource,
    required super.ingredients,
    required super.measures,
  });

  factory MealDetailsModel.fromJson(Map<String, dynamic> json) {
    final ingredients = <String>[];
    final measures = <String>[];

    for (int i = 1; i <= 20; i++) {
      final ingredient = (json['strIngredient$i'] ?? '').toString().trim();
      final measure = (json['strMeasure$i'] ?? '').toString().trim();

      if (ingredient.isNotEmpty) {
        ingredients.add(ingredient);
        measures.add(measure);
      }
    }

    return MealDetailsModel(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strCategory: json['strCategory'] ?? '',
      strArea: json['strArea'] ?? '',
      strCountry: json['strCountry'] ?? '',
      strInstructions: json['strInstructions'] ?? '',
      strMealThumb: json['strMealThumb'] ?? '',
      strYoutube: json['strYoutube'] ?? '',
      strSource: json['strSource'],
      ingredients: ingredients,
      measures: measures,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strCategory': strCategory,
      'strArea': strArea,
      'strCountry': strCountry,
      'strInstructions': strInstructions,
      'strMealThumb': strMealThumb,
      'strYoutube': strYoutube,
      'strSource': strSource,
    };
  }

  MealDetailsModel copyWith({
    String? idMeal,
    String? strMeal,
    String? strCategory,
    String? strArea,
    String? strCountry,
    String? strInstructions,
    String? strMealThumb,
    String? strYoutube,
    String? strSource,
    List<String>? ingredients,
    List<String>? measures,
  }) {
    return MealDetailsModel(
      idMeal: idMeal ?? this.idMeal,
      strMeal: strMeal ?? this.strMeal,
      strCategory: strCategory ?? this.strCategory,
      strArea: strArea ?? this.strArea,
      strCountry: strCountry ?? this.strCountry,
      strInstructions: strInstructions ?? this.strInstructions,
      strMealThumb: strMealThumb ?? this.strMealThumb,
      strYoutube: strYoutube ?? this.strYoutube,
      strSource: strSource ?? this.strSource,
      ingredients: ingredients ?? this.ingredients,
      measures: measures ?? this.measures,
    );
  }
}