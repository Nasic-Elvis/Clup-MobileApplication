

import 'package:clup/model/time.dart';
import 'package:clup/utils/values.dart' as Values;
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

class StoreTime extends PreferredSize {
  final String title;
  final String subtitle;
  final String description;
  final Future<List<Time>> time;
  var inizio;

  StoreTime({@required this.title, this.subtitle, this.description, this.time});

  bool isNumeric(String string) {
    var numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }

  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
  String statoNegozio = "";
  TextStyle textStyle;
  bool open = true;

  checkDateTime(String subtitle) {
    //DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(date);
    DateTime now = DateTime.now();
    var splitOpenAndClose = subtitle.split("-");
    var openTimeSplitted = splitOpenAndClose[0].split(":");
    var closeTimeSplitted = splitOpenAndClose[1].split(":");
    print(closeTimeSplitted);
    if (isNumeric(closeTimeSplitted[0].trim()) &&
        isNumeric(closeTimeSplitted[1].trim()) &&
        isNumeric(openTimeSplitted[0].trim()) &&
        isNumeric(openTimeSplitted[1].trim())) {
      DateTime second = DateTime(
          now.year,
          now.month,
          now.day,
          int.parse(closeTimeSplitted[0].trim()),
          int.parse(closeTimeSplitted[1].trim()));
      DateTime first = DateTime(
          now.year,
          now.month,
          now.day,
          int.parse(openTimeSplitted[0].trim()),
          int.parse(openTimeSplitted[1].trim()));

      print(second);
      print(first);
      if (now.isAfter(first) && now.isBefore(second)) {
        statoNegozio =
            Values.Strings.nowOpen;
        open = true;
        textStyle = TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green);
      } else {
        statoNegozio = Values.Strings.nowClosed;
        open = false;
        textStyle = TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red);
      }
    } else {
      statoNegozio = Values.Strings.nowClosed;
      open = false;
      textStyle = TextStyle(
          fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    checkDateTime(this.subtitle);
    if(statoNegozio == Values.Strings.nowClosed)
      statoNegozio = AppLocalizations.of(context).store_time_now_closed.toString().toUpperCase();
      else
        statoNegozio = AppLocalizations.of(context).store_time_now_open.toString().toUpperCase();

    return SafeArea(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: ExpansionTileCard(
            baseColor: Colors.grey[50],
            expandedColor: Colors.grey[50],
            key: cardA,
            title: Text(
                  statoNegozio,
                  style: textStyle,
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
                          AppLocalizations.of(context).store_time,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        Divider(
                          thickness: 1.0,
                          height: 2.0,
                          color: Colors.transparent,
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
                                return Text(Values.Strings.errorString);
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
