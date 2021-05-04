import 'package:flutter/widgets.dart';

import '../home_screen.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
  });

  Widget navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
      navigateScreen: MyHomePage(),
    ),
  ];
}
