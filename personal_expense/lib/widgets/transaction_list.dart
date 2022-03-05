import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  Function(String id) deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction, {Key? key})
      : super(key: key);

  // TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    'NO transaction yet!',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/zzz.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (e, index) {
              return Card(
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Text("\$${transactions[index].amount}"),
                      ),
                    ),
                  ),
                  title: Text(transactions[index].title,
                      style: Theme.of(context).textTheme.bodyText1),
                  subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: Theme.of(context).textTheme.bodyText1),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          onPressed: () {
                            deleteTransaction(transactions[index].id);
                          },
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () {
                            deleteTransaction(transactions[index].id);
                          },
                        ),
                ),
              );
            },
          );
  }
}
