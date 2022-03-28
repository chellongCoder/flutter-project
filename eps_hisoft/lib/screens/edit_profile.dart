import 'dart:io';

import 'package:eps_hisoft/provider/auth.provider.dart';
import 'package:eps_hisoft/utils/helper.dart';
import 'package:eps_hisoft/widget/form_validate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  static final routeName = '/edit-profile';

  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: true);

    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Sửa thông tin'),
          )
        : AppBar(
            title: Text('Sửa thông tin'),
            centerTitle: true,
          );
    return Scaffold(
      appBar: appBar as PreferredSizeWidget,
      body: Container(
        child: ListView(
          children: [
            FormValidate(
              email: auth.user!.email,
              phone: auth.user!.phone,
              dob: Helper.formatTimeZoneToDate(auth.user!.dob),
              currentLocation: auth.user!.currentLocation,
              homeTown: auth.user!.hometown,
            ),
          ],
        ),
      ),
    );
  }
}
