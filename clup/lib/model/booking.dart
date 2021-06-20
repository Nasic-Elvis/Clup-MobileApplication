import 'package:clup/model/store.dart';

class Booking {
  final int idBooking;
  final String date;
  final String arrivalTime;
  final String day;
  final Store store;
  final int statusCode;

  Booking(this.idBooking, this.date, this.arrivalTime, this.day, this.store,
      this.statusCode);
}
