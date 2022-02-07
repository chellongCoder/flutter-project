import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/answer.dart';
import 'package:flutter_complete_guide/quiz.dart';
import 'package:flutter_complete_guide/result.dart';
import '/question.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  var totalScore = 0;

  void answerQuestion() {
    print("Answer 1");
    setState(() {
      _questionIndex = 0;
    });
  }

  void resetQuiz() {
    setState(() {
      _questionIndex = 0;
      totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _questions = [
      {
        'questionText': 'What \'s your favorite color? ',
        'answers': [
          {'text': 'Black', 'score': 1},
          {'text': 'Green', 'score': 1},
          {'text': 'Blue', 'score': 1},
          {'text': 'White', 'score': 1}
        ],
      },
      {
        'questionText': 'What \'s your favorite animal? ',
        'answers': [
          {'text': 'Black', 'score': 1},
          {'text': 'Green', 'score': 1},
          {'text': 'Blue', 'score': 1},
          {'text': 'White', 'score': 1}
        ],
      },
      {
        'questionText': 'What \'s your favorite movie? ',
        'answers': [
          {'text': 'Black', 'score': 1},
          {'text': 'Green', 'score': 1},
          {'text': 'Blue', 'score': 1},
          {'text': 'White', 'score': 1}
        ],
      }
    ];
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                questions: _questions,
                questionIndex: _questionIndex,
                answerQuestion: (int score) {
                  print('The values are: ${[_questionIndex, score]}');
                  totalScore = totalScore + score;
                  setState(() {
                    _questionIndex = _questionIndex + 1;
                  });
                })
            : Result(totalScore: totalScore, resetHandler: resetQuiz),
      ),
    );
  }
}
