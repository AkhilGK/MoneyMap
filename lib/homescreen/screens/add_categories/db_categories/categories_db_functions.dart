import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymap/homescreen/screens/add_categories/db_categories/categories_db_model.dart';

ValueNotifier<List<CategoryModel>> dropDownIncomeCategories = ValueNotifier([]);
ValueNotifier<List<CategoryModel>> dropDownExpenseCategories =
    ValueNotifier([]);
//to add values to DB
Future<void> insertCategory(CategoryModel valueIn) async {
  final categoryDb = await Hive.openBox<CategoryModel>('category_db');
  await categoryDb.put(valueIn.id, valueIn);
  refreshUI();
}

Future<List<CategoryModel>> getCategories() async {
  final categoryDb = await Hive.openBox<CategoryModel>('category_db');
  return categoryDb.values.toList();
}

Future<void> refreshUI() async {
  final allcategories = await getCategories();
  dropDownIncomeCategories.value.clear();
  dropDownExpenseCategories.value.clear();
  await Future.forEach(allcategories, (CategoryModel category) {
    if (category.type == true) {
      dropDownIncomeCategories.value.add(category);
    } else {
      dropDownExpenseCategories.value.add(category);
    }
  });
  dropDownIncomeCategories.notifyListeners();
  dropDownExpenseCategories.notifyListeners();
}

Future<void> deleteIncomeCategory(String catId) async {
  final categoryDb = await Hive.openBox<CategoryModel>('category_db');
  await categoryDb.delete(catId);
  refreshUI();
}
