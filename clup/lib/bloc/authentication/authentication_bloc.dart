import 'package:clup/bloc/authentication/authentication_event.dart';
import 'package:clup/bloc/authentication/authentication_state.dart';
import 'package:clup/controller/repository/authenticationRepository.dart';
import 'package:clup/model/user.dart';
import 'package:clup/singletonPreferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(Unlogged initialState) : super(initialState);

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is Login) {
      User user = await AuthRepository.signIn(event.username, event.password);
      if (user != null) {
        yield Logged();
      } else {
        yield Unlogged();
      }
    }

    if (event is Logout) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      Singleton _singletonPreferences = Singleton();
      _singletonPreferences.preferences = [];

      yield Unlogged();
    }
  }
}
