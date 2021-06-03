import 'package:clup/model/store.dart';
import 'package:clup/view/pages/details/components/body.dart';
import 'package:flutter/material.dart';

import 'components/app_bar.dart';

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
      backgroundColor: Colors.white,
      appBar: CustomAppBar(rating: agrs.store.rating),
      body: Body(store: agrs.store),
    );
  }
}


class ProductDetailsArguments {
  final Store store;
  ProductDetailsArguments({@required this.store});
}