
/// Model representing a single meal item
class MealModel {
  final String strMeal;
  final String strMealThumb;
  final String idMeal;
  final String? strArea;
  final String strCountry;
 
  MealModel({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
    required this.strArea,
    required this.strCountry,
  });
 
  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      strMeal: json['strMeal'] as String? ?? '',
      strMealThumb: json['strMealThumb'] as String? ?? '',
      idMeal: json['idMeal'] as String? ?? '',
      strArea: json['strArea'] as String?,
      strCountry: json['strCountry'] as String? ?? '',
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