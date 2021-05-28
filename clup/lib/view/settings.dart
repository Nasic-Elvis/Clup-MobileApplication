import 'package:clup/utils/values.dart';
import 'package:clup/view/signin.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Strings.settingSection,
            tiles: [
              SettingsTile(
                title: 'Lingua',
                subtitle: 'Italiano',
                leading: Icon(Icons.language),
                onPressed: (context) {},
              ),
              SettingsTile(
                title: 'Sign In',
                subtitle: '',
                leading: Icon(Icons.account_circle),
                onPressed: (context) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => SignInScreen(),
                  ));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
