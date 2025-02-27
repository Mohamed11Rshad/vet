class User {
  late int id;
  late String name;
  late String companyName;
  late bool isActive;
  late String phone1;
  late String phone2;
  late String email;
  late String registerationDate;
  late String lastLoginDate;
  late String password;
  late int activityType;
  late num locationX;
  late num locationY;
  late String address;
  late int government;
  late String notest;
  late String nameEn;

  User({
    required this.id,
    required this.name,
    required this.companyName,
    required this.isActive,
    required this.phone1,
    required this.phone2,
    required this.email,
    required this.registerationDate,
    required this.lastLoginDate,
    required this.password,
    required this.activityType,
    required this.locationX,
    required this.locationY,
    required this.address,
    required this.government,
    required this.notest,
    required this.nameEn

  });


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      companyName: json['companyName'],
      isActive: json['isActive'],
      phone1: json['phone1'],
      phone2: json['phone2'],
      email: json['email'],
      registerationDate: json['registerationDate'],
      lastLoginDate: json['lastLoginDate'],
      password: json['password'],
      activityType: json['activityType'],
      locationX: json['locationX'],
      locationY: json['locationY'],
      address: json['address'],
      government: json['government'],
      notest:json['notest']!=null? json['notest']:"",
      nameEn:json['nameEn']!=null? json['nameEn']:"",

    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'companyName' :companyName,
    'isActive': isActive,
    'phone1': phone1,
    'phone2': phone2,
    'email': email,
    'registerationDate': registerationDate,
    'lastLoginDate': lastLoginDate,
    'password': password,
    'activityType': activityType,
    'locationX': locationX,
    'locationY': locationY,
    'address': address,
    'government': government,
    'notest': notest,
    'nameEn': nameEn,

  };
}