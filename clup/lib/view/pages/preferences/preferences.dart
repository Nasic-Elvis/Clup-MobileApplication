import 'package:beauty_navigation/beauty_navigation.dart';
import 'package:clup/bloc/authentication/authentication_bloc.dart';
import 'package:clup/bloc/authentication/authentication_state.dart';
import 'package:clup/controller/repository/storeRepository.dart';
import 'package:clup/homepage_theme.dart';
import 'package:clup/utils/values.dart';
import 'package:clup/view/pages/bookingList/bookingList.dart';
import 'package:clup/view/pages/home/components/bottom_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:clup/view/pages/preferences/storePref.dart';
import 'package:clup/view/pages/settings/settings.dart';
import 'package:clup/view/widget/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clup/utils/values.dart' as Values;

import '../home/homepage.dart';

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
    return /*Scaffold(
      body:*/
        SafeArea(
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Logged) {
            return FutureBuilder(
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
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                                AppLocalizations.of(context)
                                    .preferences_noSelected,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Divider(height: 30, color: Colors.transparent),
                            Image.asset(
                              Values.Path.empty,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return StoresPrefList(
                      store: snapshot.data,
                      animationController: _animationController);
                }
              },
            );
          }
          if (state is Unlogged) {
            return Center(
              child: Column(
                children: [
                  Container(
                      child: Image.asset(
                    Values.Path.noPreferences,
                    fit: BoxFit.scaleDown,
                  )),
                  Center(
                    child: Text(
                      AppLocalizations.of(context)
                          .preferences_login_error_description,
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
