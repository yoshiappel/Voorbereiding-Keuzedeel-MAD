import 'package:flutter/material.dart';
import 'constants.dart';
import 'networking.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<DateTime> _dates = [
    DateTime.now().add(const Duration(days: 1)),
  ];

  String date = '';
  String exchangeRate = '';

  void getHistoryRate() async {
    // if the date is null then return nothing
    if (date.isEmpty) return;

    // url, check if it is the right url
    String url = '$historicalExchangeRatesEndpoint?apikey=$apiKey&date=$date';


    print('API URL: $url'); // print the url in the console

    // create a instance of the NetworkHelper class that is in networking.dart
    NetworkHelper networkHelper = NetworkHelper(url);

    // wait before proceeding until networkHelper.getData is done
    var data = await networkHelper.getData();
    print('API Response: $data'); // print the response of the API

    // ensure that the data is not null, the data contains a data field and the data for the specific date is available
    if (data != null && data['data'] != null && data['data'][date] != null) {
      // Extract exchange rate for the selected date and currency
      double? value = data['data'][date][currencyTo];

      if (value != null) {
        setState(() {
          exchangeRate = '1 $currencyFrom = ${value.toStringAsFixed(2)} $currencyTo';
        });
        // print messages if the currency is not correct/unavailable
      } else {
        setState(() {
          exchangeRate = 'Exchange rate unavailable for $currencyTo on $date';
        });
      }
      // print messages if the date is unavailable
    } else {
      setState(() {
        exchangeRate = 'No data available for the selected date.';
      });
    }
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
                          getHistoryRate();
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 15.0),
                  Icon(Icons.swap_horiz, size: 40.0),
                  SizedBox(width: 15.0,),
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
                          getHistoryRate();
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 20.0,),
                ],
              ),
              SizedBox(width: 20.0,),
              Row(
                children: [
                  Text(
                    '$exchangeRate',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                  ),
                ],
              ),
              SizedBox(
                width: 375,
                child: CalendarDatePicker2(
                  config: CalendarDatePicker2Config(
                    selectedDayHighlightColor: Colors.amber[900],
                    weekdayLabels: [
                      'Sun',
                      'Mon',
                      'Tue',
                      'Wed',
                      'Thu',
                      'Fri',
                      'Sat'
                    ],
                  ),
                  value: _dates,
                  onValueChanged: (dates) {
                    setState(() {
                      _dates = dates;
                      if (_dates.isNotEmpty){
                        date = _dates.first.toIso8601String().split('T').first; // Ensures correct format.
                        print('Selected Date: $date');
                        getHistoryRate();
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
