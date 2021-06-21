import 'model/user.dart';

class Singleton {
  Singleton._privateConstructor();

  List<int> preferences = [];
  User user;

  static final Singleton _instance = Singleton._privateConstructor();

  factory Singleton() {
    return _instance;
  }
}
