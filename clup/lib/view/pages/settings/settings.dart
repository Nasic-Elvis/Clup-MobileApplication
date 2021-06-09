import 'package:clup/utils/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../app_theme.dart';
import 'components/signin.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

bool _flutter = false;

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
                title: 'Account personale',
                subtitle: '',
                leading: Icon(Icons.account_circle),
                onPressed: (context) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => SignInScreen(),
                  ));
                },
              ),
              SettingsTile.switchTile(
                title: 'Dark Mode',
                subtitle: 'Passa alla Dark Mode',
                leading: Icon(Icons.nightlight_round),
                onToggle: (bool value) {
                  setState(() {
                    _flutter = value;
                    AppTheme().switchTheme();
                  });
                },
                switchValue: _flutter,),
            ],
          )
        ],
      ),
    );
  }
}
