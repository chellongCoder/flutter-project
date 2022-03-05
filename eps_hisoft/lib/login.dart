import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(deviceWidth * 0.5 * 0.5),
              child: Image.asset(
                'assets/images/logo.png',
                width: deviceWidth * 0.5,
                height: deviceWidth * 0.5,
                fit: BoxFit.fill,
              ),
            ),
            CupertinoTextField(
              placeholder: "Enter Email",
              prefix: Icon(CupertinoIcons.person),
              suffix: Icon(CupertinoIcons.check_mark_circled),
              keyboardType: TextInputType.text,
            ),
            CupertinoTextField(
              prefix: Icon(CupertinoIcons.lock),
              suffix: Icon(CupertinoIcons.check_mark_circled),
              keyboardType: TextInputType.text,
              obscureText: true,
              placeholder: "Enter Password",
            ),
            Platform.isIOS
                ? CupertinoButton.filled(
                    onPressed: () {},
                    child: const Text('Login'),
                  )
                : RaisedButton(
                    onPressed: () {},
                    child: Text('Search'),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.all(20),
                  ),
          ],
        );
      },
    );
  }
}
