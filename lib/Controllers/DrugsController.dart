import 'dart:convert';

import 'package:vetdrugegy/Models/Drugs.dart';
import 'package:vetdrugegy/Models/Mills.dart';

import 'package:vetdrugegy/Models/DrugsActiveIngredients.dart';
import 'package:vetdrugegy/Models/DrugsCategories.dart';
import 'package:vetdrugegy/Models/MillsActiveIngredients.dart';

import '../Models/Constants.dart';
import 'package:http/http.dart' as http;
class DrugsController {

Future<List<Drugs>?> GetDrugs(int category,String activeingredient,double price) async {
  final url = "${Constants.baseURL}/Drugs/GetDrugs2?divisionId="+category.toString()+"&activeIngredient="+activeingredient+"&price="+price.toString()+"&government="+UserData.government.toString();
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
    final List<Drugs> categories =
    data.map((item) => Drugs.fromJson(item)).toList();
    return categories;
    // Do something with the response
  } else {
    print("sign up Falied in Manager ${response.statusCode} ");
    //throw Exception('Failed to login');
    return null;
  }
}

Future<List<Drugs>?> GetDrugsSuggestions(int category) async {
  final url = "${Constants.baseURL}/Drugs/GetDrugsSuggestions?divisionId="+category.toString();
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
    final List<Drugs> categories =
    data.map((item) => Drugs.fromJson(item)).toList();
    return categories;
    // Do something with the response
  } else {
    print("sign up Falied in Manager ${response.statusCode} ");
    //throw Exception('Failed to login');
    return null;
  }
}

Future<List<Mills>?> GetMillsSuggestions(int category) async {
  final url = "${Constants.baseURL}/Drugs/GetMillsSuggestions?divisionId="+category.toString();
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
    final List<Mills> categories =
    data.map((item) => Mills.fromJson(item)).toList();
    return categories;
    // Do something with the response
  } else {
    print("sign up Falied in Manager ${response.statusCode} ");
    //throw Exception('Failed to login');
    return null;
  }
}


Future<List<Mills>?> GetMills(int category,String activeingredient,double price) async {
  final url = "${Constants.baseURL}/Drugs/GetMills?divisionId="+category.toString()+"&activeIngredient="+activeingredient+"&price="+price.toString();
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
    final List<Mills> categories =
    data.map((item) => Mills.fromJson(item)).toList();
    return categories;
    // Do something with the response
  } else {
    print("sign up Falied in Manager ${response.statusCode} ");
    //throw Exception('Failed to login');
    return null;
  }
}

  Future<bool> DrugDelete(int id) async {
      print( "${Constants.baseURL}/Drugs/DeleteDrug?drugId=" + id.toString());

    final response = await http.post(
      Uri.parse(
         "${Constants.baseURL}/Drugs/DeleteDrug?drugId=" + id.toString()),
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

  
  Future<bool> MillsDelete(int id) async {
      print( "${Constants.baseURL}/Drugs/DeleteMill?drugId=" + id.toString());

    final response = await http.post(
      Uri.parse(
         "${Constants.baseURL}/Drugs/DeleteMill?drugId=" + id.toString()),
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
  
Future<List<Drugs>?> GetDrugsByUserId(int categoryId,int userId) async {
  final url = "${Constants.baseURL}/Drugs/GetDrugsByUserId?categoryId="+categoryId.toString()+"&userId="+userId.toString();
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
    final List<Drugs> categories =
    data.map((item) => Drugs.fromJson(item)).toList();
    return categories;
    // Do something with the response
  } else {
    print("sign up Falied in Manager ${response.statusCode} ");
    //throw Exception('Failed to login');
    return null;
  }
}

Future<List<Mills>?> GetMillsByUserId(int categoryId,int userId) async {
  final url = "${Constants.baseURL}/Drugs/GetMillsByUserId?categoryId="+categoryId.toString()+"&userId="+userId.toString();
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
    final List<Mills> categories =
    data.map((item) => Mills.fromJson(item)).toList();
    return categories;
    // Do something with the response
  } else {
    print("sign up Falied in Manager ${response.statusCode} ");
    //throw Exception('Failed to login');
    return null;
  }
}
Future<List<DrugsActiveIngredients>?> GetActiveIngredients(int categoryId,int divisionId) async {
  final url = "${Constants.baseURL}/Drugs/GetActiveIngredients?categoryId="+categoryId.toString()+"&divisionId="+divisionId.toString();
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
    final List<DrugsActiveIngredients> categories =
    data.map((item) => DrugsActiveIngredients.fromJson(item)).toList();
    return categories;
    // Do something with the response
  } else {
    print("sign up Falied in Manager ${response.statusCode} ");
    //throw Exception('Failed to login');
    return null;
  }
}

Future<List<MillsActiveIngredient>?> GetMillsActiveIngredients(int divisionId) async {
  final url = "${Constants.baseURL}/Drugs/GetMillsActiveIngredients?divisionId="+divisionId.toString();
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
    final List<MillsActiveIngredient> categories =
    data.map((item) => MillsActiveIngredient.fromJson(item)).toList();
    return categories;
    // Do something with the response
  } else {
    print("sign up Falied in Manager ${response.statusCode} ");
    //throw Exception('Failed to login');
    return null;
  }
}

Future<List<DrugsCategories>?> GetCategoriesByParentId(int categoryId) async {
  final url = "${Constants.baseURL}/Drugs/GetCategoriesByParentId?parentId="+categoryId.toString();
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
    final List<DrugsCategories> categories =
    data.map((item) => DrugsCategories.fromJson(item)).toList();
    return categories;
    // Do something with the response
  } else {
    print("sign up Falied in Manager ${response.statusCode} ");
    //throw Exception('Failed to login');
    return null;
  }
}

Future<bool?> AddDrug(Drugs user) async {
  final url = "${Constants.baseURL}/Drugs/AddDrug";

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

Future<bool?> EditDrug(Drugs user) async {
  final url = "${Constants.baseURL}/Drugs/EditDrug";

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

Future<bool?> AddMills(Mills user) async {
  final url = "${Constants.baseURL}/Drugs/AddMill";

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

Future<bool?> EditMills(Mills user) async {
  final url = "${Constants.baseURL}/Drugs/EditMill";

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