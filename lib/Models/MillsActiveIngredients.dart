import 'package:vetdrugegy/Models/DrugsCategories.dart';

class MillsActiveIngredient {
  late int id;
  late String name;
  late String nameEn;
  late bool isPoultry;
  late bool isLarge;
  late bool isFish;
  late bool isPets;

  
  MillsActiveIngredient({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.isPoultry,
    required this.isLarge,
    required this.isFish,
    required this.isPets,
  });


  factory MillsActiveIngredient.fromJson(Map<String, dynamic> json) {
    return MillsActiveIngredient(
      id: json['id'],
      name: json['name'],
      nameEn: json['nameEn'],
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
    'isPoultry':isPoultry,
    'isLarge':isLarge,
    'isFish':isFish,
    'isPets':isPets,

  };
}