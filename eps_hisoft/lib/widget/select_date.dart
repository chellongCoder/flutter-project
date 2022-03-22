import 'package:eps_hisoft/models/select_date.dart';
import 'package:eps_hisoft/models/ship.dart';
import 'package:eps_hisoft/utils/helper.dart';
import 'package:flutter/material.dart';

class SelectDate extends StatefulWidget {
  final double? width;
  final String? label;
  final DateTime? date;
  final Function(DateTime? time)? selectDate;
  final SelectDateController? controller;

  const SelectDate(
      {Key? key,
      this.width,
      this.label,
      this.date,
      this.selectDate,
      this.controller})
      : super(key: key);

  @override
  State<SelectDate> createState() => _SelectDateState(date);
}

class _SelectDateState extends State<SelectDate> {
  DateTime? _selectedDate;

  _SelectDateState(this._selectedDate);

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      setState(() {
        _selectedDate = value ?? _selectedDate;
      });
      widget.controller?.setValue(value);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller?.setValue(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) Text(widget.label ?? ''),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: _presentDatePicker,
          child: Container(
            width: widget.width ?? 200,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_selectedDate != null)
                  Text(
                    Helper.formatDateToStringNoHour(_selectedDate!),
                  )
                else
                  Text(
                    'Chọn ngày',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
