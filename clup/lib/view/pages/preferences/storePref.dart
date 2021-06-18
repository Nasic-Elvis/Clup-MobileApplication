import 'package:clup/homepage_theme.dart';
import 'package:clup/model/store.dart';
import 'package:clup/view/pages/preferences/storeList.dart';
import 'package:flutter/material.dart';

class StoresPrefList extends StatelessWidget {
  final List<Store> store;
  final AnimationController animationController;
  const StoresPrefList(
      {Key key, @required this.store, @required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: HomepageTheme.buildLightTheme().backgroundColor,
        child: ListView.builder(
          itemCount: store.length,
          padding: const EdgeInsets.only(top: 8),
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            final int count = store.length > 10 ? 10 : store.length;
            final Animation<double> animation =
                Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                    parent: animationController,
                    curve: Interval((1 / count) * index, 1.0,
                        curve: Curves.fastOutSlowIn)));
            animationController.forward();
            return StoreFavoriteView(
              callback: () {},
              store: store.elementAt(index),
              animation: animation,
              animationController: animationController,
            );
          },
        ));
  }
}
