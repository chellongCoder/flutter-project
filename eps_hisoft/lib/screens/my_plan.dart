import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'package:eps_hisoft/models/OT.dart';
import 'package:eps_hisoft/models/project.dart';
import 'package:eps_hisoft/provider/auth.provider.dart';
import 'package:eps_hisoft/provider/ot.provider.dart';
import 'package:eps_hisoft/provider/project.provider.dart';
import 'package:eps_hisoft/screens/new_ot.dart';
import 'package:eps_hisoft/utils/app_log.dart';
import 'package:eps_hisoft/utils/helper.dart';
import 'package:eps_hisoft/widget/my_calendar.dart';
import 'package:eps_hisoft/widget/task_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

DateRangePickerController _controller = DateRangePickerController();

class MyPlanScreen extends StatefulWidget {
  static final routeName = '/my-ot';

  const MyPlanScreen({Key? key}) : super(key: key);

  @override
  State<MyPlanScreen> createState() => _MyPlanScreenState();
}

class _MyPlanScreenState extends State<MyPlanScreen> {
  bool isShowDetail = false;
  List<DateTime> ots = [];
  List<Widget> _children = [];
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  void selectDate(DateTime time) {
    final otModel = Provider.of<OtProvider>(context, listen: false);
    final projectModel = Provider.of<ProjectProvider>(context, listen: false);

    print(ots.toString() +
        " " +
        ots.contains(time).toString() +
        " " +
        time.toString());

    List<OT> otWithTimes = otModel.ots.where((ot) {
      DateTime otTime = Helper.formatToDate(ot.from);

      if (otTime.day == time.day &&
          otTime.month == time.month &&
          otTime.year == time.year) {
        return true;
      }
      return false;
    }).toList();

    AppLog.d(otWithTimes.toString(), tag: 'otWithTime');
    setState(() {
      // The key here allows Flutter to reuse the underlying render
      // objects even if the children list is recreated.
      isShowDetail = true;
      _children = otWithTimes.map((ot) {
        Project project = projectModel.projects
            .firstWhere((element) => element.id == ot.project);

        return TaskInfo(
          projectName: project.name,
          type: 'OT',
          timeFrom: ot.from,
          timeTo: ot.to,
          note: ot.note,
        );
      }).toList();
    });
  }

  void getListOts() async {
    final otModel = Provider.of<OtProvider>(context, listen: false);
    final authModel = Provider.of<AuthProvider>(context, listen: false);
    final String bearerToken = authModel.authToken;
    AppLog.d(otModel.ots.toString(), tag: "GET LIST OT");
    await otModel.getListOT(Helper.getDateStringFirstMonth(),
        Helper.getDateStringLastMonth(), bearerToken);
    AppLog.d(otModel.ots.toString(), tag: "GET LIST OT");

    List<DateTime> _ots =
        otModel.ots.map((e) => Helper.formatToDate(e.from)).toList();

    AppLog.d(_ots.toString(), tag: "LIST DATE OT");

    setState(() {
      ots = _ots;
    });
  }

  void addNewOt() {
    Navigator.of(context).pushNamed(NewOTScreen.routeName);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _children = [];
    print(Helper.getDateStringWithDash(DateTime.now()));
    print(Helper.getDateStringFirstMonth());
    print(Helper.getDateStringLastMonth());
    getListOts();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Lịch của tôi'),
          )
        : AppBar(
            title: Text('Lịch của tôi'),
            centerTitle: true,
          );

    return Scaffold(
      appBar: appBar as PreferredSizeWidget,
      body: Center(
        child: ListView(
          children: [
            MyCalendar(
              selectDate: selectDate,
              ots: ots,
            ),
            Divider(
              color: Colors.black45,
              height: 1,
            ),
            if (isShowDetail)
              Column(
                children: List.of(_children),
              ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        openCloseDial: isDialOpen,
        backgroundColor: Theme.of(context).primaryColor,
        overlayColor: Colors.grey,
        overlayOpacity: 0.5,
        spacing: 15,
        spaceBetweenChildren: 15,
        // closeManually: true,
        children: [
          SpeedDialChild(
            child: Icon(Icons.more_time),
            label: 'OT',
            backgroundColor: Colors.white,
            onTap: addNewOt,
          ),
          SpeedDialChild(
              child: Icon(Icons.laptop_mac),
              label: 'Onsite',
              onTap: () {
                print('Mail Tapped');
              }),
          // SpeedDialChild(
          //     child: Icon(Icons.copy),
          //     label: 'Copy',
          //     onTap: () {
          //       print('Copy Tapped');
          //     }),
        ],
      ),
    );
  }
}
