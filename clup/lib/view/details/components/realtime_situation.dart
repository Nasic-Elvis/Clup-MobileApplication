import 'package:clup/maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
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
          title: Text(this.title, style: TextStyle(fontWeight:  FontWeight.bold, fontSize: 18, color: Colors.black),),
          subtitle:  ListTile(
            leading: Icon(Icons.reduce_capacity, color: Colors.grey,),
            title: Text(this.subtitle.toString(), style: TextStyle(fontWeight:  FontWeight.normal, fontSize: 16, color: Colors.black),),
          ),),
      ),
    );
  }
}