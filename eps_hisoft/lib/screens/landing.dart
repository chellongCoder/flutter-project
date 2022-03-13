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

  late bool _isLogged;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('authToken') ?? '';
    print('${authToken}');
    auth.setAuthToken = authToken;
    if (authToken == '') {
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.routeName,
        ModalRoute.withName(LoginScreen.routeName),
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreen.routeName,
        ModalRoute.withName(HomeScreen.routeName),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
