



import 'dart:convert';



import 'package:vetdrugegy/Models/Compass.dart';

import '../Models/CompassResult.dart';
import '../Models/Constants.dart';
import '../Models/User.dart';
import 'package:http/http.dart' as http;

import '../Models/UsersAnimals.dart';
class CompassController {
  Future<bool?> AddCompass(Compass compass) async {
    //todo but urls in constant
    final loginUrl =
        "${Constants
        .baseURL}Compass/AddCompass";

    print(compass.toJson());

    final response = await http.post(
      Uri.parse(loginUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(compass.toJson()),
    );
    if (response.statusCode == 200) {
      print("Adding Category Succ");
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      print("Adding Category Falied in Manager ${response.statusCode} ");
      return false;
    }
  }
  Future<List<CompassResult>?> GetCompasses(String entryDate) async {
    final url = "${Constants.baseURL}/Compass?entryDate="+entryDate;
print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print("sign up Succ in Manager");

      final List<dynamic> data = jsonDecode(response.body);
      final List<CompassResult> categories =
      data.map((item) => CompassResult.fromJson(item)).toList();
      return categories;
      // Do something with the response
    } else {
      print("sign up Falied in Manager ${response.statusCode} ");
      //throw Exception('Failed to login');
      return null;
    }
  }




}