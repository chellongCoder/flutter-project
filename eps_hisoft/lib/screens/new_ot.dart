import 'dart:io';

import 'package:eps_hisoft/provider/auth.provider.dart';
import 'package:eps_hisoft/provider/project.provider.dart';
import 'package:eps_hisoft/widget/select_date.dart';
import 'package:eps_hisoft/widget/select_project.dart';
import 'package:eps_hisoft/widget/select_ship.dart';
import 'package:eps_hisoft/widget/select_time.dart';
import 'package:eps_hisoft/widget/text_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewOTScreen extends StatefulWidget {
  static final routeName = '/new-ot';

  const NewOTScreen({Key? key}) : super(key: key);

  @override
  State<NewOTScreen> createState() => _NewOTScreenState();
}

class _NewOTScreenState extends State<NewOTScreen> {
  int selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Đăng ký OT'),
          )
        : AppBar(
            title: Text('Đăng ký OT'),
            centerTitle: true,
          );
    return Scaffold(
      appBar: appBar as PreferredSizeWidget,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectProject(),
            SizedBox(
              height: 10,
            ),
            SelectShip(),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectDate(
                  label: 'Thời gian bắt đầu',
                ),
                SelectTime(),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectDate(
                  label: 'Thời gian kết thúc',
                ),
                SelectTime(),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextArea(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.save),
        label: Text("SAVE"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
