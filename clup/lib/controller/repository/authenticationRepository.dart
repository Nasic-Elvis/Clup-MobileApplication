import 'dart:convert';

import 'package:clup/controller/api/authenticationController.dart';
import 'package:clup/model/user.dart';
import 'package:clup/utils/singletonPreferences.dart';
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
      prefs.setString('password', user.password.toString());
      prefs.setString('email', user.email.toString());
      prefs.setString('name', user.name.toString());
      prefs.setString('surname', user.surname.toString());
      prefs.setInt('idUser', user.idUser);
      prefs.setString('birthdayDate', user.birthdayDate.toString());
      prefs.setString('telephoneNumber', user.telephoneNumber.toString());
      prefs.setBool('login', true);
      Singleton singleton = Singleton();
      singleton.user = User(
          user.idUser,
          user.name,
          user.surname,
          user.birthdayDate,
          user.telephoneNumber,
          user.email,
          user.username,
          user.password);
    }

    return user;
  }

  static Future<bool> forgotPassword(
      String username, String password, String confirmedPassword) async {
    String rawResult =
        await AuthApi.forgotPassword(username, password, confirmedPassword);
    var resultJson = jsonDecode(rawResult);
    if (resultJson['result'] == 'OK') {
      return true;
    } else {
      return false;
    }
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
