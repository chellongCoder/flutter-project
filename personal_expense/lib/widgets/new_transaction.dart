import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function(String text, double num, DateTime time) addTx;

  NewTransaction(this.addTx, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime? datetime;

  void _submitData(BuildContext context) {
    final enteredTitle = titleController.text;
    final enteredAmount = amountController.text;

    if (enteredTitle.isEmpty ||
        double.parse(enteredAmount) <= 0 ||
        datetime == null) {
      return;
    }

    widget.addTx(enteredTitle, double.parse(enteredAmount), datetime!);

    // Navigator.pop(context);
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: datetime ?? DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      setState(() {
        datetime = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (val) {
                  print(val);
                },
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                // onChanged: (val) {
                //   amountInput = val;
                // },
                controller: amountController,
                keyboardType: TextInputType.number,

                onSubmitted: (_) => _submitData(context),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(datetime == null
                        ? 'NO Date Chosen!'
                        : DateFormat.yMMMd()
                            .format(datetime ?? DateTime.now())
                            .toString()),
                  ),
                  FlatButton(
                    onPressed: () {
                      _presentDatePicker();
                    },
                    child: Text('Chosen date'),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
              RaisedButton(
                onPressed: () {
                  _submitData(context);
                },
                child: Text('Add Transaction'),
                textColor: Theme.of(context).backgroundColor,
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
