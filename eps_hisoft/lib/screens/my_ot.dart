import 'dart:io';
import 'package:accordion/accordion.dart';
import 'package:eps_hisoft/models/OT.dart';
import 'package:eps_hisoft/models/select_date.dart';
import 'package:eps_hisoft/provider/auth.provider.dart';
import 'package:eps_hisoft/provider/ot.provider.dart';
import 'package:eps_hisoft/provider/project.provider.dart';
import 'package:eps_hisoft/utils/app_log.dart';
import 'package:eps_hisoft/utils/helper.dart';
import 'package:eps_hisoft/widget/select_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyOtScreen extends StatefulWidget {
  static final routeName = '/my-ot';

  const MyOtScreen({Key? key}) : super(key: key);

  @override
  State<MyOtScreen> createState() => _MyOtScreenState();
}

class _MyOtScreenState extends State<MyOtScreen> {
  final fromDateController = SelectDateController();
  final toDateController = SelectDateController();

  void getListOts([DateTime? fromDate, DateTime? toDate]) async {
    final otModel = Provider.of<OtProvider>(context, listen: false);
    final authModel = Provider.of<AuthProvider>(context, listen: false);
    final String bearerToken = authModel.authToken;
    AppLog.d(otModel.ots.toString(), tag: "GET LIST OT");
    await otModel.getListOT(
      fromDate != null
          ? Helper.getDateStringWithDash(fromDate)
          : Helper.getDateStringFirstMonth(),
      toDate != null
          ? Helper.getDateStringWithDash(toDate)
          : Helper.getDateStringLastMonth(),
      bearerToken,
    );
    AppLog.d(otModel.ots.toString(), tag: "GET LIST OT");

    List<DateTime> _ots =
        otModel.ots.map((e) => Helper.formatToDate(e.from)).toList();

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

    getListOts(
      fromDate,
      toDate,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListOts();
  }

  @override
  Widget build(BuildContext context) {
    final otModel = Provider.of<OtProvider>(context, listen: true);
    final projectModel = Provider.of<ProjectProvider>(context, listen: false);

    final _loremIpsum =
        '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum', a 1st century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.''';

    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('My OT'),
          )
        : AppBar(
            title: Text('My OT'),
            centerTitle: true,
          );

    return Scaffold(
      appBar: appBar as PreferredSizeWidget,
      body: Center(
        child: ListView(
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
                  date: DateTime(
                      DateTime.now().year, DateTime.now().month + 1, 0),
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
              maxOpenSections: 2,
              leftIcon: Icon(Icons.timelapse, color: Colors.white),
              children: otModel.ots
                  .map(
                    (OT e) => AccordionSection(
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
                              Text('Ca: '),
                              Text(
                                e.ship,
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Icon(Icons.arrow_right_alt),
                                  Text(
                                    e.to,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
