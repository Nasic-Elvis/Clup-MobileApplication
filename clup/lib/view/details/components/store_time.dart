import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

class StoreTime extends PreferredSize {
  final String title;
  final String subtitle;
  final String description;
  StoreTime({@required this.title, this.subtitle, this.description});

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
          title: Text("ORA APERTO", style: TextStyle(fontWeight:  FontWeight.bold, fontSize: 18, color: Colors.green),),
          subtitle: ListTile(
            leading: Icon(Icons.access_time, color: Colors.grey,),
            title: Text(this.subtitle.toString(), style: TextStyle(fontWeight:  FontWeight.bold, fontSize: 16, color: Colors.black),),
          ),
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
                        "Orari di apertura del negozio",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 16),
                      ),
                    ],
                  )

              ),
            ),
          ],
        ),
      ),
    );
  }
}