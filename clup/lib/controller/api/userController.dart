import 'package:clup/utils/uri.dart';
import 'package:http/http.dart' as http;

class UserApi {
  Address _address = Address();
  Future<String> getUserInformation(int idUser) async {
    var uri = Uri.parse(_address.getUserInformation);
    print(uri.toString());
    var client = http.Client();
    try {
      var uriResponse =
          await client.post(uri, body: {"idUser": idUser.toString()});
      print(uriResponse.body);
      return uriResponse.body;
    } catch (e) {
      print(e.toString());
    }
  }
}
