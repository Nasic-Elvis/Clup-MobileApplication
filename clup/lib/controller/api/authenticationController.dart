import 'package:clup/utils/uri.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  Address address = new Address();
  static Future<String> signIn(String username, String pwd) async {
    var uri = Uri.parse(Address.signIn);
    print(uri.toString());
    var client = http.Client();
    try {
      var uriResponse =
          await client.post(uri, body: {'username': username, 'password': pwd});
      print(uriResponse.body);
      return uriResponse.body;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<String> signUp(String name, String surname, String email,
      String telephoneNumber, String password) async {
    var uri = Uri.parse(Address.signUp);
    print(uri.toString());
    var client = http.Client();
    try {
      var uriResponse = await client.post(uri, body: {
        'name': name,
        'surname': surname,
        'email': email,
        'telephoneNumber': telephoneNumber,
        'password': password
      });
      print(uriResponse.body);
      return uriResponse.body;
    } catch (e) {
      print(e.toString());
    }
  }
}
