import 'package:flutter/material.dart';
import 'package:keuzedeel_mad_voorbereiding/convert.dart';
import 'history.dart';
import 'settings.dart';
import 'loading_screen.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData.light(),
  home: LoadingScreen(), // this loads LoadingScreen first
));

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(title: const Text('Mijn App')),
          bottomNavigationBar: const TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            // the different tabs under in the screen
            tabs: [
              Tab(icon: Icon(Icons.compare_arrows_sharp), text: 'Converter'),
              Tab(icon: Icon(Icons.history), text: 'History'),
              Tab(icon: Icon(Icons.settings), text: 'Settings'),
            ],
          ),
          body: TabBarView(
            children: [
              const Convert(),
              History(),
              const Settings(),
            ],
          ),
        ),
      ),
    );
  }
}
