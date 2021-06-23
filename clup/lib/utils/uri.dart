class Address {
  //URI localhost 10.0.2.2
  String _uriConnection = "10.0.2.2:3000";
  String _uriProtocol = "http://";
  static String getStore;
  static String signIn;
  static String signUp;
  static String getTime;
  static String booking;
  static String getFavorites;
  static String insertFavorites;
  static String deleteFavorite;
  static String getStoreByCategory;
  static String getBookings;
  static String deleteBooking;
  static String storeInCity;
  String getUserInformation;
  static String forgotPassword;

  Address() {
    getStore = _uriProtocol + _uriConnection + '/getStores';
    signIn = _uriProtocol + _uriConnection + '/login';
    signUp = _uriProtocol + _uriConnection + '/signUp';
    getStoreByCategory = _uriProtocol + _uriConnection + '/storeByCategory';
    getTime = _uriProtocol + _uriConnection + '/getTime';
    booking = _uriProtocol + _uriConnection + '/booking';
    getFavorites = _uriProtocol + _uriConnection + '/getFavorites';
    insertFavorites = _uriProtocol + _uriConnection + '/insertFavorites';
    deleteFavorite = _uriProtocol + _uriConnection + '/deleteFavorite';
    getBookings = _uriProtocol + _uriConnection + '/getBookings';
    deleteBooking = _uriProtocol + _uriConnection + '/deleteBookings';
    storeInCity = _uriProtocol + _uriConnection + '/storeInCity';
    getUserInformation = _uriProtocol + _uriConnection + '/getUserInformation';
    forgotPassword = _uriProtocol + _uriConnection + '/forgotPassword';
  }
}
