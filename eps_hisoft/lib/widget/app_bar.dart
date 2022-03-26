import 'dart:io';

import 'package:eps_hisoft/screens/user_info.dart';
import 'package:flutter/material.dart';

enum FilterOptions {
  User,
  Logout,
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValue) {
        if (selectedValue == FilterOptions.User) {
          Navigator.of(context).pushNamed(UserInfoScreen.routeName);
        } else {
          // productContainer.showAll();
        }
      },
      icon: Icon(Icons.more_vert),
      itemBuilder: (_) => [
        PopupMenuItem(
          child: Text('Thông tin người dùng'),
          value: FilterOptions.User,
        ),
        PopupMenuItem(
          child: Text('Đăng xuất'),
          value: FilterOptions.Logout,
        )
      ],
    );
  }
}
