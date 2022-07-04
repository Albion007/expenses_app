import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions);

  List<Map<String, Object>> get _groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalAmount += recentTransactions[i].amount;
        }
      }

      return {
        'day': formatDate(weekDay, [D]).substring(0, 1),
        'amount': totalAmount
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    double totalWeeklyAmount = 0;

    for (final transaction in _groupedTransactions) {
      totalWeeklyAmount += (transaction['amount'] as double);
    }

    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedTransactions
              .map(
                (element) => ChartBar(
                  (element['day'] as String),
                  (element['amount'] as double),
                  totalWeeklyAmount == 0
                      ? 0
                      : (element['amount'] as double) / totalWeeklyAmount,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
