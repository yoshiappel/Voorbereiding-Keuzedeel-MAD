import 'package:flutter/material.dart';
import 'constants.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {


  // function to toggle the dark/light mode
  void _toggleTheme(bool isOn) {
    setState(() {
      themeMode = isOn ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      home: Scaffold(
        appBar: AppBar(title: const Text("Settings"),),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Text('light'),
              Switch(
                  value: themeMode == ThemeMode.light,
                  onChanged: _toggleTheme)
            ],
          ),
        ),
      ),
    );
  }
}




