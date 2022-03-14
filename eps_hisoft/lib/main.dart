import 'dart:io';
import 'package:eps_hisoft/provider/auth.provider.dart';
import 'package:eps_hisoft/screens/home.dart';
import 'package:eps_hisoft/screens/landing.dart';
import 'package:eps_hisoft/screens/login.dart';
import 'package:eps_hisoft/screens/my_ot.dart';
import 'package:eps_hisoft/screens/my_plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Quicksand',
          primarySwatch: Colors.blue,
        ),
        initialRoute: Landing.routeName,
        routes: {
          // '/': (ctx) => LoginScreen(),
          Landing.routeName: (ctx) => Landing(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          MyOtScreen.routeName: (ctx) => MyOtScreen(),
          MyPlanScreen.routeName: (ctx) => MyPlanScreen(),
        },
      ),
    );
  }
}
