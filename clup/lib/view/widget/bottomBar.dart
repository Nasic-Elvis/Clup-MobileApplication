import 'package:clup/bloc/bottom_bar/page_cubit.dart';
import 'package:clup/bloc/bottom_bar/page_state.dart';
import 'package:clup/utils/values.dart';
import 'package:clup/view/pages/bookingList/bookingList.dart';
import 'package:clup/view/pages/home/components/bottom_bar.dart';
import 'package:clup/view/pages/home/homepage.dart';
import 'package:clup/view/pages/preferences/preferences.dart';
import 'package:clup/view/pages/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigationBarAlt extends StatefulWidget {
  const BottomNavigationBarAlt({
    Key key,
  }) : super(key: key);

  @override
  _BottomNavigationBarAltState createState() => _BottomNavigationBarAltState();
}

class _BottomNavigationBarAltState extends State<BottomNavigationBarAlt> {
  int _currentIndex = 0;

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
          child: BlocBuilder<PageCubit, PageState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      new IconButton(
                        icon: Icon(
                          FontAwesomeIcons.search,
                          color: state is HomeState
                              ? Colors.black
                              : Colors.grey[300],
                          size: 20,
                        ),
                        highlightColor: Colors.pink,
                        onPressed: () {
                          BlocProvider.of<PageCubit>(context)
                              .emitHomeSelected();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => HomePage(),
                          ));
                        },
                      ),
                      Text(state is HomeState ? Strings.exploreLabel : '',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    children: [
                      new IconButton(
                        icon: Icon(
                          FontAwesomeIcons.solidHeart,
                          color: state is PreferencesState
                              ? Colors.black
                              : Colors.grey[300],
                          size: 20,
                        ),
                        highlightColor: Colors.pink,
                        onPressed: () {
                          BlocProvider.of<PageCubit>(context)
                              .emitPreferenceSelected();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => Preferences(),
                          ));
                        },
                      ),
                      Text(
                        state is PreferencesState ? Strings.preferedLabel : '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    children: [
                      new IconButton(
                        icon: Icon(
                          FontAwesomeIcons.solidBookmark,
                          color: state is BookingState
                              ? Colors.black
                              : Colors.grey[300],
                          size: 20,
                        ),
                        highlightColor: Colors.pink,
                        onPressed: () {
                          BlocProvider.of<PageCubit>(context)
                              .emitBookingSelected();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => BookingList(),
                          ));
                        },
                      ),
                      Text(
                        state is BookingState ? Strings.bookingsLabel : '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    children: [
                      new IconButton(
                        icon: Icon(
                          FontAwesomeIcons.cog,
                          color: state is SettingsState
                              ? Colors.black
                              : Colors.grey[300],
                          size: 20,
                        ),
                        highlightColor: Colors.pink,
                        onPressed: () {
                          BlocProvider.of<PageCubit>(context)
                              .emitSettingsSelected();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => SettingScreen(),
                          ));
                        },
                      ),
                      Text(state is SettingsState ? Strings.settingSection : '',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  )
                ],
              );
            },
          ),
        )
      ]),
    );
  }
}
