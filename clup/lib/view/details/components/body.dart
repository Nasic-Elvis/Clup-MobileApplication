import 'package:clup/maps.dart';
import 'package:clup/view/details/components/realtime_situation.dart';
import 'package:clup/view/details/components/store_time.dart';
import 'package:clup/view/details/components/top_rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:clup/model/store.dart';
import 'package:flutter/painting.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

import '../../../homepage_theme.dart';
import 'button.dart';
import 'contact_card.dart';
final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

class Body extends StatelessWidget{
  final Store store;
  const Body({Key key, @required this.store}) : super(key : key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TopRoundedContainer(
          color: Colors.greenAccent,
          child: Column(
            children: [
          Container(child:Image.network(store.imageUrl, scale: 0.7,)),
              Center(
                child: Text(
                  "\n" + store.city + ", " + store.address + "\n",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                ),
              ),
              TopRoundedContainer(
                color: Colors.white,
                child: Column(
                  children: [
                    Divider(height: 10,color: Colors.transparent,),
                    StoreTime(title: "ORA APERTO", subtitle: "9:00 - 13:30", description: "Orari apertura del negozio"),
                    ContactTime(title: "Informazioni", subtitle: store.telephoneNumber, map: MapScreen(lat: store.latitude, long: store.longitude, address: store.address, city: store.name)),
                    RealTime(title: "Ingresso in negozio", subtitle: this.store.booktableCapacity.toString() + " posti disponibili"),

                    //TopRoundedContainer(
                     // color: Colors.transparent,
                // child: Padding(
                  //  padding: EdgeInsets.only(
                  //    left: MediaQuery.of(context).size.width * 0.15,
                  //    right:  MediaQuery.of(context).size.width * 0.15,
                  //   bottom: (20/ 375.0)* MediaQuery.of(context).size.width,

                //   top: (10/ 375.0)* MediaQuery.of(context).size.width
                //  ),
                //  child: DefaultButton(
                //    text: "Prenotati",
                //   press: () {},
                // ),
                // ),
                    // ),
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
