import 'package:flutter/material.dart';
import 'package:flutter_crypto/home_page.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List currencies = await getCurrencies();
  runApp(MyApp(currencies));
}

class MyApp extends StatelessWidget {
  final List _currencies;
  const MyApp(this._currencies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink),
      home: HomePage(_currencies),
    );
  }
}

Future<List> getCurrencies() async {
  String cryptoUrl = "https://api.coinmartketcap.com/v1/ticket/?limit=50";
  http.Response response = await http.get(Uri.parse(cryptoUrl));
  return json.decode(response.body);
}
