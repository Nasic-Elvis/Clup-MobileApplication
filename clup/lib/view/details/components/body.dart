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
              Text(
                "Dettagli negozio",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              TopRoundedContainer(
                color: Colors.transparent,
                child: Column(
                  children: [
                   Image.network(store.imageUrl),
                    Text(
                      "\n" + store.address + "\n",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      "Valutazione utenti",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SmoothStarRating(
                      allowHalfRating: true,
                      starCount: 5,
                      rating: store.rating,
                      size: 20,
                      color: HomepageTheme
                          .buildLightTheme()
                          .primaryColor,
                      borderColor: HomepageTheme
                          .buildLightTheme()
                          .primaryColor,
                    ),
                    Text(
                      "\nPosti disponibili:\t" + store.capacity.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    TopRoundedContainer(
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.15,
                          right:  MediaQuery.of(context).size.width * 0.15,
                          bottom: (20/ 375.0)* MediaQuery.of(context).size.width,

                          top: (100/ 375.0)* MediaQuery.of(context).size.width
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
