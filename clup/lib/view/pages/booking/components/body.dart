import 'package:clup/controller/repository/storeRepository.dart';
import 'package:clup/model/store.dart';
import 'package:clup/view/pages/details/components/top_rounded_container.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

StoreRepository _storeRepository = StoreRepository();

final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

class Body extends StatelessWidget {
  final Store store;

  const Body({Key key, @required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TopRoundedContainer(
          color: Colors.greenAccent,
          child: Column(
            children: [
              Container(
                  child: Image.network(
                store.imageUrl,
                scale: 0.7,
              )),
              Center(
                child: Text("\n" + store.city + ", " + store.address + "\n",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              TopRoundedContainer(
                color: Colors.white,
                child: Column(
                  children: [
                    Divider(
                      height: 10,
                      color: Colors.transparent,
                    ),
                    TopRoundedContainer(
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.15,
                            right: MediaQuery.of(context).size.width * 0.15,
                            bottom: (20 / 375.0) *
                                MediaQuery.of(context).size.width,
                            top: (10 / 375.0) *
                                MediaQuery.of(context).size.width),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
