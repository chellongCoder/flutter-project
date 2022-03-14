import 'dart:io';
import 'dart:math';
import 'package:eps_hisoft/utils/helper.dart';
import 'package:eps_hisoft/widget/month_cell_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

DateRangePickerController _controller = DateRangePickerController();

class MyPlanScreen extends StatelessWidget {
  static final routeName = '/my-ot';

  const MyPlanScreen({Key? key}) : super(key: key);
  List<DateTime> _getSpecialDates() {
    final List<DateTime> dates = <DateTime>[];
    final DateTime startDate =
        DateTime.now().subtract(const Duration(days: 200));
    final DateTime endDate = DateTime.now().add(const Duration(days: 500));
    final Random random = Random();
    for (DateTime date = startDate;
        date.isBefore(endDate);
        date = date.add(const Duration(days: 25))) {
      for (int i = 0; i < 3; i++) {
        dates.add(date.add(Duration(days: random.nextInt(i + 4))));
      }
    }

    return dates;
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> specialDates = _getSpecialDates();

    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Lịch của tôi'),
          )
        : AppBar(
            title: Text('Lịch của tôi'),
            centerTitle: true,
          );
    final Color monthCellBackground =
        Helper().isDark ? const Color(0xFF232731) : const Color(0xfff7f4ff);
    final Color indicatorColor =
        Helper().isDark ? const Color(0xFF5CFFB7) : const Color(0xFF1AC4C7);
    final Color highlightColor =
        Helper().isDark ? const Color(0xFF5CFFB7) : Colors.deepPurpleAccent;
    final Color cellTextColor =
        Helper().isDark ? const Color(0xFFDFD4FF) : const Color(0xFF130438);
    return Scaffold(
      appBar: appBar as PreferredSizeWidget,
      body: Center(
        child: ListView(
          children: [
            GestureDetector(
              child: SfDateRangePicker(
                onSelectionChanged:
                    (DateRangePickerSelectionChangedArgs args) {},
                // selectionMode: DateRangePickerSelectionMode.multiple,

                monthViewSettings: DateRangePickerMonthViewSettings(
                  firstDayOfWeek: 1,
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                      textStyle: TextStyle(
                          fontSize: 10,
                          color: const Color(0xFF130438),
                          fontWeight: FontWeight.w600)),
                  dayFormat: 'EEE',
                  showTrailingAndLeadingDates: false,
                  specialDates: specialDates,
                ),
                monthCellStyle: DateRangePickerMonthCellStyle(
                    cellDecoration: MonthCellDecoration(
                        borderColor: null,
                        backgroundColor: monthCellBackground,
                        showIndicator: false,
                        indicatorColor: indicatorColor),
                    todayCellDecoration: MonthCellDecoration(
                        borderColor: highlightColor,
                        backgroundColor: monthCellBackground,
                        showIndicator: false,
                        indicatorColor: indicatorColor),
                    specialDatesDecoration: MonthCellDecoration(
                        borderColor: null,
                        backgroundColor: monthCellBackground,
                        showIndicator: true,
                        indicatorColor: indicatorColor),
                    disabledDatesTextStyle: TextStyle(
                      color: Helper().isDark
                          ? const Color(0xFF666479)
                          : const Color(0xffe2d7fe),
                    ),
                    weekendTextStyle: TextStyle(
                      color: highlightColor,
                    ),
                    textStyle: TextStyle(color: cellTextColor, fontSize: 14),
                    specialDatesTextStyle:
                        TextStyle(color: cellTextColor, fontSize: 14),
                    todayTextStyle:
                        TextStyle(color: highlightColor, fontSize: 14)),
                yearCellStyle: DateRangePickerYearCellStyle(
                  todayTextStyle:
                      TextStyle(color: highlightColor, fontSize: 14),
                  textStyle: TextStyle(color: cellTextColor, fontSize: 14),
                  disabledDatesTextStyle: TextStyle(
                      color: Helper().isDark
                          ? const Color(0xFF666479)
                          : const Color(0xffe2d7fe)),
                  leadingDatesTextStyle: TextStyle(
                      color: cellTextColor.withOpacity(0.5), fontSize: 14),
                ),
                // cellBuilder: (BuildContext context,
                //     DateRangePickerCellDetails cellDetails) {
                //   return Container(
                //     width: cellDetails.bounds.width,
                //     height: cellDetails.bounds.height,
                //     alignment: Alignment.center,
                //     child: Column(
                //       children: [
                //         Text(
                //           (cellDetails.date.day.toString()),
                //         ),
                //         Container(
                //           decoration: BoxDecoration(
                //               color: Colors.red,
                //               borderRadius: BorderRadius.all(
                //                 Radius.circular(10),
                //               )),
                //           width: 10,
                //           height: 10,
                //         )
                //       ],
                //     ),
                //   );
                // },
                selectionColor: Colors.amberAccent,
              ),
            ),
            Divider(
              color: Colors.black45,
              height: 1,
            ),
            Expanded(
              child: Text('data'),
            )
          ],
        ),
      ),
    );
  }
}
