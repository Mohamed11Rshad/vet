import 'dart:convert';

import 'package:vetdrugegy/Models/Drugs.dart';
import 'package:vetdrugegy/Models/DrugsActiveIngredients.dart';
import 'package:vetdrugegy/Models/DrugsCategories.dart';

import '../Models/Constants.dart';
import 'package:http/http.dart' as http;

import '../Models/Jobs.dart';
class JobsController {
Future<List<Jobs>?> GetJobs(String search) async {
  final url = "${Constants.baseURL}/Jobs/GetJobs?search="+search;
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
    final List<Jobs> categories =
    data.map((item) => Jobs.fromJson(item)).toList();
    return categories;
    // Do something with the response
  } else {
    print("sign up Falied in Manager ${response.statusCode} ");
    //throw Exception('Failed to login');
    return null;
  }
}
  Future<bool> JobDelete(int id) async {
      print( "${Constants.baseURL}/Jobs/DeleteJob?jobId=" + id.toString());

    final response = await http.post(
      Uri.parse(
         "${Constants.baseURL}/Jobs/DeleteJob?jobId=" + id.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      print("Failed Deleting Drug ${response.statusCode} ");
      return false;
    }
  }
  
Future<List<Jobs>?> GetJobsByUserId(int userId) async {
  final url = "${Constants.baseURL}/Jobs/GetJobsByUserId?userId="+userId.toString();
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
    final List<Jobs> categories =
    data.map((item) => Jobs.fromJson(item)).toList();
    return categories;
    // Do something with the response
  } else {
    print("sign up Falied in Manager ${response.statusCode} ");
    //throw Exception('Failed to login');
    return null;
  }
}

Future<bool?> AddJob(Jobs user) async {
  final url = "${Constants.baseURL}/Jobs/AddJob";

  print(jsonEncode(user.toJson()));
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(user.toJson()),
  );

  if (response.statusCode == 200) {
    print("sign up Succ in Manager");

    print(user.toJson());
    return true;
    // Do something with the response
  } else {
    print("sign up Falied in Manager ${response.statusCode} ");
    //throw Exception('Failed to login');
    return false;
  }
}


Future<bool?> EditJob(Jobs user) async {
  final url = "${Constants.baseURL}/Jobs/EditJob";

  print(jsonEncode(user.toJson()));
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(user.toJson()),
  );

  if (response.statusCode == 200) {
    print("sign up Succ in Manager");

    print(user.toJson());
    return true;
    // Do something with the response
  } else {
    print("sign up Falied in Manager ${response.statusCode} ");
    //throw Exception('Failed to login');
    return false;
  }
}
}