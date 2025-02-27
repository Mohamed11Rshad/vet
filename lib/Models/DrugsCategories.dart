class DrugsCategories {
  late int id;
  late String name;
  late String nameEn;
  late int parentId;

  DrugsCategories({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.parentId,
  });


  factory DrugsCategories.fromJson(Map<String, dynamic> json) {
    return DrugsCategories(
      id: json['id'],
      name: json['name'],
      nameEn: json['nameEn'],
      parentId: json['parentId'],

    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'nameEn' :nameEn,
    'parentId': parentId,
  };
}