import 'package:clup/utils/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../app_theme.dart';
import '../../../homepage_theme.dart';
import 'components/signin.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

bool _flutter = false;

class _SettingScreenState extends State<SettingScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          getAppBarUI(),
          Expanded(
              child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[],
                    );
                  }, childCount: 1),
                ),
              ];
            },
            body: SettingsList(
              backgroundColor: Colors.white,
              sections: [
                SettingsSection(
                  title: Strings.settingSection,
                  tiles: [
                    SettingsTile(
                      title: 'Lingua',
                      subtitle: 'Italiano',
                      leading: Icon(Icons.language),
                      onPressed: (context) {
                        //TODO: Implementare language_pickers
                      },
                    ),
                    SettingsTile(
                      title: 'Account personale',
                      subtitle: '',
                      leading: Icon(Icons.account_circle),
                      onPressed: (context) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => SignInScreen(),
                        ));
                      },
                    ),
                    SettingsTile.switchTile(
                      title: 'Dark Mode',
                      subtitle: 'Passa alla Dark Mode',
                      leading: Icon(Icons.nightlight_round),
                      onToggle: (bool value) {
                        setState(() {
                          _flutter = value;
                          AppTheme().switchTheme();
                        });
                      },
                      switchValue: _flutter,
                    ),
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    ));
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: HomepageTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Customer Line Up',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            )
          ],
        ),
      ),
    );
  }
}
