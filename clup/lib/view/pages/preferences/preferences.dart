import 'package:clup/controller/repository/storeRepository.dart';
import 'package:clup/homepage_theme.dart';
import 'package:clup/utils/values.dart';
import 'package:clup/utils/values.dart';
import 'package:clup/view/pages/home/components/bottom_bar.dart';
import 'package:clup/view/pages/preferences/storePref.dart';
import 'package:clup/view/pages/settings/settings.dart';
import 'package:flutter/material.dart';

class Preferences extends StatefulWidget {
  const Preferences({Key key}) : super(key: key);

  @override
  _PreferencesState createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences>
    with TickerProviderStateMixin {
  StoreRepository _storeRepository;
  AnimationController _animationController;

  @override
  void initState() {
    _storeRepository = StoreRepository();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferiti'),
        backgroundColor: HomepageTheme.buildLightTheme().primaryColor,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _storeRepository.getFavorites(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data.length == 0) {
              return Padding(
                padding: const EdgeInsets.all(40.0),
                child: Center(
                  child: Text(
                    'Non hai ancora salvato nessun negozio nei preferiti!',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              );
            } else {
              return StoresPrefList(
                  store: snapshot.data,
                  animationController: _animationController);
            }
          },
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

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
                        builder: (_) => SettingScreen(),
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
                        builder: (_) => SettingScreen(),
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
