import 'dart:convert';

import 'package:clup/controller/api/storeController.dart';
import 'package:clup/model/store.dart';
import 'package:clup/model/time.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreRepository {
  final StoreApi api = new StoreApi();

  Future<List<Time>> getTime(int value) async {
    List<Time> timeList = [];
    String rawStore = await api.getTime(value);
    var storeJson = jsonDecode(rawStore);
    for (var s in storeJson) {
      Time time =
          new Time(s['idStore'], s['from'], s['to'], s['idDay'], s['day']);
      timeList.add(time);
    }

    return timeList;
  }

  Future<List<Store>> getStore() async {
    List<Store> storeList = [];
    String rawStore = await api.getStore();
    var storeJson = jsonDecode(rawStore);
    print(storeJson);
    for (var s in storeJson) {
      print(s);
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
      storeList.add(store);

      /*if (await checkPosition(store.latitude, store.longitude)) {
        storeList.add(store);
      }*/
    }
    return storeList;
  }

  Future<List<Store>> getStoreNearPosition() async {
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
          s['telephoneNumber'],
          s['category'],
          false);

      if (await checkPosition(store.latitude, store.longitude)) {
        storeList.add(store);
      }
    }
    return storeList;
  }

  Future<List<Store>> getStoreByCategory(String category) async {
    List<Store> storeList = [];
    String rawStore = await api.getStoreByCategory(category);
    var storeJson = jsonDecode(rawStore);
    if (storeJson is List) {
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

        storeList.add(store);
      }
    }
    return storeList;
  }

  Future<bool> insertFavorites(idUser, idStore) async {
    String rawResult = await api.addFavorites(idUser, idStore);
    var resultJson = jsonDecode(rawResult);
    if (resultJson.values.elementAt(0) == "OK") {
      return true;
    } else
      return false;
  }

  Future<List<Store>> storeInCity(String city) async {
    List<Store> _storeList = [];
    String rawStore = await api.storeInCity(city);
    var storeJson = jsonDecode(rawStore);
    if (storeJson is List) {
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

        _storeList.add(store);
      }
    }
    return _storeList;
  }

  Future<List<Store>> getFavorites() async {
    List<Store> storeList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int idUser = prefs.getInt("idUser");
    String rawStore = await api.getFavorites(idUser.toString());
    var storeJson = jsonDecode(rawStore);
    if (storeJson is List) {
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

        storeList.add(store);
      }
    }
    return storeList;
  }

  Future<bool> deleteFavorite(idUser, idStore) async {
    String rawResult = await api.deleteFavorite(idUser.toString(), idStore);
    var resultJson = jsonDecode(rawResult);
    if (resultJson.values.elementAt(0) == "OK") {
      return true;
    } else
      return false;
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
