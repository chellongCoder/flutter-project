import 'dart:io';

import 'package:eps_hisoft/provider/auth.provider.dart';
import 'package:eps_hisoft/screens/login.dart';
import 'package:eps_hisoft/screens/my_ot.dart';
import 'package:eps_hisoft/screens/my_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static final routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: true);

    final mediaQuery = MediaQuery.of(context);
    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Home'),
          )
        : AppBar(
            title: Text('Home'),
            centerTitle: true,
          );
    return Scaffold(
      appBar: appBar as PreferredSizeWidget,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Chức năng',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: InkWell(
                    onTap: () {
                      print('1');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyPlanScreen()),
                      );
                    },
                    child: Card(
                      child: Container(
                        child: Text(
                          'Lịch của tôi',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        width: mediaQuery.size.width * 1,
                        height: mediaQuery.size.height * 0.2,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      print('2');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyOtScreen()),
                      );
                    },
                    child: Card(
                      child: Container(
                        child: Text(
                          'Đăng ký OT',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        width: mediaQuery.size.width * 1,
                        height: mediaQuery.size.height * 0.2,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: GestureDetector(
                    onTap: () {
                      print('3');
                    },
                    child: Card(
                      child: Container(
                        child: FittedBox(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Đăng ký ONSITE',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ),
                        ),
                        width: mediaQuery.size.width * 1,
                        height: mediaQuery.size.height * 0.2,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: InkWell(
                    onTap: () {
                      auth.logout();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        LoginScreen.routeName,
                        ModalRoute.withName(LoginScreen.routeName),
                      );
                    },
                    child: Text(
                      'logout',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
