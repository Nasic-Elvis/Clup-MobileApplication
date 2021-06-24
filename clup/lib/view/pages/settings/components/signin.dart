import 'package:clup/bloc/authentication/authentication_bloc.dart';
import 'package:clup/bloc/authentication/authentication_event.dart';
import 'package:clup/bloc/authentication/authentication_state.dart';
import 'package:clup/bloc/category/category_bloc.dart';
import 'package:clup/bloc/favorites/favoriteBloc.dart';
import 'package:clup/utils/values.dart' as Values;
import 'package:clup/bloc/favorites/favoritesEvents.dart';
import 'package:clup/controller/repository/authenticationRepository.dart';
import 'package:clup/homepage_theme.dart';
import 'package:clup/model/user.dart';
import 'package:clup/utils/validator.dart';
import 'package:clup/view/pages/home/homepage.dart';
import 'package:clup/view/pages/settings/components/forgotPassword.dart';
import 'package:clup/view/widget//textformfield.dart';
import 'package:clup/view/widget/custom_shape.dart';
import 'package:clup/view/widget/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'signup.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  String _errorText = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  Validator validator = Validator();

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      child: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              clipShape(),
              welcomeTextRow(),
              signInTextRow(),
              form(),
              forgetPassTextRow(),
              SizedBox(
                  height: _height / 12,
                  child: _errorText != ""
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_errorText,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600)))
                      : SizedBox()),
              button(),
              signUpTextRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    //double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 4
                  : (_medium ? _height / 3.75 : _height / 3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    HomepageTheme.buildLightTheme().primaryColor,
                    HomepageTheme.buildLightTheme().accentColor
                  ],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large
                  ? _height / 4.5
                  : (_medium ? _height / 4.25 : _height / 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    HomepageTheme.buildLightTheme().primaryColor,
                    HomepageTheme.buildLightTheme().accentColor
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(
              top: _large
                  ? _height / 30
                  : (_medium ? _height / 25 : _height / 20)),
          child: Image.asset(
            Values.Path.login,
            height: _height / 3.5,
            width: _width / 3.5,
          ),
        ),
      ],
    );
  }

  Widget welcomeTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20, top: _height / 100),
      child: Row(
        children: <Widget>[
          Text(
            AppLocalizations.of(context).signin_title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: _large ? 60 : (_medium ? 50 : 40),
            ),
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Text(
            AppLocalizations.of(context).signin_subtitle,
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: _large ? 20 : (_medium ? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 15.0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            emailTextFormField(),
            SizedBox(height: _height / 40.0),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      textEditingController: emailController,
      icon: Icons.email,
      hint: AppLocalizations.of(context).signin_components_email,
    );
  }

  Widget passwordTextFormField() {
    /*TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: passwordController,
      decoration: InputDecoration(
          hintText: AppLocalizations.of(context).signin_components_password,
          icon: Icon(Icons.lock)),
      obscureText: true,*/
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      textEditingController: passwordController,
      icon: Icons.lock,
      hint: AppLocalizations.of(context).signin_components_password,
      obscureText: true,
    );
    //initialValue: ,
  }

  Widget forgetPassTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).signin_components_forgot_pwd,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 14 : (_medium ? 12 : 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ForgotPassword()));
            },
            child: Text(
              AppLocalizations.of(context).signin_components_get_pwd,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: HomepageTheme.buildLightTheme().primaryColor),
            ),
          )
        ],
      ),
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context).signin_login_success)));
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: GestureDetector(
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is Logged) {
              BlocProvider.of<FavoriteBloc>(context).add(GetFavorites());
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (Route<dynamic> route) => false);
            }
          },
          child: Container(
            alignment: Alignment.center,
            width:
                _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              gradient: LinearGradient(
                colors: <Color>[
                  HomepageTheme.buildLightTheme().primaryColor,
                  HomepageTheme.buildLightTheme().accentColor
                ],
              ),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Text(AppLocalizations.of(context).settings_login,
                style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10))),
          ),
        ),
        onTap: () {
          String validEmail = validator.validateEmail(emailController.text);
          String validPassword =
              validator.validatePasswordLength(passwordController.text);
          if (validEmail == null) {
            if (validPassword == null) {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(Login(emailController.text, passwordController.text));
            } else {
              setState(() => _errorText = validPassword);
            }
          } else {
            setState(() => _errorText = validEmail);
          }
        },
      ),
    );
  }

  Widget signUpTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 120.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).signin_notRegitered,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 14 : (_medium ? 12 : 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => SignUpScreen(),
              ));
            },
            child: Text(
              AppLocalizations.of(context).signin_signup,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: HomepageTheme.buildLightTheme().primaryColor,
                  fontSize: _large ? 19 : (_medium ? 17 : 15)),
            ),
          )
        ],
      ),
    );
  }
}
