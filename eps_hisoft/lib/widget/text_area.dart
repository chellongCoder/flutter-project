import 'package:flutter/material.dart';

class TextArea extends StatelessWidget {
  TextEditingController? textController;

  TextArea({
    Key? key,
    this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ghi chú'),
        SizedBox(height: 10),
        Container(
          height: 100,
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: TextField(
            keyboardType: TextInputType.multiline,
            controller: textController,
            minLines: 5,
            maxLines: 7,
            decoration: InputDecoration(
              hintText: "Type  ",
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }
}
