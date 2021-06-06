import 'dart:ui';

import 'package:clup/homepage_theme.dart';
import 'package:clup/main.dart';
import 'package:clup/utils/values.dart' as Values;
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  static String routeName = "/home";

  @override
  _BottomNavigation createState() => _BottomNavigation();
}

class _BottomNavigation extends State<BottomNavigation>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      Values.Strings.index0,
      style: optionStyle,
    ),
    Text(
      Values.Strings.index1,
      style: optionStyle,
    ),
    Text(
      Values.Strings.index2,
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ThemeData _themeData = HomepageTheme.buildLightTheme();
  Color _hexColor = HexColor('#337CA0');
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: Container(
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: Values.Strings.exploreLabel,
                backgroundColor: Color(0xFF54D3C2),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: Values.Strings.preferedLabel,
                  backgroundColor: Color(0xFF54D3C2)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark),
                  label: Values.Strings.bookingsLabel,
                  backgroundColor: Color(0xFF54D3C2)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: Values.Strings.settingsLabel,
                  backgroundColor: Color(0x54D3C2)),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
