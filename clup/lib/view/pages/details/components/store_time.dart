import 'package:clup/model/time.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

class StoreTime extends PreferredSize {
  final String title;
  final String subtitle;
  final String description;
  final Future<List<Time>> time;
  var inizio;

  StoreTime({@required this.title, this.subtitle, this.description, this.time});

  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: ExpansionTileCard(
            baseColor: Colors.grey[50],
            expandedColor: Colors.grey[50],
            key: cardA,
            //leading: CircleAvatar(
            //   child:),
            title: Text(
              "ORA APERTO",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green),
            ),
            subtitle: ListTile(
              leading: Icon(
                Icons.access_time,
                color: Colors.grey,
              ),
              title: Text(
                this.subtitle.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
              ),
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
                  child: Column(children: [
                    Text(
                      "Orari di apertura del negozio",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black),
                    ),
                    Divider(
                      thickness: 1.0,
                      height: 2.0,
                    ),
                  ]),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Container(
                    height: 180,
                    child: FutureBuilder(
                        future: time,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.separated(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return ListTile(
                                  title: Text(snapshot.data[index].day,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(fontSize: 14)),
                                  subtitle: Text(snapshot.data[index].from +
                                      " - " +
                                      snapshot.data[index].to),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(
                                  height: 0.5,
                                );
                              },
                            );
                          }
                          if (snapshot.hasError) {
                            return Text("ERROR");
                          }
                          return Center(child: CircularProgressIndicator());
                        }),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}