import 'package:clup/utils/uri.dart';
import 'package:http/http.dart' as http;

class BookingApi {
  Address address = new Address();

  Future<String> getBookings(int idUser) async {
    var uri = Uri.parse(Address.getBookings);
    print(uri.toString());
    var client = http.Client();
    try {
      print(idUser);
      var uriResponse =
          await client.post(uri, body: {'idUser': idUser.toString()});
      print(uriResponse.body);
      return uriResponse.body;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<int> deleteBooking(int idBooking) async {
    var uri = Uri.parse(Address.deleteBooking);
    print(uri.toString());
    var client = http.Client();
    try {
      var uriResponse =
          await client.post(uri, body: {"idBooking": idBooking.toString()});
      print(uriResponse.body);
      return uriResponse.statusCode;
    } catch (e) {
      print(e.toString());
    }
  }
}
