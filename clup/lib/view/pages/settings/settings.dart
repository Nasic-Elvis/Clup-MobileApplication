import 'package:clup/bloc/authentication/authentication_bloc.dart';
import 'package:clup/bloc/authentication/authentication_event.dart';
import 'package:clup/bloc/authentication/authentication_state.dart';
import 'package:clup/singletonPreferences.dart';
import 'package:clup/utils/values.dart' as Values;
import 'package:clup/view/pages/settings/userInformation/userInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../app_theme.dart';
import '../../../homepage_theme.dart';
import 'components/signin.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

bool _flutter = false;

class _SettingScreenState extends State<SettingScreen> {
  _SettingScreenState();
  final ScrollController _scrollController = ScrollController();
  Singleton _singleton = Singleton();

  @override
  Widget build(BuildContext context) {
    return /*Scaffold(
        body:*/
        SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            //getAppBarUI(),
            SizedBox(height: 12),
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
              body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is Unlogged) {
                    return SettingsList(
                      //backgroundColor: Colors.white,
                      sections: [
                        SettingsSection(
                          title: AppLocalizations.of(context).settings_title,
                          tiles: [
                            SettingsTile(
                              title: AppLocalizations.of(context).settings_login,
                              leading: Icon(Icons.account_circle),
                              onPressed: (context) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => SignInScreen(),
                                ));
                              },
                            ),
                            SettingsTile(
                              title: AppLocalizations.of(context).settings_language,
                              subtitle: Values.Language.defaultLanguage,
                              leading: Icon(Icons.language),
                              onPressed: (context) {
                                //TODO: Implementare language_pickers
                              },
                            ),
                            SettingsTile.switchTile(
                              title: AppLocalizations.of(context).settings_darkMode,
                              subtitle: AppLocalizations.of(context).settings_darkMode_description,
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
                    );
                  }
                  if (state is Logged) {
                    return SettingsList(
                      backgroundColor: Colors.white,
                      sections: [
                        SettingsSection(
                          title: AppLocalizations.of(context).settings_title,
                          tiles: [
                            SettingsTile(
                              title: AppLocalizations.of(context).settings_account,
                              leading: Icon(Icons.account_circle),
                              onPressed: (context) async {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => UserInformation(
                                        user: _singleton.user)));
                              },
                            ),
                            SettingsTile(
                              title:  AppLocalizations.of(context).settings_language,
                              subtitle:  Values.Language.defaultLanguage,
                              leading: Icon(Icons.language),
                              onPressed: (context) {
                                //TODO: Implementare language_pickers
                              },
                            ),
                            SettingsTile.switchTile(
                              title:  AppLocalizations.of(context).settings_darkMode,
                              subtitle: AppLocalizations.of(context).settings_darkMode_description,
                              leading: Icon(Icons.nightlight_round),
                              onToggle: (bool value) {
                                setState(() {
                                  _flutter = value;
                                  AppTheme().switchTheme();
                                });
                              },
                              switchValue: _flutter,
                            ),
                            SettingsTile(
                              title: AppLocalizations.of(context).settings_logout,
                              leading: Icon(Icons.logout),
                              onPressed: (context) {
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(Logout());
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => SignInScreen()),
                                    (Route<dynamic> route) => false);
                              },
                            )
                          ],
                        )
                      ],
                    );
                  }
                },
              ),
            ))
          ],
        ),
      ),
    );
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
            /*Expanded(
              child: Center(
                child: Text(
                  'Customer Line Up',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),*/
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
