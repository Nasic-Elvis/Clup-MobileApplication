import 'dart:convert';

import 'package:clup/controller/authenticationController.dart';
import 'package:clup/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static Future<User> signIn(String username, String pwd) async {
    User user;
    String rawUser = await AuthApi.signIn(username, pwd);
    var userJson = jsonDecode(rawUser);
    if (userJson['result'] == 'OK') {
      user = User(
          userJson['id'],
          userJson['name'].toString(),
          userJson['surname'].toString(),
          userJson['birthdayDate'],
          userJson['telephoneNumber'].toString(),
          userJson['email'].toString(),
          userJson['username'].toString(),
          userJson['password'].toString());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', user.email.toString());
    }

    return user;
  }

  static Future<bool> signUp(String name, String surname, String email,
      String telephoneNumber, String password) async {
    bool result;
    String rawResult =
        await AuthApi.signUp(name, surname, email, telephoneNumber, password);
    var resultJson = jsonDecode(rawResult);
    if (resultJson['result'] == 'OK') {
      return true;
    } else {
      return false;
    }
  }
}
