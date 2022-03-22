import 'package:eps_hisoft/models/select_time.dart';
import 'package:eps_hisoft/models/ship.dart';
import 'package:eps_hisoft/utils/app_log.dart';
import 'package:eps_hisoft/utils/helper.dart';
import 'package:flutter/material.dart';

class SelectTime extends StatefulWidget {
  final SelectTimeController? controller;

  const SelectTime({Key? key, this.controller}) : super(key: key);

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay? _time;

  void _presentDatePicker() {
    final initialTime =
        TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);

    showTimePicker(
      context: context,
      initialTime: _time ?? TimeOfDay.now(),
    ).then((value) {
      widget.controller?.setValue(value);
      setState(() {
        _time = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Giờ'),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: _presentDatePicker,
          child: Container(
            width: 150,
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
                if (_time != null)
                  Text(
                    Helper.getTextTime(_time!),
                  )
                else
                  Text(
                    'Chọn giờ',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.lock_clock_outlined,
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
