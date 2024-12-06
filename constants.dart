import 'package:flutter/material.dart';

ThemeMode themeMode = ThemeMode.light;

const apiKey = 'YOUR APIKEY';
const currenciesEndpoint = 'YOUR ENDPOINT';
const latestExchangeRatesEndpoint = 'YOUR EXCHANGERATES ENDPOINT';
const historicalExchangeRatesEndpoint = 'YOUR HISTORICAL ENDPOINT';

List<String> currencyList = <String>[];

String? currencyFrom;
String? currencyTo;
String exchangeRate = '';