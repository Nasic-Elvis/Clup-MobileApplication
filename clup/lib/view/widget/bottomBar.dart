import 'package:clup/utils/values.dart';
import 'package:clup/view/pages/bookingList/bookingList.dart';
import 'package:clup/view/pages/home/components/bottom_bar.dart';
import 'package:clup/view/pages/home/homepage.dart';
import 'package:clup/view/pages/preferences/preferences.dart';
import 'package:clup/view/pages/settings/settings.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height * 0.10).toDouble(),
      child: Stack(children: <Widget>[
        Positioned(
          bottom: 0,
          child: CustomPaint(
            size: Size(
                MediaQuery.of(context).size.width,
                (MediaQuery.of(context).size.height * 0.10)
                    .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
            painter: RPSCustomPainter(),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 12,
          right: 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  new IconButton(
                    icon: Icon(Icons.search),
                    highlightColor: Colors.pink,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => HomePage(),
                      ));
                    },
                  ),
                  Text(Strings.exploreLabel)
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                children: [
                  new IconButton(
                    icon: Icon(Icons.favorite),
                    highlightColor: Colors.pink,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => Preferences(),
                      ));
                    },
                  ),
                  Text(Strings.preferedLabel)
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                children: [
                  new IconButton(
                    icon: Icon(Icons.bookmark),
                    highlightColor: Colors.pink,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => BookingList(),
                      ));
                    },
                  ),
                  Text(Strings.bookingsLabel)
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                children: [
                  new IconButton(
                    icon: Icon(Icons.settings),
                    highlightColor: Colors.pink,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => SettingScreen(),
                      ));
                    },
                  ),
                  Text(Strings.settingSection)
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
