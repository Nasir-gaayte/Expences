import 'dart:math';

import 'package:expense_tracker/models/expenes_data.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_itme.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpeince,
  });
  final List<ExpenseData> expenses;
  final void Function(ExpenseData expenseData) onRemoveExpeince;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, i) {
          var ex = expenses[i];
          return Dismissible(
            onDismissed: (direction) {
              onRemoveExpeince(expenses[i]);
            },
            // background: Colors.red,
            key: ValueKey(key),
            child: Column(
              children: [
                ExpenseItem(ex),
              ],
            ),
          );
        });
  }
}
