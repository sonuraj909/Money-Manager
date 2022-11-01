import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/colors.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().expenseCategoryListListner,
        builder: (BuildContext ctx, List<CategoryModel> newlist, Widget? _) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.separated(
              itemBuilder: (ctx, index) {
                final category = newlist[index];
                return Card(
                  color: KButtonColor,
                  child: ListTile(
                    title: Text(
                      category.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        CategoryDB.instance.deleteCategory(category.id);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: KBlackColor,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: newlist.length,
            ),
          );
        });
  }
}
