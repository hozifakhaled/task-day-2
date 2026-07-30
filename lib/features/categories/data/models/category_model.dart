import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.idCategory,
    required super.strCategory,
    required super.strCategoryThumb,
    required super.strCategoryDescription,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      idCategory: json['idCategory'] ?? '',
      strCategory: json['strCategory'] ?? '',
      strCategoryThumb: json['strCategoryThumb'] ?? '',
      strCategoryDescription: json['strCategoryDescription'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCategory': idCategory,
      'strCategory': strCategory,
      'strCategoryThumb': strCategoryThumb,
      'strCategoryDescription': strCategoryDescription,
    };
  }

  CategoryModel copyWith({
    String? idCategory,
    String? strCategory,
    String? strCategoryThumb,
    String? strCategoryDescription,
  }) {
    return CategoryModel(
      idCategory: idCategory ?? this.idCategory,
      strCategory: strCategory ?? this.strCategory,
      strCategoryThumb: strCategoryThumb ?? this.strCategoryThumb,
      strCategoryDescription:
          strCategoryDescription ?? this.strCategoryDescription,
    );
  }
}