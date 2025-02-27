import 'User.dart';

class CompassResult {
  int? id;
  int? animalType;
  num? avgPrice;
  num? sell;
  num? buy;

  CompassResult({
    this.id,
    this.animalType,
    this.avgPrice,
    this.sell,
    this.buy,

  });


  factory CompassResult.fromJson(Map<String, dynamic> json) {
    return CompassResult(
      id: json['id'],
      animalType: json['animalType'],
      avgPrice: json['avgPrice'],
      sell: json['sell'],
      buy: json['buy'],




    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'avgPrice': avgPrice,
    'sell': sell,
    'animalType': animalType,
    'buy': buy,
  };
}