import 'package:clup/view/pages/booking/booking.dart';
import 'package:clup/view/pages/details/details_screen.dart';
import 'package:clup/view/pages/home/homepage.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  HomePage.routeName: (context) => HomePage(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  BookingPage.routeName: (context) => BookingPage(),
};
