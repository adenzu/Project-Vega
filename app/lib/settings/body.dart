import 'package:app/general/util.dart';
import 'package:flutter/material.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({Key? key}) : super(key: key);

  @override
  _SettingsBodyState createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  // geçici gösteriş amaçlı değişkenler
  bool _authorized = false;
  bool _shuttleNotify = true;
  bool _childProfileNotify = true;
  final List<String> _themeNames = ["Aydınlık", "Karanlık"];
  final List<Icon> _themeIcons =
      [Icons.light_mode, Icons.dark_mode].map((e) => Icon(e)).toList();
  int _themeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SwitchListTile(
          secondary: const Icon(Icons.shield),
          title: const Text("Yetkilendir"),
          value: _authorized,
          onChanged: (value) {
            setState(() {
              _authorized = value;
            });
          },
        ),
        const Divider(),
        SwitchListTile(
          secondary: const Icon(Icons.bus_alert),
          title: const Text("Servis yaklaşınca bildir"),
          value: _shuttleNotify,
          onChanged: (value) {
            setState(() {
              _shuttleNotify = value;
            });
          },
        ),
        SwitchListTile(
          secondary: const Icon(Icons.notifications),
          title: const Text("Bağlı profiller güncellenince bildir"),
          value: _childProfileNotify,
          onChanged: (value) {
            setState(() {
              _childProfileNotify = value;
            });
          },
        ),
        const Divider(),
        ListTile(
          leading: _themeIcons[_themeIndex],
          title: const Text("Tema"),
          trailing: Text.rich(
            TextSpan(
              text: _themeNames[_themeIndex],
              children: const [
                WidgetSpan(child: Icon(Icons.arrow_drop_down)),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          onTap: () => showTightModalBottomSheet(
            context: context,
            children: List.generate(
              _themeNames.length,
              (index) => ListTile(
                leading: _themeIcons[index],
                title: Text(_themeNames[index]),
                onTap: () {
                  setState(() {
                    _themeIndex = index;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
