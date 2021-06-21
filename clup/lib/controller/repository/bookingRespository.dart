import 'dart:convert';

import 'package:clup/controller/api/bookingController.dart';
import 'package:clup/model/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/booking.dart';

BookingApi api = new BookingApi();

class bookingRespository {
  Future<List<Booking>> getBookings() async {
    List<Booking> bookingList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int idUser = prefs.getInt("idUser");
    String rawStore = await api.getBookings(idUser);
    var storeJson = jsonDecode(rawStore);
    for (var s in storeJson) {
      Store store = new Store(
          s['idstore'],
          s['name'],
          s['city'],
          s['bookableCapacity'],
          s['capacity'],
          s['imgUrl'],
          s['iconUrl'],
          s['address'],
          s['rating'].toDouble(),
          s['latitude'].toDouble(),
          s['longitude'].toDouble(),
          true,
          s['telephoneNumber'],
          s['category'],
          false);
      Booking booking = new Booking(
        s['idBooking'],
        s['bookingDate'],
        s['ArrivalTime'],
        null,
        store,
        null,
      );
      bookingList.add(booking);
    }
    return bookingList;
  }
}
