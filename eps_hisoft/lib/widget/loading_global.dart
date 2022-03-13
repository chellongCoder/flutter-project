import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingGlobal extends StatelessWidget {
  const LoadingGlobal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      width: deviceWidth,
      height: deviceHeight,
      color: Colors.black54,
      child: Center(
        child: SizedBox(
          child: Theme(
            data: ThemeData(
                cupertinoOverrideTheme:
                    CupertinoThemeData(brightness: Brightness.dark)),
            child: Platform.isIOS
                ? CupertinoActivityIndicator()
                : CircularProgressIndicator(),
          ),
          height: 30.0,
          width: 30.0,
        ),
      ),
    );
  }
}
