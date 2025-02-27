import 'dart:ui';

import 'UsersAnimals.dart';

class Constants {
  // static const baseURL="http://mohagado-001-site5.itempurl.com/";
  static const baseURL = "https://backend.vetdrugegy.com/";

  static var animals = <Animals>[
    new Animals(index: 0, name: "تسمين أبيض"),
    new Animals(index: 1, name: "تسمين ساسو"),
    new Animals(index: 2, name: "تسمين بط"),
    new Animals(index: 3, name: "نعام"),
    new Animals(index: 4, name: "بياض أبيض"),
    new Animals(index: 5, name: "بياض أحمر"),
    new Animals(index: 6, name: "أمهات أبيض"),
    new Animals(index: 7, name: "أمهات ساسو"),
    new Animals(index: 8, name: "بلدي دواجن"),
    new Animals(index: 9, name: "أمهات بلدي"),
    new Animals(index: 10, name: "أمهات بياض"),
    new Animals(index: 11, name: "جدود الدواجن"),
    new Animals(index: 12, name: "أمهات بط"),
    new Animals(index: 13, name: "تسمين دورزي"),
    new Animals(index: 14, name: "أرانب"),
    new Animals(index: 15, name: "حمام"),
    new Animals(index: 16, name: "سمان"),
    new Animals(index: 17, name: "أسماك"),
    new Animals(index: 18, name: "مجترة"),
    new Animals(index: 19, name: "أليفة"),
    new Animals(index: 20, name: "كتكوت أبيض تسمين"),
    new Animals(index: 21, name: "كتكوت ساسو"),
    new Animals(index: 22, name: "كتكوت بلدي حر"),
    new Animals(index: 23, name: "بيض مائدة أبيض"),
    new Animals(index: 24, name: "بيض مائدة أحمر"),
    new Animals(index: 25, name: "بيض مائدة بلدي"),
    new Animals(index: 26, name: "بيض تفريخ تسمين أبيض"),
    new Animals(index: 27, name: "بيض تفريخ ساسو"),
    new Animals(index: 28, name: "بيض تفريخ بلدي")
  ];
  static var animalsEn = <Animals>[
    new Animals(index: 0, name: "White Broiler"),
    new Animals(index: 1, name: "Saso Brolier"),
    new Animals(index: 2, name: "Duck"),
    new Animals(index: 3, name: "Ostriches"),
    new Animals(index: 4, name: "Laying White Hens"),
    new Animals(index: 5, name: "Laying Red Hens"),
    new Animals(index: 6, name: "White Breeder"),
    new Animals(index: 7, name: "Saso Breeder"),
    new Animals(index: 8, name: "Native Brolier"),
    new Animals(index: 9, name: "Native Breeder"),
    new Animals(index: 10, name: "Laying Breeder"),
    new Animals(index: 11, name: "Grand Parents"),
    new Animals(index: 12, name: "Duck Breeder"),
    new Animals(index: 13, name: "Dorzi"),
    new Animals(index: 14, name: "Rabbits"),
    new Animals(index: 15, name: "Pigeons"),
    new Animals(index: 16, name: "Quails"),
    new Animals(index: 17, name: "Fish"),
    new Animals(index: 18, name: "Large"),
    new Animals(index: 19, name: "Pets"),
    new Animals(index: 20, name: "Brolier White Chicken"),
    new Animals(index: 21, name: "Saso Chicken"),
    new Animals(index: 22, name: "Native Chicken"),
    new Animals(index: 23, name: "Commercial White Egg"),
    new Animals(index: 24, name: "Commercial Red Egg"),
    new Animals(index: 25, name: "Commercial Native Egg"),
    new Animals(index: 26, name: "Fertile Broiler Egg"),
    new Animals(index: 27, name: "Fertile Saso Egg"),
    new Animals(index: 28, name: "Fertile Native Egg")
  ];
}

class appDesign {
  static const colorPrimary = Color(0xff00b6b7);
  static const colorPrimaryDark = Color(0xff2D4649);
  static const colorPrimaryLight = Color(0xffb7dde0);
  static const colorAccent = Color(0xfff6f6f6);
  static const backGround = Color(0xffeefafa);
}

class ConstantImages {
  static const baseURL = "https://backend.vetdrugegy.com/";
  static const imgDrugs = "imgDrugs/";
  static const attchDrugs = "attchDrugs/";
  static const imgMills = "imgMills/";
  static const attchMills = "attchMills/";
}

class UserData {
  static int userId = 0;
  static int government = 0;
  static String userName = "";
  static String language = "en";
}

class StaticFuncs {
  static String replaceArabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    print("$input");
    return input;
  }
}
