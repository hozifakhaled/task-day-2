
class Endpoints {
  static String get baseUrl {
   
      return "https://themealdb.com/api/json/v1/1/"; // Emulator
    
  }
  static String get categories => 'categories.php';
  static String  filterProducts(String category) => 'filter.php?c=$category';
  static String  mealDetails(String mealId) => 'lookup.php?i=$mealId';

}
                                                                                           