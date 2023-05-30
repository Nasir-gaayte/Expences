import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Category { food, travel, leisure, work, gift }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.gift: Icons.gif_box,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.travel: Icons.travel_explore,
};

class ExpenseData {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  ExpenseData({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate {
    return formatter.format(date);
  }
}
