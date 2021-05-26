import 'package:flutter/material.dart';
import 'package:clup/model/store.dart';
import 'package:clup/view/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      //appBar: CustomAppBar(rating: agrs.product.rating),
      body: Body(store: agrs.store),
    );
  }
}

class ProductDetailsArguments {
  final Store store;
  ProductDetailsArguments({@required this.store});
}