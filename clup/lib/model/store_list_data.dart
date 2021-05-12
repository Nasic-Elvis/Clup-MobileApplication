class StoreListData {
  StoreListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.availability = 180,
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  double dist;
  double rating;
  int reviews;
  int availability;

  static List<StoreListData> hotelList = <StoreListData>[
    StoreListData(
      imagePath: 'assets/store/foto1.png',
      titleTxt: 'Eataly',
      subTxt: 'Stradine Farnese, Piacenza',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      availability: 40,
    ),
    StoreListData(
      imagePath: 'assets/store/foto2.png',
      titleTxt: 'Esselunga',
      subTxt: 'Via Conciliazione, Piacenza',
      dist: 4.0,
      reviews: 74,
      rating: 4.5,
      availability: 120,
    ),
    StoreListData(
      imagePath: 'assets/store/foto3.png',
      titleTxt: 'Ufficio Postale',
      subTxt: 'Via Trivioli, Piacenza',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      availability: 90,

    ),
    StoreListData(
      imagePath: 'assets/store/foto4.png',
      titleTxt: 'Banca di Piacenza',
      subTxt: 'Piazza Cavalli, Piacenza',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      availability: 12,

    ),
    StoreListData(
      imagePath: 'assets/store/foto5.png',
      titleTxt: 'Università Cattolica del Sacro Cuore',
      subTxt: 'Via Emilia Parmense, 84, Piacenza',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      availability: 30,

    ),
  ];
}
