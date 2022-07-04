import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction(this.addTransaction);

  final Function(String, double, DateTime) addTransaction;

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicked() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _submitData() {
    final String title = _titleController.text;
    final double amount = double.tryParse(_amountController.text) ?? 0;

    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTransaction(
      _titleController.text,
      double.tryParse(_amountController.text) ?? 0,
      _selectedDate!,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Title',
            ),
            controller: _titleController,
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Amount',
            ),
            controller: _amountController,
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDate == null
                      ? 'No date selected!'
                      : formatDate(_selectedDate!, [dd, '/', mm, '/', yyyy]),
                ),
                TextButton(
                  onPressed: _presentDatePicked,
                  child: const Text(
                    'Choose date!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _submitData,
            child: const Text('Add transaction!'),
          )
        ],
      ),
    );
  }
}
