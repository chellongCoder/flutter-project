import 'dart:io';

import 'package:accordion/accordion.dart';
import 'package:eps_hisoft/models/onsite.dart';
import 'package:eps_hisoft/models/select_date.dart';
import 'package:eps_hisoft/provider/auth.provider.dart';
import 'package:eps_hisoft/provider/onsite.provider.dart';
import 'package:eps_hisoft/provider/project.provider.dart';
import 'package:eps_hisoft/utils/app_log.dart';
import 'package:eps_hisoft/utils/helper.dart';
import 'package:eps_hisoft/widget/select_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyOnsiteScreen extends StatefulWidget {
  static final routeName = '/my-onsite';
  const MyOnsiteScreen({Key? key}) : super(key: key);

  @override
  State<MyOnsiteScreen> createState() => _MyOnsiteState();
}

class _MyOnsiteState extends State<MyOnsiteScreen> {
  final fromDateController = SelectDateController();
  final toDateController = SelectDateController();

  void getListOnsites([DateTime? fromDate, DateTime? toDate]) async {
    final onsiteModel = Provider.of<OnsiteProvider>(context, listen: false);
    final authModel = Provider.of<AuthProvider>(context, listen: false);
    final String bearerToken = authModel.authToken;

    await onsiteModel.getListOnsite(
      fromDate != null
          ? Helper.getDateStringWithDash(fromDate)
          : Helper.getDateStringFirstMonth(),
      toDate != null
          ? Helper.getDateStringWithDash(toDate)
          : Helper.getDateStringLastMonth(),
      bearerToken,
    );

    List<DateTime> _ots =
        onsiteModel.onsites.map((e) => Helper.formatToDate(e.from)).toList();

    AppLog.d(_ots.toString(), tag: "LIST DATE OT");
  }

  void onSearch() {
    AppLog.d(
        fromDateController.date.toString() +
            " " +
            toDateController.date.toString(),
        tag: "FROMDATECONTROLLER");

    DateTime? fromDate = fromDateController.date;
    DateTime? toDate = toDateController.date;

    getListOnsites(
      fromDate,
      toDate,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListOnsites();
  }

  @override
  Widget build(BuildContext context) {
    final onsiteModel = Provider.of<OnsiteProvider>(context, listen: true);
    final projectModel = Provider.of<ProjectProvider>(context, listen: false);

    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Đăng ký Onsite'),
          )
        : AppBar(
            title: Text('Đăng ký Onsite'),
            centerTitle: true,
          );
    return Scaffold(
      appBar: appBar as PreferredSizeWidget,
      body: ListView(
        shrinkWrap: true, //just set this property

        children: [
          Text('Thời gian', style: Theme.of(context).textTheme.headline5),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SelectDate(
                width: 150,
                date: DateTime(DateTime.now().year, DateTime.now().month, 1),
                controller: fromDateController,
              ),
              Icon(
                Icons.arrow_right_alt,
                color: Theme.of(context).primaryColor,
              ),
              SelectDate(
                width: 150,
                date:
                    DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
                controller: toDateController,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Platform.isIOS
                ? CupertinoButton.filled(
                    onPressed: onSearch,
                    child: const Text('Search'),
                  )
                : RaisedButton(
                    onPressed: onSearch,
                    child: Text('Search'),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.all(20),
                  ),
          ),
          Accordion(
            disableScrolling: true,
            maxOpenSections: 2,
            leftIcon: Icon(Icons.timelapse, color: Colors.white),
            children: onsiteModel.onsites
                .map(
                  (Onsite e) => AccordionSection(
                    isOpen: true,
                    header: Text(e.from,
                        style: TextStyle(color: Colors.white, fontSize: 17)),
                    content: Column(
                      children: [
                        Row(
                          children: [
                            Text('Dự án: '),
                            Text(
                              projectModel.projects
                                  .firstWhere(
                                      (element) => element.id == e.project)
                                  .name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Thời gian: '),
                            Row(
                              children: [
                                Text(
                                  e.from,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Icon(Icons.arrow_right_alt),
                                Text(
                                  e.to,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Ghi chú: '),
                            Flexible(
                                child: Text(
                              '${e.note}',
                              maxLines: 3,
                              style: Theme.of(context).textTheme.overline,
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
