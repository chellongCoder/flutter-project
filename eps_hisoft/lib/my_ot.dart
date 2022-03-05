import 'dart:io';
import 'package:accordion/accordion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyOtScreen extends StatefulWidget {
  const MyOtScreen({Key? key}) : super(key: key);

  @override
  State<MyOtScreen> createState() => _MyOtScreenState();
}

class _MyOtScreenState extends State<MyOtScreen> {
  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    final _loremIpsum =
        '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum', a 1st century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.''';
    final _headerStyle = TextStyle(
        color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
    final _contentStyleHeader = TextStyle(
        color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
    final _contentStyle = TextStyle(
        color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('My OT'),
          )
        : AppBar(
            title: Text('My OT'),
            centerTitle: true,
          );

    return Scaffold(
      appBar: appBar as PreferredSizeWidget,
      body: Center(
        child: ListView(
          children: [
            Text('Thời gian', style: Theme.of(context).textTheme.headline5),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    print("1");
                    _presentDatePicker();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text('10/10/2020'),
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
                ),
                Icon(
                  Icons.arrow_right_alt,
                  color: Theme.of(context).primaryColor,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  child: Row(
                    children: [
                      Text('10/10/2020'),
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
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Platform.isIOS
                  ? CupertinoButton.filled(
                      onPressed: () {},
                      child: const Text('Search'),
                    )
                  : RaisedButton(
                      onPressed: () {},
                      child: Text('Search'),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      padding: EdgeInsets.all(20),
                    ),
            ),
            Accordion(
              maxOpenSections: 2,
              leftIcon: Icon(Icons.timelapse, color: Colors.white),
              children: [
                AccordionSection(
                  isOpen: true,
                  header: Text('10/11/2021',
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                  content: Column(
                    children: [
                      Row(
                        children: [
                          Text('Dự án: '),
                          Text(
                            'Project',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Ca: '),
                          Text(
                            'Tối',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Thời gian: '),
                          Row(
                            children: [
                              Text(
                                '11/11/2020 22:20',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.arrow_right_alt),
                              Text(
                                '12/11/2020 22:20',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ghi chú: '),
                          Flexible(
                              child: Text(
                            '$_loremIpsum',
                            maxLines: 3,
                            style: Theme.of(context).textTheme.overline,
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
                AccordionSection(
                  isOpen: true,
                  header: Text('11/11/2021',
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                  content: Icon(Icons.airline_seat_flat,
                      size: 120, color: Colors.blue[200]),
                ),
                AccordionSection(
                  isOpen: true,
                  header: Text('12/11/2021',
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                  content:
                      Icon(Icons.airplay, size: 70, color: Colors.green[200]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
