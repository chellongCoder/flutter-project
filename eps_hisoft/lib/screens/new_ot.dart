import 'dart:io';

import 'package:eps_hisoft/models/select_date.dart';
import 'package:eps_hisoft/models/select_project.dart';
import 'package:eps_hisoft/models/select_ship.dart';
import 'package:eps_hisoft/models/select_time.dart';
import 'package:eps_hisoft/provider/api.provider.dart';
import 'package:eps_hisoft/provider/auth.provider.dart';
import 'package:eps_hisoft/provider/ot.provider.dart';
import 'package:eps_hisoft/provider/project.provider.dart';
import 'package:eps_hisoft/utils/app_log.dart';
import 'package:eps_hisoft/utils/helper.dart';
import 'package:eps_hisoft/widget/loading_global.dart';
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
  late SelectProjectController selectProjectController;
  late SelectShipController selectShipController;
  bool isLoading = false;

  int selectedValue = 0;
  final fromDateController = SelectDateController();
  final toDateController = SelectDateController();
  final timeToController = SelectTimeController();
  final timeFromController = SelectTimeController();
  final noteController = TextEditingController();

  void onSubmitOt() async {
    final otModel = Provider.of<OtProvider>(context, listen: false);
    final authModel = Provider.of<AuthProvider>(context, listen: false);

    try {
      setState(() {
        isLoading = true;
      });
      selectProjectController.verify();
      selectShipController.verify();

      AppLog.d(fromDateController.date.toString(), tag: 'from');
      AppLog.d(toDateController.date.toString(), tag: 'to');
      AppLog.d(selectProjectController.project.toString(), tag: 'project');
      AppLog.d(timeFromController.time.toString(), tag: 'time from');
      AppLog.d(timeToController.time.toString(), tag: 'time to');
      AppLog.d(noteController.text.toString(), tag: 'note');
      AppLog.d(selectShipController.ship.toString(), tag: 'ship');

      final formatFromTime = Helper.getTextTime(timeFromController.time!);
      final formatToTime = Helper.getTextTime(timeToController.time!);

      final formatFromDate =
          Helper.formatDateToStringNoHour(fromDateController.date!);
      final formatToDate =
          Helper.formatDateToStringNoHour(toDateController.date!);

      String start = '$formatFromDate $formatFromTime';
      String end = '$formatToDate $formatToTime';
      String projectId = selectProjectController.project?.id ?? '';
      String otDate = fromDateController.date != null
          ? Helper.formatToDateTimeZone(fromDateController.date!)
          : '';
      String ship = selectShipController.ship.toString().split(".").last;
      String note = noteController.text;

      AppLog.d(otDate.toString(), tag: 'otDate');

      ApiResponse _apiResponse = await otModel.createNewOT(
        start,
        end,
        projectId,
        note,
        ship,
        otDate,
        authModel.authToken,
      );
      if ((_apiResponse.ApiError as ApiError) == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Success'),
          backgroundColor: Colors.green,
        ));
      } else {
        Helper.showError(context, (_apiResponse.ApiError as ApiError).error);
      }
    } catch (e) {
      AppLog.e(e.toString(), tag: 'error');
      Helper.showError(context, 'Có lỗi xảy ra, vui lòng thử lại!');
    } finally {
      setState(() {
        isLoading = false;
      });
      await otModel.getListOT(
        Helper.getDateStringFirstMonth(),
        Helper.getDateStringLastMonth(),
        authModel.authToken,
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    selectProjectController.setHasError(false);
    selectShipController.setHasError(false);
  }

  @override
  Widget build(BuildContext context) {
    selectProjectController =
        Provider.of<SelectProjectController>(context, listen: false);
    selectShipController =
        Provider.of<SelectShipController>(context, listen: false);
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectProject(
                  controller: selectProjectController,
                ),
                SizedBox(
                  height: 10,
                ),
                SelectShip(
                  controller: selectShipController,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SelectDate(
                      label: 'Thời gian bắt đầu',
                      controller: fromDateController,
                    ),
                    SelectTime(
                      controller: timeFromController,
                    ),
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
                      controller: toDateController,
                    ),
                    SelectTime(
                      controller: timeToController,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextArea(
                  textController: noteController,
                ),
              ],
            ),
          ),
          if (isLoading) LoadingGlobal(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onSubmitOt,
        icon: Icon(Icons.save),
        label: Text("SAVE"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
