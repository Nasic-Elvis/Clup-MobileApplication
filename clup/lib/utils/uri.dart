class Address {
  //URI localhost 10.0.2.2
  String _uriConnection = "192.168.1.6:3000";
  String _uriProtocol = "http://";
  static String getStore;
  static String signIn;
  static String signUp;

  Address() {
    getStore = _uriProtocol + _uriConnection + '/getStores';
    signIn = _uriProtocol + _uriConnection + '/login';
    signUp = _uriProtocol + _uriConnection + '/signUp';
  }
}
