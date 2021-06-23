import 'dart:convert';

import 'package:clup/controller/api/userController.dart';
import 'package:clup/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  UserApi _api = UserApi();

  Future<User> getUserInformation() async {
    User user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int idUser = prefs.getInt("idUser");
    String rawUser = await _api.getUserInformation(idUser);
    var jsonUser = jsonDecode(rawUser);
    print(jsonUser);
    for (var s in jsonUser) {
      print(s);
      user = User(
          s["idUser"],
          s["Name"].toString(),
          s["Surname"].toString(),
          s["BirthdayDate"].toString(),
          s["TelephoneNumber"].toString(),
          s["Email"].toString(),
          s["Username"].toString(),
          s["Password"].toString());
    }
    return user;
  }
}
