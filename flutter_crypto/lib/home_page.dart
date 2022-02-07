import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  List currencies;

  HomePage(this.currencies, {Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List currencies;
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  Future<List> getCurrencies() async {
    String cryptoUrl = "https://api.coinmartketcap.com/v1/ticket/?limit=50";
    http.Response response = await http.get(Uri.parse(cryptoUrl));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto App'),
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return Container(
      child: Flexible(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            final Map currency = widget.currencies[index];
            final MaterialColor color =
                _colors[index % _colors.length]; //random
            return _getListItem(currency, color);
          },
          itemCount: widget.currencies.length,
        ),
      ),
    );
  }
}

ListTile _getListItem(Map currency, MaterialColor color) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: color,
      child: Text(currency['name'][0]),
    ),
    title: Text(
      currency['name'],
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle:
        _getSubTitleText(currency['price_usd'], currency['percent_change']),
    isThreeLine: true,
  );
}

Widget _getSubTitleText(String currency, String currency2) {
  TextSpan priceTextWidget = TextSpan(
    text: "\$$currency\n",
    style: TextStyle(color: Colors.black),
  );
  String percentageChange = "1 hour: $currency2%";
  TextSpan percentageChangeTextWidget;

  if (double.parse(percentageChange) > 0) {
    percentageChangeTextWidget = TextSpan(
      text: percentageChange,
      style: TextStyle(color: Colors.green),
    );
  } else {
    percentageChangeTextWidget =
        TextSpan(text: percentageChange, style: TextStyle(color: Colors.red));
  }

  return RichText(
    text: TextSpan(children: [
      priceTextWidget,
      percentageChangeTextWidget,
    ]),
  );
}
