import 'package:clup/controller/repository/authenticationRepository.dart';
import 'package:clup/homepage_theme.dart';
import 'package:clup/view/widget/custom_shape.dart';
import 'package:clup/view/widget/customappbar.dart';
import 'package:clup/view/widget/responsive_ui.dart';
import 'package:clup/view/widget/textformfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'signin.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  TextEditingController nameController = new TextEditingController();
  TextEditingController surnameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Scaffold(
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Opacity(opacity: 0.88, child: CustomAppBar()),
                clipShape(),
                form(),
                SizedBox(
                  height: _height / 35,
                ),
                button(),
                //infoTextRow(),
                //socialIconsRow(),
                //signInTextRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 8
                  : (_medium ? _height / 7 : _height / 6.5),
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
                  ? _height / 12
                  : (_medium ? _height / 11 : _height / 10),
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
      ],
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 20.0),
      child: Form(
        child: Column(
          children: <Widget>[
            firstNameTextFormField(),
            SizedBox(height: _height / 60.0),
            lastNameTextFormField(),
            SizedBox(height: _height / 60.0),
            emailTextFormField(),
            SizedBox(height: _height / 60.0),
            phoneTextFormField(),
            SizedBox(height: _height / 60.0),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget firstNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      textEditingController: nameController,
      icon: Icons.person,
      hint: AppLocalizations.of(context).signup_name,
    );
  }

  Widget lastNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      textEditingController: surnameController,
      icon: Icons.person,
      hint: AppLocalizations.of(context).signup_surname,
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      textEditingController: emailController,
      icon: Icons.email,
      hint: AppLocalizations.of(context).signup_email,
    );
  }

  Widget phoneTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.number,
      textEditingController: numberController,
      icon: Icons.phone,
      hint: AppLocalizations.of(context).signup_phoneNumber,
    );
  }

  Widget passwordTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      textEditingController: passwordController,
      obscureText: true,
      icon: Icons.lock,
      hint: AppLocalizations.of(context).signup_password,
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
//        height: _height / 20,
          width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
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
          child: Text(
            AppLocalizations.of(context).signup_btnText,
            style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10)),
          ),
        ),
        onTap: () async {
          bool result;
          result = await AuthRepository.signUp(
              nameController.text.trim(),
              surnameController.text.trim(),
              emailController.text.trim(),
              numberController.text.trim(),
              passwordController.text.trim());
          if (result == true) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => SignInScreen()));
          }
          //TODO: Gestione errore di registrazione.
        },
      ),
    );
  }

  Widget infoTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        ],
      ),
    );
  }

  Widget socialIconsRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 80.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).signup_registered,
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => SignInPage(),
              ));
            },
            child: Text(

              AppLocalizations.of(context).signup_registered_btn,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: HomepageTheme.buildLightTheme().primaryColor,
                  fontSize: 19),
            ),
          )
        ],
      ),
    );
  }
}
