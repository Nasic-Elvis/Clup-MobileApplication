import 'package:clup/utils/uri.dart';
import 'package:http/http.dart' as http;

class StoreApi {
  Future<String> getStore() async {
    Address address = new Address();
    var uri = Uri.parse(Address.getStore);
    print(uri.toString());
    var client = http.Client();
    try {
      var uriResponse = await client.get(uri);
      print(uriResponse.body);
      return uriResponse.body;
    } catch (e) {
      print(e.toString());
    }
  }
}
