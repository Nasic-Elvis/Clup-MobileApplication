import 'dart:io';

import 'package:clup/app_theme.dart';
import 'package:clup/bloc/favorites/favoritesStates.dart';
import 'package:clup/utils/routes.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/category/category_bloc.dart';
import 'bloc/category/category_state.dart';
import 'bloc/favorites/favoriteBloc.dart';
import 'bloc/internet/internet_cubit.dart';
import 'view/pages/home/homepage.dart';

AppTheme _appTheme = AppTheme();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  Connectivity connectivity = Connectivity();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => InternetCubit(connectivity: connectivity)),
          BlocProvider(create: (context) => CategoryBloc(InitialState())),
          BlocProvider(create: (context) => FavoriteBloc(InitFavorites()))
        ],
        child: MaterialApp(
          title: 'Clup',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: _appTheme.currentTheme(),
          initialRoute: HomePage.routeName,
          routes: routes,
          //home: MapScreen(lat: 9.84738992, long: -13.48293, address: "CIAO", city: "CONAD", ),
        ));
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
