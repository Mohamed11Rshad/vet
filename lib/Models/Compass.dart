import 'User.dart';

class Compass {
  int? id;
  int? direction;
  String? entryDate;
  int? animalType;
  int? quantity;
  num? weight;
  num? price;
  int? userId;
  User? user;

  Compass({
    this.id,
    this.direction,
    this.entryDate,
    this.animalType,
    this.quantity,
    this.weight,
    this.price,
    this.userId,
    this.user,

  });


  factory Compass.fromJson(Map<String, dynamic> json) {
    return Compass(
      id: json['id'],
      direction: json['direction'],
      entryDate: json['entryDate'],
      animalType: json['animalType'],
      quantity: json['quantity'],
      weight: json['weight'],
      price: json['price'],
      userId: json['userId'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,



    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'direction': direction,
    'entryDate': entryDate,
    'animalType': animalType,
    'quantity': quantity,
    'weight': weight,
    'price': price,
    'userId': userId,
    'user': user,
  };
}