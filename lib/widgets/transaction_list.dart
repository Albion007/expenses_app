import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transactions, this.deleteTransaction);

  final List<Transaction> transactions;
  final Function(int) deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (_, index) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: FittedBox(
                    child: Text(
                      '\$${transactions[index].amount.toStringAsFixed(0)}',
                    ),
                  ),
                ),
              ),
              title: Text(
                transactions[index].title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                formatDate(
                  transactions[index].date,
                  [MM, ' ', dd, ', ', yyyy],
                ),
              ),
              trailing: IconButton(
                onPressed: () => deleteTransaction(index),
                icon: const Icon(Icons.delete),
              ),
            ),
          );
        },
      ),
    );
  }
}
