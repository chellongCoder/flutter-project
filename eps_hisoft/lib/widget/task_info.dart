import 'package:flutter/material.dart';

class TaskInfo extends StatelessWidget {
  final String type;
  final String projectName;
  final String timeFrom;
  final String timeTo;
  final String note;
  const TaskInfo({
    Key? key,
    required this.type,
    required this.projectName,
    required this.timeFrom,
    required this.timeTo,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text('[$type]'),
              SizedBox(
                width: 10,
              ),
              Text('Dự án: '),
              SizedBox(
                width: 10,
              ),
              Text('$projectName', style: Theme.of(context).textTheme.bodyText1)
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Thời gian:', style: Theme.of(context).textTheme.caption),
              Text('$timeFrom ~ $timeTo')
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Note: ', style: Theme.of(context).textTheme.caption),
              Text('$note', style: Theme.of(context).textTheme.headline6)
            ],
          ),
          Divider(
            color: Colors.black45,
            height: 1,
          ),
        ],
      ),
    );
  }
}
