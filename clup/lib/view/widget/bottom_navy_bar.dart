import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:clup/homepage_theme.dart';
import 'package:clup/view/pages/booking/booking.dart';
import 'package:clup/view/pages/home/homepage.dart';
import 'package:clup/view/pages/preferences/preferences.dart';
import 'package:clup/view/pages/settings/settings.dart';
import 'package:flutter/material.dart';

class BottomBarDef extends StatefulWidget {
  const BottomBarDef({Key key}) : super(key: key);

  @override
  _BottomBarDefState createState() => _BottomBarDefState();
}

class _BottomBarDefState extends State<BottomBarDef> {
  int _currentIndex;
  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      iconSize: 24,
      backgroundColor: HomepageTheme().primaryColor,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) {
        if (index == 0) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => HomePage()));
        }
        if (index == 1) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => Preferences()));
        }
        if (index == 2) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => BookingPage()));
        }
        if (index == 3) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => SettingScreen()));
        }
        setState(() => _currentIndex = index);
      },
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.apps),
          title: Text('Home'),
          activeColor: Colors.black,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.favorite),
          title: Text('Favorites'),
          activeColor: Colors.black,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.bookmark),
          title: Text(
            'Booking',
          ),
          activeColor: Colors.black,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings'),
          activeColor: Colors.black,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
