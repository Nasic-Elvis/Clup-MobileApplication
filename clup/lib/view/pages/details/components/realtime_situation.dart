import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../settings/components/signin.dart';
import 'button.dart';

final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

class RealTime extends PreferredSize {
  final String title;
  final String subtitle;

  RealTime({@required this.title, this.subtitle});

  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
        child: ExpansionTileCard(
          baseColor: Colors.grey[50],
          expandedColor: Colors.grey[50],
          key: cardA,
          //leading: CircleAvatar(
          //   child:),
          title: Text(
            this.title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
          ),
          subtitle: ListTile(
            leading: Icon(
              Icons.reduce_capacity,
              color: Colors.grey,
            ),
            title: Text(
              this.subtitle.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.black),
            ),
          ),
          children: <Widget>[
            Divider(
              thickness: 1.0,
              height: 2.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    children: [
                      DefaultButton(
                        text: "Prenotati",
                        press: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          if (prefs.containsKey('email')) {
                            print("PRENOTAZIONE OK");
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => SignInScreen(),
                            ));
                          }
                        },
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}