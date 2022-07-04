import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String title;
  final double amount;
  final double percantageOfTotal;

  const ChartBar(this.title, this.amount, this.percantageOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('\$${amount.toStringAsFixed(0)}'),
        Container(
          height: 80,
          width: 15,
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: percantageOfTotal,
              child: Container(
                width: 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ),
        Text(title),
      ],
    );
  }
}
