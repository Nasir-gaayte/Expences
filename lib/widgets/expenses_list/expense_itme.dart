import 'package:expense_tracker/models/expenes_data.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expenseData, {super.key});
  final ExpenseData expenseData;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                expenseData.title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text('\$${expenseData.amount.toStringAsFixed(2)}'),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(categoryIcons[expenseData.category]),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(expenseData.formattedDate)
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ]),
      ),
    );
  }
}
