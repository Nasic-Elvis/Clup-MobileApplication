import 'package:clup/maps.dart';
import 'package:clup/view/details/components/top_rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:clup/model/store.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../../homepage_theme.dart';
import 'button.dart';

class Body extends StatelessWidget{
  final Store store;
  const Body({Key key, @required this.store}) : super(key : key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TopRoundedContainer(
          color: Colors.transparent,
          child: Column(
            children: [
              TopRoundedContainer(
                color: Colors.transparent,
                child: Column(
                  children: [
                   Image.network(store.imageUrl),
                    Divider(height: 20,color: Colors.transparent,),
                    MapScreen(lat: store.latitude, long: store.longitude, address: store.address, city: store.name),

                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(store.address),
                    ),
                    ListTile(
                      leading: Icon(Icons.location_city),
                      title: Text(store.city),
                    ),
                    ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text(store.address),
                    ),
                    ListTile(
                      leading: Icon(Icons.reduce_capacity),
                      title: Text(store.capacity.toString() + " ticket disponibili"),
                    ),
                    TopRoundedContainer(
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.15,
                          right:  MediaQuery.of(context).size.width * 0.15,
                          bottom: (20/ 375.0)* MediaQuery.of(context).size.width,

                          top: (10/ 375.0)* MediaQuery.of(context).size.width
                        ),
                        child: DefaultButton(
                          text: "Prenotati",
                          press: () {},
                        ),
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
