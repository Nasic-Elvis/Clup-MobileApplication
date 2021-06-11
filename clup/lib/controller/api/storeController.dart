import 'package:clup/utils/uri.dart';
import 'package:http/http.dart' as http;

class StoreApi {
  Address address = new Address();
  Future<String> getStore() async {
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

  Future<int> booking(
      String date, String time, String idUser, int idStore) async {
    var uri = Uri.parse(Address.booking);
    print(uri.toString());
    print(date.toString());
    print(time.toString());
    print(idStore.toString());
    print(idUser.toString());

    var client = http.Client();
    try {
      var uriResponse = await client.post(uri, body: {
        'idStore': idStore.toString(),
        'idUser': idUser.toString(),
        'date': date.toString(),
        'time': time.toString()
      });
      print(uriResponse.statusCode);
      return uriResponse.statusCode;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> getTime(int value) async {
    var uri = Uri.parse(Address.getTime);
    print(uri);
    print(value);
    print(uri.toString());
    var client = http.Client();
    try {
      var uriResponse = await client.post(
        uri, body: {'idStore': value.toString()},);
      print(uriResponse.body);
      return uriResponse.body;
    } catch (e) {
      print(e.toString());
    }
  }


  Future<String> getStoreByCategory(String category) async {
    var uri = Uri.parse(Address.getStoreByCategory);
    print(uri.toString());
    var client = http.Client();
    try {
      var uriResponse = await client.post(uri, body: {"category": category});
      print(uriResponse.body);
      return uriResponse.body;
    } catch (e) {
      print(e.toString());
    }
  }
}
