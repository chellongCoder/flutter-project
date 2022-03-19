import 'package:eps_hisoft/models/ship.dart';
import 'package:eps_hisoft/utils/helper.dart';
import 'package:flutter/material.dart';

class SelectTime extends StatefulWidget {
  const SelectTime({Key? key}) : super(key: key);

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay _time = TimeOfDay.now();

  void _presentDatePicker() {
    final initialTime =
        TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);

    showTimePicker(
      context: context,
      initialTime: _time,
    ).then((value) {
      setState(() {
        _time = value ?? initialTime;
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
            width: 100,
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
                Text(
                  Helper.getTextTime(_time),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
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
