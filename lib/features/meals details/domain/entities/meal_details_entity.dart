class MealDetailsEntity {
  final String idMeal;
  final String strMeal;
  final String strCategory;
  final String strArea;
  final String strCountry;
  final String strInstructions;
  final String strMealThumb;
  final String strYoutube;
  final String? strSource;

  final List<String> ingredients;
  final List<String> measures;

  const MealDetailsEntity({
    required this.idMeal,
    required this.strMeal,
    required this.strCategory,
    required this.strArea,
    required this.strCountry,
    required this.strInstructions,
    required this.strMealThumb,
    required this.strYoutube,
    required this.strSource,
    required this.ingredients,
    required this.measures,
  });
}