import 'package:flutter/material.dart';
import 'constants.dart';
import 'networking.dart';

class Convert extends StatefulWidget {
  const Convert({super.key});

  @override
  State<Convert> createState() => _ConvertState();
}

class _ConvertState extends State<Convert> {

  // a function for getting the exchangerate via the api
  void getExchangeRate() async {
    NetworkHelper networkHelper = NetworkHelper(
      // the url
        '$latestExchangeRatesEndpoint?apikey=$apiKey&base_currency=$currencyFrom&currencies=$currencyFrom,$currencyTo');
    var data = await networkHelper.getData();
    // json structure
    double value = data['data']['$currencyTo'];

    setState(() {
      exchangeRate = '1 $currencyFrom is ${value.toStringAsFixed(2)} $currencyTo';
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
        appBar: AppBar(title: Text("Convert")),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  // first dropdown button for the start currency
                  SizedBox(
                    width: 150.0,
                    child: DropdownButton(
                      hint: Text('Maak een keuze'),
                      value: currencyFrom,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: currencyList.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          currencyFrom = newValue!;
                          // this calls the function "getEchangeRate"
                          getExchangeRate();
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 15.0),
                  Icon(Icons.swap_horiz, size: 40.0),
                  SizedBox(width: 15.0,),
                  // second dropdown button for the end currency
                  SizedBox(
                    width: 150.0,
                    child: DropdownButton(
                      hint: Text('Maak een keuze'),
                      value: currencyTo,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: currencyList.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          currencyTo = newValue!;
                          // this calls the function "getExchangeRate"
                          getExchangeRate();
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 20.0,),
                ],
              ),
              SizedBox(width: 20.0,),
              // result
              Row(
                children: [
                  // the text for the output of the two currencies
                  Text(
                    '$exchangeRate',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
