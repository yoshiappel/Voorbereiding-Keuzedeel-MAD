import 'package:flutter/material.dart';
import 'networking.dart';
import 'constants.dart';
import 'main.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() => runApp(MaterialApp(home: LoadingScreen()));

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    print("initState called");
    currencyList.clear();
    getCurrencyList();
  }

  void getCurrencyList() async {
    // call the function from the networking to get the currencies list using the api
    NetworkHelper networkHelper = NetworkHelper('$currenciesEndpoint?apikey=$apiKey');
    var data = await networkHelper.getData();
    Map myMap = data['data'];

    myMap.forEach((key, value) {
      currencyList.add('$key');
    });

    Navigator.push(context, MaterialPageRoute(builder: (context) {return AppRoot();}));}


  @override
  Widget build(BuildContext context) {
    print("LoadingScreen is being built");
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.blue,
          size: 100.0,
        ),
      ),
    );
  }
}
