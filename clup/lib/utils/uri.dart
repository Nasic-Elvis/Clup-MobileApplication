class Address {
  String _uriConnection = "192.168.1.6:3000";
  String _uriProtocol = "http://";
  static String getStore;

  Address() {
    getStore = _uriProtocol + _uriConnection + '/getStores';
  }
}
