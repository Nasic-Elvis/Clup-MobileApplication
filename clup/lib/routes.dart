
import 'package:clup/view/details/details_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:clup/view/home/homepage.dart';


final Map<String, WidgetBuilder> routes = {
  HomePage.routeName: (context) => HomePage(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
};