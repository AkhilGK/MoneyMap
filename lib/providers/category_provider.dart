import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import '../homescreen/screens/add_categories/db_categories/categories_db_model.dart';

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> dropDownIncomeCategories = ([]);
  List<CategoryModel> dropDownExpenseCategories = ([]);

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
    dropDownIncomeCategories.clear();
    dropDownExpenseCategories.clear();
    await Future.forEach(allcategories, (CategoryModel category) {
      if (category.type == true) {
        dropDownIncomeCategories.add(category);
      } else {
        dropDownExpenseCategories.add(category);
      }
    });
    notifyListeners();
  }

  Future<void> deleteIncomeCategory(String catId) async {
    final categoryDb = await Hive.openBox<CategoryModel>('category_db');
    await categoryDb.delete(catId);
    refreshUI();
  }

  Future<void> predefCategory() async {
    CategoryModel i1 = CategoryModel(id: 'i1', catName: 'Salary', type: true);
    CategoryModel i2 =
        CategoryModel(id: 'i2', catName: 'Passive Income', type: true);
    CategoryModel i3 = CategoryModel(id: 'i3', catName: 'Gift', type: true);
    CategoryModel i4 =
        CategoryModel(id: 'i4', catName: 'Pocket Money', type: true);
    CategoryModel i5 =
        CategoryModel(id: 'i5', catName: 'Share Profit', type: true);
    insertCategory(i1);
    insertCategory(i2);
    insertCategory(i3);
    insertCategory(i4);
    insertCategory(i5);
    CategoryModel e1 = CategoryModel(id: 'e1', catName: 'Travel', type: false);
    CategoryModel e2 =
        CategoryModel(id: 'e2', catName: 'Home/Office', type: false);
    CategoryModel e3 = CategoryModel(id: 'e3', catName: 'Food', type: false);
    CategoryModel e4 =
        CategoryModel(id: 'e4', catName: 'Automobile', type: false);
    CategoryModel e5 =
        CategoryModel(id: 'e5', catName: 'Education', type: false);
    insertCategory(e1);
    insertCategory(e2);
    insertCategory(e3);
    insertCategory(e4);
    insertCategory(e5);
  }
}
