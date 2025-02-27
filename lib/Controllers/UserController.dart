



import 'dart:convert';



import 'package:vetdrugegy/Models/Podcasts.dart';

import '../Models/Constants.dart';
import '../Models/User.dart';
import 'package:http/http.dart' as http;

import '../Models/UsersAnimals.dart';
class UserController {
  Future<User?> Login(String email, String? password) async {
    //todo but urls in constant
    final loginUrl =
        "${Constants
        .baseURL}/User/LoginByUserPasswordGet?username=$email&password=$password";

    print(loginUrl);

    final response = await http.get(
        Uri.parse(loginUrl), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      print("Login Succ in Manager");

      final jsonResponse = jsonDecode(response.body);
      //print(jsonResponse);
      User user = User.fromJson(jsonResponse);
      //print(user.name);
      return user;
      // Do something with the response
    } else {
      print("Login Falied in Manager ${response.statusCode} ");
      //throw Exception('Failed to login');
      return null;
    }
  }


 Future<User?> GetUserById() async {
    //todo but urls in constant
    final loginUrl =
        "${Constants
        .baseURL}/User/LoginById?userId=${UserData.userId}";

    print(loginUrl);

    final response = await http.get(
        Uri.parse(loginUrl), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      print("Login Succ in Manager");

      final jsonResponse = jsonDecode(response.body);
      //print(jsonResponse);
      User user = User.fromJson(jsonResponse);
      //print(user.name);
      return user;
      // Do something with the response
    } else {
      print("Login Falied in Manager ${response.statusCode} ");
      //throw Exception('Failed to login');
      return null;
    }
  }
Future<bool?> UpdatePassword(String phone, String? password) async {
    //todo but urls in constant
    final loginUrl =
        "${Constants
        .baseURL}/User/UpdatePassword?phone=$phone&password=$password";

    print(loginUrl);

    final response = await http.get(
        Uri.parse(loginUrl), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      print("Login Succ in Manager");

     
      //print(user.name);
      return true;
      // Do something with the response
    } else {
      print("Login Falied in Manager ${response.statusCode} ");
      //throw Exception('Failed to login');
      return false;
    }
  }

    Future<bool> SendSMS(String phone, String randomNumber) async {
    //todo but urls in constant
    final loginUrl =
        "https://smssmartegypt.com/sms/api/?username=Adlink9273&password=l5C9J3Lx&sendername=Adlinkgroup&mobiles=$phone&message=$randomNumber";

    print(loginUrl);

    final response = await http.get(
        Uri.parse(loginUrl), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      print("Login Succ in Manager");
return true;
      // Do something with the response
    } else {
      print("Login Falied in Manager ${response.statusCode} ");
      //throw Exception('Failed to login');
      return false;
    }
  }


  Future<User?> SignUp(User user,List<UsersAnimals> usersanimals) async {
    final url = "${Constants.baseURL}/User/AddUser";

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

      final jsonResponse = jsonDecode(response.body);
      //print(jsonResponse);
      User user = User.fromJson(jsonResponse);

      for(int i=0;i<usersanimals.length;i++){
usersanimals[i].userId=user.id;
AddUserAnimal(usersanimals[i]);
      }

      return user;
      // Do something with the response
    } else {
      print("sign up Falied in Manager ${response.statusCode} ");
      //throw Exception('Failed to login');
      return null;
    }
  }


Future<User?> UpdateUser(User user,List<UsersAnimals> usersanimals) async {
    final url = "${Constants.baseURL}/User/EditUser";

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

      final jsonResponse = jsonDecode(response.body);
      //print(jsonResponse);
      User user = User.fromJson(jsonResponse);
DeleteUserAnimal();
      for(int i=0;i<usersanimals.length;i++){
usersanimals[i].userId=user.id;
AddUserAnimal(usersanimals[i]);
      }

      return user;
      // Do something with the response
    } else {
      print("sign up Falied in Manager ${response.statusCode} ");
      //throw Exception('Failed to login');
      return null;
    }
  }

 Future<bool> DeleteUserAnimal() async {
      print( "${Constants.baseURL}/User/DeleteUserAnimal?userId=" + UserData.userId.toString());

    final response = await http.post(
      Uri.parse(
         "${Constants.baseURL}/User/DeleteUserAnimal?userId=" + UserData.userId.toString()),
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


  
  Future<bool> UserDelete(int id) async {
      print( "${Constants.baseURL}/User/DeleteUser?userId=" + id.toString());

    final response = await http.post(
      Uri.parse(
         "${Constants.baseURL}/User/DeleteUser?userId=" + id.toString()),
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

  Future<UsersAnimals?> AddUserAnimal(UsersAnimals user) async {
    final url = "${Constants.baseURL}/User/AddUserAnimal";

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
      return user;
      // Do something with the response
    } else {
      print("sign up Falied in Manager ${response.statusCode} ");
      //throw Exception('Failed to login');
      return null;
    }
  }


  Future<List<UsersAnimals>?> GetAnimalsByUser(int userId) async {
    final url = "${Constants.baseURL}/User/GetAnimalsByUser?userId="+userId.toString();

    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print("sign up Succ in Manager");

      final List<dynamic> data = jsonDecode(response.body);
      final List<UsersAnimals> categories =
      data.map((item) => UsersAnimals.fromJson(item)).toList();
      return categories;
      // Do something with the response
    } else {
      print("sign up Falied in Manager ${response.statusCode} ");
      //throw Exception('Failed to login');
      return null;
    }
  }


  Future<List<Podcasts>?> GetPodcasts() async {
    final url = "${Constants.baseURL}/User/GetPodcasts?userId=1";

    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print("sign up Succ in Manager");

      final List<dynamic> data = jsonDecode(response.body);
      final List<Podcasts> categories =
      data.map((item) => Podcasts.fromJson(item)).toList();
      return categories;
      // Do something with the response
    } else {
      print("sign up Falied in Manager ${response.statusCode} ");
      //throw Exception('Failed to login');
      return null;
    }
  }
Future<List<User>?> GetUsersSearch(int jobType ,int government,String searchText ) async {
    final url = "${Constants.baseURL}/User/GetUsersSearch?jobType="+jobType.toString()+"&government="+government.toString()+"&name="+searchText;
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
      final List<User> categories =
      data.map((item) => User.fromJson(item)).toList();
      return categories;
      // Do something with the response
    } else {
      print("sign up Falied in Manager ${response.statusCode} ");
      //throw Exception('Failed to login');
      return null;
    }
  }

}