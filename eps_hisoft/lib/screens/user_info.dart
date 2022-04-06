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
                auth.user?.name.substring(0, 1).toString() ?? '',
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
            children: auth.getUserFunc.entries
                .map(
                  (e) => AccordionSection(
                    scrollIntoViewOfItems: ScrollIntoViewOfItems.fast,
                    isOpen: true,
                    header: Text(e.key,
                        style: TextStyle(color: Colors.white, fontSize: 17)),
                    content: ListView(
                      shrinkWrap: true,
                      children: e.value.map((entry) {
                        return Column(
                          children: entry.entries.map((entry) {
                            var w = Row(children: [
                              Text(
                                '${entry.key}: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                entry.value.toString(),
                              ),
                            ]);
                            return w;
                          }).toList(),
                        );
                      }).toList(),
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
