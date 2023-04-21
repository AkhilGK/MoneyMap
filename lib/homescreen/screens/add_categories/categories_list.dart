import 'package:flutter/material.dart';
import 'package:moneymap/providers/category_provider.dart';
import 'package:provider/provider.dart';

import 'db_categories/categories_db_model.dart';

class CategoriesList extends StatelessWidget {
  final bool type;

  CategoriesList({
    super.key,
    required this.type,
  });

  final TextEditingController _categoryController = TextEditingController();

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
                Consumer<CategoryProvider>(
                  builder: ((context, providerModel, child_) {
                    final newList = type
                        ? providerModel.dropDownIncomeCategories
                        : providerModel.dropDownExpenseCategories;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: newList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(
                              newList[index].catName,
                              style: const TextStyle(fontSize: 18),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  providerModel
                                      .deleteIncomeCategory(newList[index].id);

                                  providerModel.refreshUI();
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
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
              controller: _categoryController,
              decoration:
                  const InputDecoration(hintText: "Type category name:"),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('SUBMIT'),
                onPressed: () {
                  final incomeCategory = CategoryModel(
                      id: DateTime.now().toString(),
                      catName: _categoryController.text,
                      type: type);
                  Provider.of<CategoryProvider>(context, listen: false)
                      .insertCategory(incomeCategory);
                  Provider.of<CategoryProvider>(context, listen: false)
                      .refreshUI();

                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  // ValueNotifier<List<CategoryModel>> valuelistanableList() {
  //   if (type == true) {
  //     return dropDownIncomeCategories;
  //   } else {
  //     return dropDownExpenseCategories;
  //   }
  // }
}
