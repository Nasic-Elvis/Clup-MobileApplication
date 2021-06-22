import 'package:clup/controller/repository/storeRepository.dart';
import 'package:clup/model/store.dart';
import 'package:flutter/cupertino.dart';

abstract class CategoryState {}

//TODO

class InitialState extends CategoryState {}

class NearStoreState extends CategoryState {
  final List<Store> stores;

  NearStoreState({@required this.stores});
}

class NoCategoryState extends CategoryState {
  final List<Store> stores;

  NoCategoryState({@required this.stores});
}

class SupermarketState extends CategoryState {
  final List<Store> stores;

  SupermarketState({@required this.stores});
}

class HealtCareState extends CategoryState {
  final List<Store> stores;

  HealtCareState({@required this.stores});
}

class ServicesState extends CategoryState {
  final List<Store> stores;

  ServicesState({@required this.stores});
}

class OtherActivityState extends CategoryState {
  final List<Store> stores;

  OtherActivityState({@required this.stores});
}

class CityState extends CategoryState {
  final List<Store> stores;

  CityState({@required this.stores});
}
