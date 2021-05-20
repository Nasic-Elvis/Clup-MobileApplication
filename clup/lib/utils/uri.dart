class Address {
  String _uriConnection = "10.0.2.2:3000";
  String _uriProtocol = "http://";
  static String getStore;

  Address() {
    getStore = _uriProtocol + _uriConnection + '/getStores';
  }
}
