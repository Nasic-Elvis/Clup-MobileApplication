import 'package:clup/bloc/authentication/authentication_bloc.dart';
import 'package:clup/bloc/authentication/authentication_state.dart';
import 'package:clup/bloc/favorites/favoriteBloc.dart';
import 'package:clup/bloc/favorites/favoritesEvents.dart';
import 'package:clup/bloc/favorites/favoritesStates.dart';
import 'package:clup/homepage_theme.dart';
import 'package:clup/model/store.dart';
import 'package:clup/singletonPreferences.dart';
import 'package:clup/view/pages/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_extensions/string_extensions.dart';

bool isPressed = true;

class StoreListView extends StatefulWidget {
  const StoreListView(
      {Key key,
      this.store,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final Store store;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  _StoreListViewState createState() => _StoreListViewState(this.store);
}

class _StoreListViewState extends State<StoreListView> {
  Store store;
  SharedPreferences prefs;
  Singleton _singleton;

  _StoreListViewState(this.store);
  @override
  void initState() {
    getSharedPreferences();
    if (prefs != null) {
      if (prefs.getString("idUser") != null) {
        BlocProvider.of<FavoriteBloc>(context).add(GetFavorites());
      }
    }
    _singleton = Singleton();
  }

  Future<void> getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    prefs.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - widget.animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.white,
                onTap: () {
                  widget.callback();
                },
                child: Container(
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              DetailsScreen.routeName,
                              arguments:
                                  ProductDetailsArguments(store: widget.store),
                            );
                          },
                          child: new Column(children: <Widget>[
                            AspectRatio(
                              aspectRatio: 2,
                              child: Image.network(
                                widget.store.imageUrl,
                                fit: BoxFit.fitWidth,
                                colorBlendMode: BlendMode.color,
                              ),
                            ),
                            Container(
                              color: HomepageTheme.buildLightTheme()
                                  .backgroundColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, top: 8, bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              widget.store.name,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 22,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "${widget.store.city.capitalize()}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey
                                                          .withOpacity(0.8)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "${widget.store.address}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey
                                                          .withOpacity(0.8)),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Icon(
                                                  FontAwesomeIcons.mapMarkerAlt,
                                                  size: 12,
                                                  color: HomepageTheme
                                                          .buildLightTheme()
                                                      .primaryColor,
                                                ),
                                              ],
                                            ),
                                            /*Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Row(
                                                children: <Widget>[
                                                  SmoothStarRating(
                                                    allowHalfRating: true,
                                                    starCount: 5,
                                                    rating: widget.store.rating,
                                                    size: 20,
                                                    color: HomepageTheme
                                                            .buildLightTheme()
                                                        .primaryColor,
                                                    borderColor: HomepageTheme
                                                            .buildLightTheme()
                                                        .primaryColor,
                                                  ),
                                                ],
                                              ),
                                            ),*/
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          '${widget.store.booktableCapacity} posti',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                              onTap: () {},
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: BlocBuilder<AuthenticationBloc,
                                      AuthenticationState>(
                                    builder: (context, authenticationState) {
                                      return BlocBuilder<FavoriteBloc,
                                              FavoriteState>(
                                          builder: (context, state) {
                                        if (authenticationState is Logged) {
                                          if (state is InitFavorites &&
                                              !_singleton.preferences.contains(
                                                  widget.store.idStore)) {
                                            return IconButton(
                                              icon: new Icon(
                                                Icons.favorite_border,
                                                color: Colors.red,
                                              ),
                                              highlightColor: Colors.green,
                                              onPressed: () {
                                                BlocProvider.of<FavoriteBloc>(
                                                        context)
                                                    .add(AddFavorites(
                                                        widget.store.idStore,
                                                        widget.store.name));
                                              },
                                            );
                                          }
                                          if (state is InitFavorites &&
                                              _singleton.preferences.contains(
                                                  widget.store.idStore)) {
                                            return IconButton(
                                              icon: new Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              ),
                                              highlightColor: Colors.green,
                                              onPressed: () {
                                                BlocProvider.of<FavoriteBloc>(
                                                        context)
                                                    .add(RemoveFavorites(
                                                        widget.store.idStore,
                                                        widget.store.name));
                                              },
                                            );
                                          }
                                          if (state is Favorite &&
                                              !_singleton.preferences.contains(
                                                  widget.store.idStore)) {
                                            return IconButton(
                                              icon: new Icon(
                                                Icons.favorite_border,
                                                color: Colors.red,
                                              ),
                                              highlightColor: Colors.green,
                                              onPressed: () {
                                                BlocProvider.of<FavoriteBloc>(
                                                        context)
                                                    .add(AddFavorites(
                                                        widget.store.idStore,
                                                        widget.store.name));
                                              },
                                            );
                                          } else if (state is Favorite &&
                                              _singleton.preferences.contains(
                                                  widget.store.idStore)) {
                                            return IconButton(
                                              icon: new Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              ),
                                              highlightColor: Colors.green,
                                              onPressed: () {
                                                BlocProvider.of<FavoriteBloc>(
                                                        context)
                                                    .add(RemoveFavorites(
                                                        widget.store.idStore,
                                                        widget.store.name));
                                              },
                                            );
                                          } else if (state is NoFavorite &&
                                              !_singleton.preferences.contains(
                                                  widget.store.idStore)) {
                                            return IconButton(
                                              icon: new Icon(
                                                Icons.favorite_border,
                                                color: Colors.red,
                                              ),
                                              highlightColor: Colors.green,
                                              onPressed: () {
                                                widget.store.pref = true;
                                                BlocProvider.of<FavoriteBloc>(
                                                        context)
                                                    .add(AddFavorites(
                                                        widget.store.idStore,
                                                        widget.store.name));
                                              },
                                            );
                                          } else if (state is NoFavorite &&
                                              _singleton.preferences.contains(
                                                  widget.store.idStore)) {
                                            return IconButton(
                                              icon: new Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              ),
                                              highlightColor: Colors.green,
                                              onPressed: () {
                                                widget.store.pref = true;
                                                BlocProvider.of<FavoriteBloc>(
                                                        context)
                                                    .add(RemoveFavorites(
                                                        widget.store.idStore,
                                                        widget.store.name));
                                              },
                                            );
                                          }
                                        }
                                        if (authenticationState is Unlogged) {
                                          return SizedBox();
                                        }
                                      });
                                    },
                                  )),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 132,
                            left: 32,
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40.0),
                                child: Image.network(
                                  widget.store.iconUrl,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
