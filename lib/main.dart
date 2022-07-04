import 'package:expenses_app/widgets/chart.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/add_transaction.dart';
import 'widgets/transaction_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expanses App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'My expenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  void _addTransaction(String txTitle, double txAmount, DateTime txDate) {
    final Transaction newTransaction = Transaction(
      title: txTitle,
      amount: txAmount,
      date: txDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _deleteTransaction(int index) {
    showDialog(
      context: context,
      builder: (bCtx) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Are you sure?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _userTransactions.removeAt(index);
                        });

                        Navigator.of(context).pop();
                      },
                      child: const Text('Confirm'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _startAddNewTransaction() {
    showModalBottomSheet(
      context: context,
      builder: (bCtx) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: AddTransaction(_addTransaction),
        );
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where(
          (element) => element.date.isAfter(
            DateTime.now().subtract(const Duration(days: 7)),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _startAddNewTransaction,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Chart(_recentTransactions),
              _userTransactions.isEmpty
                  ? Column(
                      children: [
                        Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.contain,
                          width: 100,
                          height: 300,
                        ),
                        const Text(
                          'No transactions added yet!',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    )
                  : TransactionList(
                      _userTransactions,
                      (int index) => _deleteTransaction(index),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _startAddNewTransaction,
        child: const Icon(Icons.add),
      ),
    );
  }
}
