import 'package:flutter/material.dart';
import 'package:clup/model/store.dart';
import 'package:clup/view/details/components/body.dart';

import 'components/app_bar.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

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