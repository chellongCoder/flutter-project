import 'dart:io';

import 'package:eps_hisoft/provider/api.provider.dart';
import 'package:eps_hisoft/provider/auth.provider.dart';
import 'package:eps_hisoft/screens/home.dart';
import 'package:eps_hisoft/utils/app_log.dart';
import 'package:eps_hisoft/widget/loading_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static final routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void _handleSubmitted(BuildContext context) async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    AppLog.d(usernameController.text + " " + passwordController.text,
        tag: "TEXT");
    final username = usernameController.text;
    final password = passwordController.text;
    setState(() {
      isLoading = true;
    });
    ApiResponse _apiResponse = await auth.authenticateUser(username, password);
    print(_apiResponse.ApiError.toString());
    if ((_apiResponse.ApiError as ApiError) == null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreen.routeName,
        ModalRoute.withName(HomeScreen.routeName),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text((_apiResponse.ApiError as ApiError).error),
        backgroundColor: Colors.red,
      ));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    final auth = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: new NetworkImage(
                        'https://i.pinimg.com/originals/c2/47/e9/c247e913a0214313045a8a5c39f8522b.jpg'))),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(deviceWidth * 0.5 * 0.5),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: deviceWidth * 0.3,
                        height: deviceWidth * 0.3,
                        fit: BoxFit.fill,
                        opacity: AlwaysStoppedAnimation<double>(0.7),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: usernameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.black45,
                      hintText: 'Username',
                    ),
                    validator: (String? value) {
                      if (value == null) {
                        return 'Username is required';
                      }
                      return '';
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    style: TextStyle(color: Colors.white),
                    controller: passwordController,
                    decoration: InputDecoration(
                        filled: true,
                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.black45,
                        hintText: 'Password'),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  FlatButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot your Password?',
                        style: TextStyle(color: Colors.white),
                      )),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    '${auth.authToken.toString()}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  RaisedButton(
                    onPressed: () => _handleSubmitted(context),
                    child: Padding(
                        padding: EdgeInsets.all(15.0), child: Text('LOGIN')),
                    color: Colors.redAccent,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                          height: 8.0,
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'OR',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                          height: 8.0,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // TODO Social Icons
                      Icon(
                        Icons.facebook,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Icon(
                        Icons.gpp_good,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isLoading) LoadingGlobal(),
        ],
      ),
    );
  }
}
