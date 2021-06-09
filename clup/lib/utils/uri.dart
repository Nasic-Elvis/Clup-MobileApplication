class Address {
  //URI localhost 10.0.2.2
  String _uriConnection = "10.0.2.2:3000";
  String _uriProtocol = "http://";
  static String getStore;
  static String signIn;
  static String signUp;
  static String getStoreByCategory;

  Address() {
    getStore = _uriProtocol + _uriConnection + '/getStores';
    signIn = _uriProtocol + _uriConnection + '/login';
    signUp = _uriProtocol + _uriConnection + '/signUp';
    getStoreByCategory = _uriProtocol + _uriConnection + '/storeByCategory';
  }
}
