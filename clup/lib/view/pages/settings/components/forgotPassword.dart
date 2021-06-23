import 'package:clup/controller/repository/authenticationRepository.dart';
import 'package:clup/homepage_theme.dart';
import 'package:clup/utils/validator.dart';
import 'package:clup/utils/values.dart' as Values;
import 'package:clup/view/pages/settings/components/signin.dart';
import 'package:clup/view/widget/custom_shape.dart';
import 'package:clup/view/widget/responsive_ui.dart';
import 'package:clup/view/widget/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  AuthRepository _authRepository = AuthRepository();
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmedController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  Validator validator = Validator();
  String _errorText = "";

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
              form(),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {},
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
          String validEmail = validator.validateEmail(emailController.text);
          String validPassword =
              validator.validatePasswordLength(passwordController.text);
          String validConfirmPassword = validator
              .validatePasswordLength(passwordConfirmedController.text);

          if (validEmail == null) {
            if (validPassword == null) {
              if (validConfirmPassword == null) {
                if (passwordConfirmedController.text ==
                    passwordController.text) {
                  result = await AuthRepository.forgotPassword(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                      passwordConfirmedController.text.trim());
                  if (result == true) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                        (Route<dynamic> route) => false);
                  }
                  if (result == false) {
                    setState(() => _errorText = "Operazione non riuscita");
                  }
                } else {
                  setState(
                      () => _errorText = "Le password devono essere uguali");
                }
              } else {
                setState(() => _errorText = validPassword);
              }
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
            SizedBox(height: _height / 40.0),
            passwordConfirmedTextFormField(),
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
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      textEditingController: passwordController,
      icon: Icons.lock,
      obscureText: true,
      hint: AppLocalizations.of(context).signin_components_password,
    );
  }

  Widget passwordConfirmedTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      textEditingController: passwordConfirmedController,
      icon: Icons.lock,
      obscureText: true,
      hint: AppLocalizations.of(context).signin_components_password,
    );
  }
}
