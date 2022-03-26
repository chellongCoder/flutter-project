import 'dart:io';

import 'package:eps_hisoft/provider/auth.provider.dart';
import 'package:eps_hisoft/provider/project.provider.dart';
import 'package:eps_hisoft/screens/login.dart';
import 'package:eps_hisoft/screens/my_onsite.dart';
import 'package:eps_hisoft/screens/my_ot.dart';
import 'package:eps_hisoft/screens/my_plan.dart';
import 'package:eps_hisoft/screens/user_info.dart';
import 'package:eps_hisoft/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  User,
  Logout,
}

class HomeScreen extends StatefulWidget {
  static final routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void getProjects() async {
    final projectModel = Provider.of<ProjectProvider>(context, listen: false);
    final authModel = Provider.of<AuthProvider>(context, listen: false);

    await projectModel.getListProjects(authModel.authToken);
  }

  void onLogout(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Thông báo'),
        message: const Text('Bạn có chắc muốn đăng xuất?'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text('Đồng ý'),
            onPressed: () {
              auth.logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                LoginScreen.routeName,
                ModalRoute.withName(LoginScreen.routeName),
              );
            },
          ),
          CupertinoActionSheetAction(
            child: const Text(
              'Hủy',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProjects();
  }

  void _showPopupMenu(BuildContext context) async {
    final mediaQuery = MediaQuery.of(context);

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(mediaQuery.size.width, 10, 10, 10),
      items: [
        PopupMenuItem<String>(
          child: const Text('Thông tin cá nhân'),
          value: 'Doge',
          onTap: () => Future(
            () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => UserInfoScreen()),
            ),
          ),
        ),
        PopupMenuItem<String>(child: const Text('Đăng xuất'), value: 'Lion'),
      ],
      elevation: 8.0,
      useRootNavigator: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: true);

    final mediaQuery = MediaQuery.of(context);
    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Home'),
            trailing: GestureDetector(
              child: Icon(Icons.more_vert),
              onTap: () {
                _showPopupMenu(context);
              },
            ))
        : AppBar(
            title: Text('Home'),
            centerTitle: true,
            actions: <Widget>[
              PopupMenuButton(
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
              )
            ],
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyOnsiteScreen()),
                      );
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
                    onTap: () => onLogout(context),
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
