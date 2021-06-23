import 'package:clup/model/store.dart';
import 'package:clup/view/pages/details/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../homepage_theme.dart';

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";

  @override
  _DetailsScreen createState() => _DetailsScreen();
}

class _DetailsScreen extends State<DetailsScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: HomepageTheme().primaryColor,
          title: Text(AppLocalizations.of(context).details_home,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600))),
      backgroundColor: HomepageTheme().primaryColor,
      body: Body(store: agrs.store),
    );
  }
}


class ProductDetailsArguments {
  final Store store;
  ProductDetailsArguments({@required this.store});
}