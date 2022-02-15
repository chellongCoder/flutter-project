import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MyPlanScreen extends StatelessWidget {
  const MyPlanScreen({Key? key}) : super(key: key);

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
            // ElevatedButton(
            //   onPressed: () {
            //     // Navigate back to first route when tapped.
            //   },
            //   child: const Text('Go back!'),
            // ),
            GestureDetector(
              child: SfDateRangePicker(
                onSelectionChanged:
                    (DateRangePickerSelectionChangedArgs args) {},
                selectionMode: DateRangePickerSelectionMode.multiple,
                initialSelectedDates: [
                  DateTime.now().subtract(const Duration(days: 3)),
                  DateTime.now().subtract(const Duration(days: 4)),
                ],

                selectionColor: Colors.amberAccent,
                // initialSelectedRange: PickerDateRange(
                //   DateTime.now().subtract(const Duration(days: 4)),
                //   DateTime.now().add(const Duration(days: 3)),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
