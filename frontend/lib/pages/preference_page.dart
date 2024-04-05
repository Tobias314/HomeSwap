import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = true;
  double userTextSize = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings UI')),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text('Language'),
                value: Text('English'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                initialValue: true,
                leading: Icon(Icons.format_paint),
                title: Text('Enable custom theme'),
              ),
              SettingsTile(
                title: Text('Text Size'),
                leading: Icon(Icons.text_fields),
                trailing: Slider(
                  min: 0.5,
                  max: 2.0,
                  divisions: 3,
                  value: userTextSize,
                  onChanged: (newValue) {
                    setState(() {
                      userTextSize = newValue;
                    });
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
