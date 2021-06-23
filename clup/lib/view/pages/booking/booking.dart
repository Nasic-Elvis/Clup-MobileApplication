import 'package:clup/model/booking.dart';
import 'package:clup/model/store.dart';
import 'package:clup/view/pages/booking/components/dateTimePicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../homepage_theme.dart';

class BookingPage extends StatefulWidget {
  static String routeName = "/booking";

  @override
  _BookingPage createState() => _BookingPage();
}

class _BookingPage extends State<BookingPage> with TickerProviderStateMixin {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final BookingDetailsArguments agrs =
        ModalRoute.of(context).settings.arguments;
    print(agrs.booking.day);
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: HomepageTheme().primaryColor,
          title: Text(AppLocalizations.of(context).booking_title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600))),
      backgroundColor: HomepageTheme().primaryColor,
      body: DateTimePicker(agrs.store),
      //bottomNavigationBar: BottomBarDef(),
    );
  }
}

class BookingDetailsArguments {
  final Booking booking;
  final Store store;
  BookingDetailsArguments({@required this.booking, this.store});
}
