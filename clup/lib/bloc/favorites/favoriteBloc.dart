import 'package:clup/bloc/favorites/favoritesEvents.dart';
import 'package:clup/bloc/favorites/favoritesStates.dart';
import 'package:clup/controller/repository/storeRepository.dart';
import 'package:clup/model/store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/singletonPreferences.dart';

class FavoriteBloc extends Bloc<FavoritesEvent, FavoriteState> {
  StoreRepository _storeRepository = StoreRepository();
  Singleton _singleton = Singleton();

  FavoriteBloc(InitFavorites initialState) : super(initialState);

  Stream<FavoriteState> mapEventToState(FavoritesEvent event) async* {
    if (event is GetFavorites) {
      List<Store> stores = await _storeRepository.getFavorites();
      if (stores.length > 0) {
        for (Store store in stores) {
          _singleton.preferences.add(store.idStore);
        }
        //yield Favorite();
      } else {
        yield InitFavorites();
      }
    }

    if (event is RemoveFavorites) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int idUser = prefs.getInt("idUser");

      bool result = await _storeRepository.deleteFavorite(
          idUser, event.idStore.toString());
      if (result) {
        _singleton.preferences.remove(event.idStore);
        yield NoFavorite();
      }
    }
    if (event is AddFavorites) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int idUser = prefs.getInt("idUser");

      bool result =
          await _storeRepository.insertFavorites(idUser, event.idStore);
      if (result) {
        _singleton.preferences.add(event.idStore);
        yield Favorite();
      }
    }
  }
}
