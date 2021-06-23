import 'package:clup/model/booking.dart';
import 'package:clup/model/store.dart';
import 'package:clup/view/pages/booking/components/dateTimePicker.dart';
import 'package:clup/view/pages/details/components/app_bar.dart';
import 'package:clup/view/pages/details/components/body.dart';
import 'package:clup/view/widget/bottomBar.dart';
import 'package:clup/view/widget/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
        backgroundColor: Colors.white,
        appBar: CustomAppBar(name: AppLocalizations.of(context).booking_title),
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
