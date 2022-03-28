import 'package:accordion/accordion.dart';
import 'package:eps_hisoft/provider/auth.provider.dart';
import 'package:eps_hisoft/screens/edit_profile.dart';
import 'package:eps_hisoft/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfoScreen extends StatefulWidget {
  static final routeName = '/user-info';
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfoScreen> {
  void getUser() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    await auth.getUserApi(auth.getUserId ?? '', auth.authToken);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      body: SafeArea(
          child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 100,
            width: 100,
            child: CircleAvatar(
              child: Text(
                'L',
                style: (Theme.of(context).textTheme.headline3)!
                    .merge(TextStyle(color: Colors.white)),
              ),
            ),
          ),
          Center(
            child: Text(auth.user?.name ?? '',
                style: Theme.of(context).textTheme.headline4),
          ),
          Accordion(
            disableScrolling: true,
            maxOpenSections: 2,
            leftIcon: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(EditProfileScreen.routeName);
              },
              child: Icon(Icons.edit, color: Colors.white),
            ),
            rightIcon: Row(
              children: [
                Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),
            children: [1, 2]
                .map(
                  (e) => AccordionSection(
                    scrollIntoViewOfItems: ScrollIntoViewOfItems.fast,
                    isOpen: true,
                    header: Text('Thông tin cá nhân',
                        style: TextStyle(color: Colors.white, fontSize: 17)),
                    content: Column(
                      children: [
                        Row(
                          children: [
                            Text('Email: '),
                            Text(
                              auth.user?.email ?? '',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Số điện thoại: '),
                            Text(
                              auth.user?.phone ?? '',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Ngày sinh: '),
                            Row(
                              children: [
                                Text(
                                  auth.user?.dob != null
                                      ? Helper.formatTimeZoneToString(
                                              auth.user!.dob)
                                          .toString()
                                      : '',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text('Vai trò: '),
                            Row(
                              children: [
                                Text(
                                  auth.user?.position ?? '',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text('Ngày bắt đầu làm việc: '),
                            Row(
                              children: [
                                Text(
                                  auth.user?.startWorkAt != null
                                      ? Helper.formatTimeZoneToString(
                                              auth.user!.startWorkAt)
                                          .toString()
                                      : '',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text('Nơi ở hiện tại: '),
                            Row(
                              children: [
                                Text(
                                  (auth.user?.currentLocation).toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text('Quê quán: '),
                            Row(
                              children: [
                                Text(
                                  (auth.user?.hometown).toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      )),
    );
  }
}
