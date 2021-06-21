import 'dart:ui';

import 'package:clup/bloc/category/category_bloc.dart';
import 'package:clup/bloc/category/category_event.dart';
import 'package:clup/bloc/category/category_state.dart';
import 'package:clup/bloc/favorites/favoritesStates.dart';
import 'package:clup/bloc/internet/internet_cubit.dart';
import 'package:clup/bloc/internet/internet_state.dart';
import 'package:clup/controller/repository/storeRepository.dart';
import 'package:clup/homepage_theme.dart';
import 'package:clup/model/store.dart';
import 'package:clup/utils/values.dart' as Values;
import 'package:clup/view/pages/home/components/categories.dart';
import 'package:clup/view/pages/home/components/store_list.dart';
import 'package:clup/view/pages/preferences/preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../settings/settings.dart';
import 'components/bottom_bar.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/home";

  HomePage();

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> with TickerProviderStateMixin {
  CategoryBloc _categoryBloc;
  Connectivity connectivity;
  _HomePage();
  StoreRepository _storeRepository = StoreRepository();
  List<Store> storeList = [];
  AnimationController animationController;
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      Values.Strings.index0,
      style: optionStyle,
    ),
    Text(
      Values.Strings.index1,
      style: optionStyle,
    ),
    Text(
      Values.Strings.index2,
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  void initState() {
    connectivity = Connectivity();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return /* MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => InternetCubit(connectivity: connectivity)),
          BlocProvider(create: (context) => CategoryBloc(InitialState())),
        ],
        child: */
        Theme(
      data: HomepageTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
            body: SafeArea(
              child: Stack(
                children: <Widget>[
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Column(
                      children: <Widget>[
                        //getAppBarUI(),
                        Expanded(
                          child: NestedScrollView(
                            controller: _scrollController,
                            headerSliverBuilder: (BuildContext context,
                                bool innerBoxIsScrolled) {
                              return <Widget>[
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: <Widget>[
                                        getSearchBarUI(),
                                        Categories(),
                                      ],
                                    );
                                  }, childCount: 1),
                                ),
                                SliverPersistentHeader(
                                  pinned: true,
                                  floating: true,
                                  delegate: ContestTabHeader(
                                    getFilterBarUI(),
                                  ),
                                ),
                              ];
                            },
                            body: BlocConsumer<InternetCubit, InternetState>(
                              listener: (context, state) {
                                print(state);
                                if (state is InternetDisconnected) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.redAccent,
                                    content:
                                        Text("Connessione internet assente"),
                                    duration: Duration(milliseconds: 500),
                                  ));
                                }
                                if (state is InternetConnected) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.greenAccent,
                                    content: Text("online"),
                                    duration: Duration(milliseconds: 500),
                                  ));
                                }
                              },
                              builder: (context, internetState) {
                                return BlocBuilder<CategoryBloc, CategoryState>(
                                    builder: (context, state) {
                                  if (internetState is InternetConnected) {
                                    if (state is InitialState) {
                                      BlocProvider.of<CategoryBloc>(context)
                                          .add(NoSelected());
                                    }
                                    if (state is NoCategoryState) {
                                      return StoresView(
                                          store: state.stores,
                                          animationController:
                                              animationController);
                                    }
                                    if (state is SupermarketState) {
                                      return StoresView(
                                          store: state.stores,
                                          animationController:
                                              animationController);
                                    }
                                    if (state is ServicesState) {
                                      return StoresView(
                                          store: state.stores,
                                          animationController:
                                              animationController);
                                    }
                                    if (state is HealtCareState) {
                                      return StoresView(
                                          store: state.stores,
                                          animationController:
                                              animationController);
                                    }
                                    if (state is OtherActivityState) {
                                      return StoresView(
                                          store: state.stores,
                                          animationController:
                                              animationController);
                                    }
                                  }
                                  if (internetState is InternetDisconnected) {
                                    return Column(
                                      children: [
                                        Center(
                                          child: Text(
                                            "Connessione internet assente",
                                            style: TextStyle(
                                                fontSize: 16,
                                                letterSpacing: 1.2),
                                          ),
                                        ),
                                        Container(
                                            child: Image.asset(
                                          'assets/images/noConnection.png',
                                          fit: BoxFit.scaleDown,
                                        )),
                                      ],
                                    );
                                  }
                                });

                                /*if (state is InternetConnected) {
                                    return Container(
                                      color: HomepageTheme.buildLightTheme()
                                          .backgroundColor,
                                      child: FutureBuilder(
                                        future: _storeRepository.getStore(),
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else {
                                            return ListView.builder(
                                              itemCount: snapshot.data.length,
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                final int count =
                                                    snapshot.data.length > 10
                                                        ? 10
                                                        : storeList.length;
                                                final Animation<
                                                    double> animation = Tween<
                                                            double>(
                                                        begin: 0.0, end: 1.0)
                                                    .animate(CurvedAnimation(
                                                        parent:
                                                            animationController,
                                                        curve: Interval(
                                                            (1 / count) * index,
                                                            1.0,
                                                            curve: Curves
                                                                .fastOutSlowIn)));
                                                animationController.forward();
                                                return StoreListView(
                                                  callback: () {},
                                                  store: snapshot.data
                                                      .elementAt(index),
                                                  animation: animation,
                                                  animationController:
                                                      animationController,
                                                );
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    );*/
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar:
                BottomBar() /*BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: Values.Strings.exploreLabel,
                    backgroundColor: Color(0xFF337CA0),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: Values.Strings.preferedLabel,
                    backgroundColor: Color(0xFF337CA0),
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.bookmark),
                      label: Values.Strings.bookingsLabel,
                      backgroundColor: Color(0xFF337CA0)),
                  BottomNavigationBarItem(
                    icon: IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {



                      },
                    ),
                    label: Values.Strings.settingsLabel,
                    backgroundColor: Colors.greenAccent,
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.black,
                onTap: _onItemTapped,
              ),*/
            ),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HomepageTheme.buildLightTheme().backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {},
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: HomepageTheme.buildLightTheme().primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Piacenza...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: HomepageTheme.buildLightTheme().primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.search,
                      size: 20,
                      color: HomepageTheme.buildLightTheme().backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getIconsBar() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: 50.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            child: new IconButton(
              padding: new EdgeInsets.all(10.0),
              color: Colors.black,
              icon: new Icon(Icons.business_outlined, size: 40.0),
            ),
            width: 120.0,
            color: Colors.white,
          ),
          Container(
            child: new IconButton(
              padding: new EdgeInsets.all(10.0),
              color: Colors.black,
              icon: new Icon(Icons.account_balance_sharp, size: 40.0),
            ),
            width: 120.0,
            color: Colors.white,
          ),
          Container(
            child: new IconButton(
              padding: new EdgeInsets.all(10.0),
              color: Colors.black,
              icon: new Icon(Icons.account_circle, size: 40.0),
            ),
            width: 120.0,
            color: Colors.white,
          ),
          Container(
            child: new IconButton(
              padding: new EdgeInsets.all(10.0),
              color: Colors.black,
              icon: new Icon(Icons.where_to_vote, size: 40.0),
            ),
            width: 120.0,
            color: Colors.white,
          ),
          Container(
            child: new IconButton(
              padding: new EdgeInsets.all(10.0),
              color: Colors.black,
              icon: new Icon(Icons.archive, size: 40.0),
            ),
            width: 120.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: HomepageTheme.buildLightTheme().backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: HomepageTheme.buildLightTheme().backgroundColor,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
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
            Expanded(
              child: Center(
                child: Text(""
                    /*user != null
                      ? '${Values.Strings.title}, ${user.name}'
                      : 'Customer Line Up',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,*/
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

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );

  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
