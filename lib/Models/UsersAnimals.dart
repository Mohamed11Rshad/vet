class UsersAnimals {
  int? id;
  int? animalType;
  int? userId;

  UsersAnimals({
     this.id,
     this.animalType,
     this.userId,

  });


  factory UsersAnimals.fromJson(Map<String, dynamic> json) {
    return UsersAnimals(
      id: json['id'],
      animalType: json['animalType'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'animalType': animalType,
    'userId': userId,
  };
}


class Animals {
  int? index;
  String? name;
  Animals({
    this.index,
    this.name,
  });
}