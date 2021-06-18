class Singleton {
  Singleton._privateConstructor();

  List<int> preferences = [];

  static final Singleton _instance = Singleton._privateConstructor();

  factory Singleton() {
    return _instance;
  }
}
