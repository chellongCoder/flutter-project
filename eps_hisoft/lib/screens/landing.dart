import 'dart:async';

import 'package:eps_hisoft/provider/auth.provider.dart';
import 'package:eps_hisoft/screens/home.dart';
import 'package:eps_hisoft/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends StatefulWidget {
  static const routeName = '/landing';

  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  late Future<bool> _isLogged;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    print('${auth.storage.toString()}');
    final isLogged = auth.storage.getItem('isLogged');
    print('add ${isLogged}');
    final _timer = Timer(Duration(seconds: 2), () {
      if (isLogged == null) {
        Navigator.of(context).pushNamed(LoginScreen.routeName);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    return FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final isLogged = auth.storage.getItem('isLogged');

          print('shot ${snapshot.data} $isLogged');
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
        future: auth.storage.ready);
  }
}
