import 'package:flutter/material.dart';
import 'package:moneymap/homescreen/screens/add_categories/db_categories/categories_db_functions.dart';

import 'db_categories/categories_db_model.dart';

class CategoriesList extends StatefulWidget {
  final bool type;

  const CategoriesList({
    super.key,
    required this.type,
  });

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  TextEditingController _CategoryController = TextEditingController();

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: const Icon(Icons.add),
          onPressed: () {
            _displayDialog(context);
          }),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'Categories',
                    style: TextStyle(fontSize: 20, color: Colors.purple),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: valuelistanableList(),
                  builder: ((context, List<CategoryModel> newInList, child_) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: newInList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(
                              newInList[index].catName,
                              style: const TextStyle(fontSize: 18),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  deleteIncomeCategory(newInList[index].id);

                                  refreshUI();
                                },
                                icon: const Icon(Icons.delete)),
                          ),
                        );
                      },
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Enter the Category'),
            content: TextField(
              controller: _CategoryController,
              decoration:
                  const InputDecoration(hintText: "Type category name:"),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('SUBMIT'),
                onPressed: () {
                  final incomeCategory = CategoryModel(
                      id: DateTime.now().toString(),
                      catName: _CategoryController.text,
                      type: widget.type);
                  insertCategory(incomeCategory);
                  refreshUI();

                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  ValueNotifier<List<CategoryModel>> valuelistanableList() {
    if (widget.type == true) {
      return dropDownIncomeCategories;
    } else {
      return dropDownExpenseCategories;
    }
  }
}
