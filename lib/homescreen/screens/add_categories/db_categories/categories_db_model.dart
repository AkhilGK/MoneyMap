import 'package:hive_flutter/hive_flutter.dart';
part 'categories_db_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String catName;
  @HiveField(2)
  final bool isDeleted;
  @HiveField(3)
  final bool type;
  CategoryModel({
    required this.id,
    required this.catName,
    required this.type, //if true income else expense
    this.isDeleted = false,
  });
}
