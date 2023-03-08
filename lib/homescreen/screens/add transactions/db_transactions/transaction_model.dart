import 'package:hive_flutter/hive_flutter.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 2)
class TransactionModel {
  @HiveField(0)
  final bool isIncome;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String categoryName;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final double amount;
  @HiveField(5)
  String? id;
  TransactionModel({
    required this.isIncome,
    required this.amount,
    required this.name,
    required this.categoryName,
    required this.date,
  }) {
    id = DateTime.now().microsecondsSinceEpoch.toString();
  }
}
