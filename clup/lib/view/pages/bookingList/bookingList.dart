import 'package:clup/bloc/authentication/authentication_bloc.dart';
import 'package:clup/bloc/authentication/authentication_state.dart';
import 'package:clup/controller/api/bookingController.dart';
import 'package:clup/controller/repository/bookingRespository.dart';
import 'package:clup/utils/values.dart';
import 'package:clup/utils/values.dart' as Values;
import 'package:clup/view/pages/home/components/bottom_bar.dart';
import 'package:clup/view/pages/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart' as Toast;

import '../details/details_screen.dart';
import '../preferences/preferences.dart';

int idUser;

class BookingList extends StatefulWidget {
  const BookingList({Key key}) : super(key: key);

  @override
  _BookingList createState() => _BookingList();
}

class _BookingList extends State<BookingList> with TickerProviderStateMixin {
  bookingRespository _bookingRepository;
  BookingApi _bookingApi;
  AnimationController _animationController;

  @override
  void initState() {
    _bookingRepository = bookingRespository();
    _bookingApi = BookingApi();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<int> getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    idUser = prefs.getInt(Values.Strings.sharedPreferences_idUser);
    return idUser;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Logged) {
            return FutureBuilder(
              future: _bookingRepository.getBookings(),
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
                            AppLocalizations.of(context).bookingList_noBooking,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Divider(height: 30, color: Colors.transparent),
                          Image.asset(
                            Values.Path.empty,
                          ),
                        ],
                      ),
                    )),
                  );
                } else {
                  return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          List<String> elements =
                              getDateToList(snapshot.data[index].date);
                          print(snapshot.data[0].store.address);
                          return Center(
                            child: Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new ListTile(
                                    leading: Image.network(
                                        snapshot.data[index].store.imageUrl,
                                        fit: BoxFit.fill),
                                    title: Text(
                                      elements[0] +
                                          " " +
                                          elements[1] +
                                          " " +
                                          // ignore: missing_return
                                          elements[2],
                                      style: new TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                        snapshot.data[index].store.name +
                                            ", " +
                                            snapshot.data[index].store.address),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      FlatButton(
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .bookingList_details
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            DetailsScreen.routeName,
                                            arguments: ProductDetailsArguments(
                                                store:
                                                    snapshot.data[index].store),
                                          );
                                        },
                                      ),
                                      FlatButton(
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .bookingList_delete_text
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () async {
                                          int result = await _bookingApi
                                              .deleteBooking(snapshot
                                                  .data[index].idBooking);
                                          if (result == 200) {
                                            Toast.Toast.show(
                                                AppLocalizations.of(context)
                                                    .bookingList_delete
                                                    .toString(),
                                                context,
                                                duration:
                                                    Toast.Toast.LENGTH_LONG,
                                                gravity: Toast.Toast.BOTTOM);
                                            setState(() {});
                                          }
                                        },
                                      ),
                                    ],
                                  )
                                ],
                                // ignore: missing_return
                              ),
                            ),
                          );
                        },
                      ));
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
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: Text(
                        AppLocalizations.of(context).details_login_reservation,
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              // ignore: missing_return
            );
          }
        },
      ),
      /*),
      bottomNavigationBar: BottomBar(),*/
    );
  }

  getDateToList(bookingDate) {
    DateTime tempDate =
        new DateFormat(Values.Pattern.dataMySql).parse(bookingDate);
    print(tempDate);
    String dateToList = tempDate.day.toString();
    int monthToList = tempDate.month;
    String yearToList = tempDate.year.toString();
    print(yearToList);
    var month = [
      "Gen",
      "Feb",
      "Mar",
      "Apr",
      "Mag",
      "Giu",
      "Lug",
      "Ago",
      "Sett",
      "Ott",
      "Nov",
      "Dic"
    ];
    var arr = [dateToList, month[monthToList - 1], yearToList];
    return arr;
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
            size: Size(MediaQuery.of(context).size.width,
                (MediaQuery.of(context).size.height * 0.10).toDouble()),
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
