import 'dart:developer';

import 'package:eps_hisoft/provider/ot.provider.dart';
import 'package:eps_hisoft/utils/helper.dart';
import 'package:eps_hisoft/widget/month_cell_decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class MyCalendar extends StatelessWidget {
  final Function(DateTime time) selectDate;
  final List<DateTime> ots;
  const MyCalendar({Key? key, required this.selectDate, required this.ots})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color monthCellBackground =
        Helper().isDark ? const Color(0xFF232731) : const Color(0xfff7f4ff);
    final Color indicatorColor =
        Helper().isDark ? const Color(0xFF5CFFB7) : Colors.blue;
    final Color highlightColor =
        Helper().isDark ? const Color(0xFF5CFFB7) : Colors.deepPurpleAccent;
    final Color cellTextColor =
        Helper().isDark ? const Color(0xFFDFD4FF) : const Color(0xFF130438);

    return GestureDetector(
      child: SfDateRangePicker(
        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
          print(args.value);
          selectDate(args.value);
        },

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
          specialDates: ots,
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
            todayTextStyle: TextStyle(color: highlightColor, fontSize: 14)),
        yearCellStyle: DateRangePickerYearCellStyle(
          todayTextStyle: TextStyle(color: highlightColor, fontSize: 14),
          textStyle: TextStyle(color: cellTextColor, fontSize: 14),
          disabledDatesTextStyle: TextStyle(
              color: Helper().isDark
                  ? const Color(0xFF666479)
                  : const Color(0xffe2d7fe)),
          leadingDatesTextStyle:
              TextStyle(color: cellTextColor.withOpacity(0.5), fontSize: 14),
        ),

        selectionColor: Colors.amberAccent,
      ),
    );
  }
}
