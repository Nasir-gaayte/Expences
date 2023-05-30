import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expenes_data.dart';
import 'package:flutter/material.dart';

import 'add_expenses.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseData> _registerdExpenses = [
    // ExpenseData(
    //     title: 'flutter course',
    //     amount: 19.99,
    //     date: DateTime.now(),
    //     category: Category.work),
    // ExpenseData(
    //     title: 'new car',
    //     amount: 99999.99,
    //     date: DateTime.now(),
    //     category: Category.work),
    // ExpenseData(
    //     title: 'watch',
    //     amount: 99,
    //     date: DateTime.now(),
    //     category: Category.gift),
  ];

  void _openAddExpensesOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return AddExpenses(
            onAddExpence: _addExpense,
          );
        });
  }

  void _addExpense(ExpenseData expenseData) {
    setState(() {
      _registerdExpenses.add(expenseData);
    });
  }

  void _removeExpence(ExpenseData expenseData) {
    final expenceindex = _registerdExpenses.indexOf(expenseData);
    setState(() {
      _registerdExpenses.remove(expenseData);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('you delete this Expencese'),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _registerdExpenses.insert(expenceindex, expenseData);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget noExpences = const Center(
      child: Text('No Expences yet you can start add some!'),
    );
    if (_registerdExpenses.isNotEmpty) {
      noExpences = ExpensesList(
        expenses: _registerdExpenses,
        onRemoveExpeince: _removeExpence,
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Expenses Tracker'), actions: [
        IconButton(
          onPressed: _openAddExpensesOverlay,
          icon: const Icon(Icons.add),
        ),
      ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Expanded(child: noExpences)],
      ),
    );
  }
}
