import 'package:clup/model/booking.dart';
import 'package:clup/model/store.dart';
import 'package:clup/view/pages/booking/booking.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clup/utils/values.dart' as Values;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../settings/components/signin.dart';
import 'button.dart';

final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

class RealTime extends PreferredSize {
  final String title;
  final String subtitle;
  final Store store;
  final TextStyle style;
  final bool bookable;

  RealTime(
      {@required this.title,
      this.subtitle,
      this.store,
      this.style,
      this.bookable});

  String message;

  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
        child: ExpansionTileCard(
          baseColor: Colors.grey[50],
          expandedColor: Colors.grey[50],
          initiallyExpanded: true,
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
              style: this.style,
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
                        text:
                        AppLocalizations.of(context).details_realtime_card_btn_text,
                        press: () async {
                          if (bookable) {
                            SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            int idUser = prefs.getInt(Values.Strings.sharedPreferences_idUser);
                            print(idUser);
                            if (idUser == null || idUser <= 0) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => SignInScreen(),
                              ));
                            } else {
                              Booking booking = new Booking(
                                  null, null, null, null, store, null);
                              Navigator.pushNamed(
                                context,
                                BookingPage.routeName,
                                arguments: BookingDetailsArguments(
                                    booking: booking, store: store),
                              );
                            }
                          }
                          else {
                            Fluttertoast.showToast(
                                msg:
                                AppLocalizations.of(context).details_body_full,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.SNACKBAR,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);
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