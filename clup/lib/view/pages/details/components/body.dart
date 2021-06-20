import 'package:clup/controller/repository/storeRepository.dart';
import 'package:clup/homepage_theme.dart';
import 'package:clup/model/store.dart';
import 'package:clup/model/time.dart';
import 'package:clup/view/pages/details/components/realtime_situation.dart';
import 'package:clup/view/pages/details/components/store_time.dart';
import 'package:clup/view/pages/details/components/top_rounded_container.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../../widget/maps.dart';
import 'contact_card.dart';

StoreRepository _storeRepository = StoreRepository();
String from;
String to;
String timeOfStore;
String status;
bool bookable;
final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

Future<List<Time>> getTime(int value) async {
  List<Time> time = await _storeRepository.getTime(value);
  return time;
}

String message;
TextStyle textStyle;

class Body extends StatelessWidget {
  final Store store;

  const Body({Key key, @required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<Time>> storeTime = getTime(store.idStore);
    storeTime.whenComplete(() => print("OK"));

    storeTime.then((value) {
      var elements = value.asMap();
      int day = DateTime.now().weekday;
      from = elements[day - 1].from;
      to = elements[day - 1].to;
      timeOfStore = from.toString() + " - " + to.toString();
      if (store.booktableCapacity > 0) {
        message = store.booktableCapacity.toString() + " posti disponibili";
        textStyle =
            new TextStyle(color: Colors.green, fontWeight: FontWeight.bold);
        bookable = true;
      } else {
        message = "Non ci sono posti disponibili.";
        textStyle =
            new TextStyle(color: Colors.green, fontWeight: FontWeight.bold);
        bookable = false;
      }
    });
    return ListView(
      children: [
        TopRoundedContainer(
          color: HomepageTheme.buildLightTheme().primaryColor,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 12.0, left: 12.0),
                child: Container(
                    child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  child: Image.network(
                    store.imageUrl,
                    scale: 0.7,
                    fit: BoxFit.scaleDown,
                  ),
                )),
              ),
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
                    StoreTime(
                        title: "ORA APERTO",
                        subtitle: timeOfStore,
                        description: "Orari apertura del negozio",
                        time: storeTime),
                    ContactTime(
                        title: "Informazioni",
                        subtitle: store.telephoneNumber,
                        map: MapScreen(
                            lat: store.latitude,
                            long: store.longitude,
                            address: store.address,
                            city: store.name)),
                    RealTime(
                        title: "Ingresso in negozio",
                        subtitle: message,
                        store: store,
                        style: textStyle,
                        bookable: bookable),
                    TopRoundedContainer(
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .width * 0.15,
                            right: MediaQuery
                                .of(context)
                                .size
                                .width * 0.15,
                            bottom: (20 / 375.0) *
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                            top: (10 / 375.0) *
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width),
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
