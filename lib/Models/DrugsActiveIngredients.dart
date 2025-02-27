import 'package:vetdrugegy/Models/DrugsCategories.dart';

class DrugsActiveIngredients {
  late int id;
  late String name;
  late String nameEn;
  late int categoryId;
  DrugsCategories? category;
  late bool isPoultry;
  late bool isLarge;
  late bool isFish;
  late bool isPets;
  
  DrugsActiveIngredients({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.categoryId,
    this.category,
    required this.isPoultry,
    required this.isLarge,
    required this.isFish,
    required this.isPets,

  });


  factory DrugsActiveIngredients.fromJson(Map<String, dynamic> json) {
    return DrugsActiveIngredients(
      id: json['id'],
      name: json['name'],
      nameEn: json['nameEn'],
      categoryId: json['categoryId'],
      category: json["category"] != null ? DrugsCategories.fromJson(json["category"]) : null,
      isPoultry: json['isPoultry'],
      isLarge: json['isLarge'],
      isFish: json['isFish'],
      isPets: json['isPets'],

    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'nameEn' :nameEn,
    'categoryId': categoryId,
    'category': category,
    'isPoultry':isPoultry,
    'isLarge':isLarge,
    'isFish':isFish,
    'isPets':isPets,

  };
}