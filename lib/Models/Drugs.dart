import 'package:vetdrugegy/Models/DrugsCategories.dart';

import 'DrugsActiveIngredients.dart';
import 'User.dart';

class Drugs {
  late int id;
  late String name;
  late String nameEn;
  late String description;
  late String descriptionEn;
  late String company;
  late String companyEn;
  late bool isDrug;
  late int userId;
  late int divisionId;
  late num price;
  User? user;
  late int activeIngredientId;
  DrugsActiveIngredients? activeIngredient;
  String? image;
  String? attachment;

  Drugs({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.description,
    required this.descriptionEn,
    required this.company,
    required this.companyEn,
    required this.isDrug,
    required this.userId,
    this.user,
    required this.activeIngredientId,
    this.activeIngredient,
    this.image,
    this.attachment,
    required this.price,
    required this.divisionId

  });


  factory Drugs.fromJson(Map<String, dynamic> json) {
    return Drugs(
      id: json['id'],
      name: json['name'],
      nameEn: json['nameEn'],
      description: json['description']!= null? json['description']:"",
      descriptionEn: json['descriptionEn']!= null? json['descriptionEn']:"",
      company: json['company']!= null? json['company']:"",
      companyEn: json['companyEn']!= null? json['companyEn']:"",
      isDrug: json['isDrug'],
      userId: json['userId'],
      user: json["user"] != null ? User.fromJson(json["user"]) : null,
      activeIngredientId: json['activeIngredientId'],
      activeIngredient: json["activeIngredient"] != null ? DrugsActiveIngredients.fromJson(json["activeIngredient"]) : null,
      attachment: json['attachment'],
      image: json['image'],
      price: json['price'],
      divisionId: json['divisionId'],

    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'nameEn' :nameEn,
    'description': description,
    'descriptionEn': descriptionEn,
    'company': company,
    'companyEn' :companyEn,
    'isDrug': isDrug,
    'userId': userId,
    'user': user,
    'activeIngredientId' :activeIngredientId,
    'activeIngredient': activeIngredient,
    'attachment': attachment,
    'image': image,
    'price': price,
    'divisionId':divisionId

  };
}