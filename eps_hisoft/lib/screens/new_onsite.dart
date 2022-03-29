import 'dart:io';

import 'package:eps_hisoft/models/select_date.dart';
import 'package:eps_hisoft/models/select_project.dart';
import 'package:eps_hisoft/models/select_time.dart';
import 'package:eps_hisoft/provider/api.provider.dart';
import 'package:eps_hisoft/provider/auth.provider.dart';
import 'package:eps_hisoft/provider/onsite.provider.dart';
import 'package:eps_hisoft/utils/app_log.dart';
import 'package:eps_hisoft/utils/helper.dart';
import 'package:eps_hisoft/widget/loading_global.dart';
import 'package:eps_hisoft/widget/select_date.dart';
import 'package:eps_hisoft/widget/select_project.dart';
import 'package:eps_hisoft/widget/select_time.dart';
import 'package:eps_hisoft/widget/text_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewOnsiteScreen extends StatefulWidget {
  static final routeName = '/new-onsite';

  const NewOnsiteScreen({Key? key}) : super(key: key);

  @override
  State<NewOnsiteScreen> createState() => _NewOnsiteScreenState();
}

class _NewOnsiteScreenState extends State<NewOnsiteScreen> {
  late SelectProjectController selectProjectController;
  bool isLoading = false;

  final dateController = SelectDateController();
  final timeToController = SelectTimeController();
  final timeFromController = SelectTimeController();
  final noteController = TextEditingController();

  void onSubmitOnsite() async {
    final authModel = Provider.of<AuthProvider>(context, listen: false);
    final onsiteModel = Provider.of<OnsiteProvider>(context, listen: false);

    try {
      setState(() {
        isLoading = true;
      });
      AppLog.d(dateController.date.toString(), tag: 'date');
      AppLog.d(selectProjectController.project.toString(), tag: 'project');
      AppLog.d(timeFromController.time.toString(), tag: 'time from');
      AppLog.d(timeToController.time.toString(), tag: 'time to');
      AppLog.d(noteController.text.toString(), tag: 'note');

      selectProjectController.verify();

      final formatFromTime = Helper.getTextTime(timeFromController.time!);
      final formatToTime = Helper.getTextTime(timeToController.time!);

      String start = '$formatFromTime';
      String end = '$formatToTime';
      String projectId = selectProjectController.project?.id ?? '';
      String otDate = dateController.date != null
          ? Helper.formatToDateTimeZone(dateController.date!)
          : '';
      String note = noteController.text;

      ApiResponse _apiResponse = await onsiteModel.createNewOnsite(
        start,
        end,
        projectId,
        note,
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
      final String bearerToken = authModel.authToken;

      await onsiteModel.getListOnsite(Helper.getDateStringFirstMonth(),
          Helper.getDateStringLastMonth(), bearerToken);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    selectProjectController.setHasError(false);
  }

  @override
  Widget build(BuildContext context) {
    selectProjectController =
        Provider.of<SelectProjectController>(context, listen: false);

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SelectDate(
                      label: 'Ngày',
                      controller: dateController,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SelectTime(
                      label: 'Thời gian bắt đầu',
                      controller: timeFromController,
                    ),
                    SelectTime(
                      label: 'Thời gian kết thúc',
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
        onPressed: onSubmitOnsite,
        icon: Icon(Icons.save),
        label: Text("SAVE"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
