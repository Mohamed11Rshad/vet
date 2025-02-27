import 'package:vetdrugegy/Models/DrugsCategories.dart';

import 'DrugsActiveIngredients.dart';
import 'User.dart';

class Jobs {
  late int id;
  late String name;
  late String details;
  late int government;
  late String city;
  late String phone;
  late int userId;
  User? user;
  String? attachment;

  Jobs({
    required this.id,
    required this.name,
    required this.details,
    required this.government,
    required this.city,
    required this.phone,
    required this.userId,
    this.user,
    this.attachment,

  });


  factory Jobs.fromJson(Map<String, dynamic> json) {
    return Jobs(
      id: json['id'],
      name: json['name'],
      details: json['details'],
      government: json['government'],
      city: json['city'],
      phone: json['phone'],
      userId: json['userId'],
      user: json["user"] != null ? User.fromJson(json["user"]) : null,
      attachment: json['attachment'],

    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'details' :details,
    'government': government,
    'city': city,
    'phone': phone,
    'userId': userId,
    'user': user,
    'attachment': attachment,
  };
}