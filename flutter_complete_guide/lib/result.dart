import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result({
    Key? key,
    required this.totalScore,
    required this.resetHandler,
  }) : super(key: key);

  final int totalScore;
  final VoidCallback resetHandler;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('your did it! ${totalScore}'),
          FlatButton(onPressed: resetHandler, child: Text('Reset')),
          RaisedButton(
            onPressed: () {},
            child: Text('Raised Button'),
            color: Colors.blue,
            textColor: Colors.white,
          ),
          FlatButton(
            onPressed: () {},
            child: Text('Flat Button'),
            textColor: Colors.blue,
          ),
          OutlineButton(
            onPressed: () {},
            child: Text('Outline Button'),
            borderSide: BorderSide(color: Colors.blue),
            textColor: Colors.blue,
          ),
          ElevatedButton(
            child: Text('Elevated Button'),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.red,
              primary: Colors.amber,
            ),
          ),
          CupertinoButton(
            child: Text('Cupertino Button'),
            onPressed: () {},
          ),
          TextButton(
            child: Text('Text Button'),
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              textStyle: MaterialStateProperty.all(
                const TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(1, 2, 3, 4),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
