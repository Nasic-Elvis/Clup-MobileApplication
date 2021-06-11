import 'package:clup/model/store.dart';

class Booking {
  final String arrivalTime;
  final String day;
  final Store store;
  final int statusCode;

  Booking(this.arrivalTime, this.day, this.store, this.statusCode);
}
