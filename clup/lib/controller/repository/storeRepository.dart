import 'dart:convert';

import 'package:clup/controller/storeController.dart';
import 'package:clup/model/store.dart';
import 'package:geolocator/geolocator.dart';

class StoreRepository {
  final StoreApi api = new StoreApi();

  Future<List<Store>> getStore() async {
    List<Store> storeList = [];
    String rawStore = await api.getStore();
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
          s['telephoneNumber']);

      storeList.add(store);

      //if (await checkPosition(store.latitude, store.longitude)) {
      //  storeList.add(store);
      // }
    }
    return storeList;
  }

  static Future<bool> checkPosition(
      double storeLatitude, double storeLongitude) async {
    var position = await Geolocator.getCurrentPosition();
    var distance = Geolocator.distanceBetween(
        position.latitude, position.longitude, storeLatitude, storeLongitude);

    if (distance > 20000) {
      return false;
    } else {
      return true;
    }
  }
}
