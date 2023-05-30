import 'package:expense_tracker/models/expenes_data.dart';
import 'package:expense_tracker/models/expenes_data.dart' as prefix;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class AddExpenses extends StatefulWidget {
  const AddExpenses({required this.onAddExpence, super.key});
  final void Function(ExpenseData expenseData) onAddExpence;

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  prefix.Category _selectedCategory = prefix.Category.leisure;

  void _datePicer() async {
    final now = DateTime.now();
    final pickDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(now.year - 1, now.month, now.day),
        lastDate: now);
    setState(() {
      _selectedDate = pickDate;
    });
  }

  void _sebmitExpeceData() {
    final entreedAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = entreedAmount == null || entreedAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Invalid input'),
            content: const Text('Please make sure now empry input is there'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Okay'),
              ),
            ],
          );
        },
      );
      return;
    }
    widget.onAddExpence(
      ExpenseData(
        title: _titleController.text,
        amount: entreedAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
    setState(() {});
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 140, 0, 255),
        Color.fromARGB(255, 220, 195, 224),
      ], begin: Alignment.bottomCenter, end: Alignment.topLeft)),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: DropdownButton(
                            value: _selectedCategory,
                            items: prefix.Category.values.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e.name.toUpperCase(),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                _selectedCategory = value;
                              });
                              print(value);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No date selected'
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _datePicer,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        )),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: '\$',
                              label: Text('Amount'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _sebmitExpeceData,
                  //() {
                  //   // ignore: avoid_print
                  //   print(_titleController.text);
                  //   print(_amountController.text);
                  //   _titleController.clear();
                  //   _amountController.clear();
                  // },
                  child: const Text('Save Expense'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // ignore: avoid_print
                    _titleController.clear();
                    _amountController.clear();
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  icon: const Icon(Icons.cancel),
                  label: const Text('Cancel'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
