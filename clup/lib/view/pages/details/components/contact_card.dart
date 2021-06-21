import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widget/maps.dart';
final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

class ContactTime extends PreferredSize {
  final String title;
  final String subtitle;
  final MapScreen map;

  ContactTime({@required this.title, this.subtitle, this.map});

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
              Icons.phone,
              color: Colors.grey,
            ),
            title: Text(
              this.subtitle.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.black),
            ),
            onLongPress: () => launch("tel://" + this.subtitle.toString()),
          ),
          //Text(this.subtitle, style: TextStyle(fontWeight:  FontWeight.bold, fontSize: 16, color: Colors.black),),
          children: <Widget>[
            Divider(
              thickness: 1.0,
              height: 1.0,
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
                      Text(
                        AppLocalizations.of(context).indicazioniStradali,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                      this.map,
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
