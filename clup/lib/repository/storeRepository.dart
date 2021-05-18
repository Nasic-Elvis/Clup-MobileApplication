import 'dart:convert';

import 'package:clup/controller/storeController.dart';
import 'package:clup/model/store.dart';

class StoreRepository {
  final StoreApi api = new StoreApi();

  Future<List<Store>> getStore() async {
    List<Store> storeList = [];
    String rawStore = await api.getStore();
    var storeJson = jsonDecode(rawStore);
    for (var s in storeJson) {
      Store store = new Store(s['idstore'], s['name'], s['capacity'],
          s['imgUrl'], s['address'], s['rating'].toDouble());
      storeList.add(store);
    }
    return storeList;
  }
}
