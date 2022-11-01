import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/colors.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/db/transaction/transaction_db.dart';
import 'package:money_manager/models/category/category_model.dart';

import '../../models/transaction/transaction_model.dart';

class ScreenTransaction extends StatelessWidget {
  ScreenTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();

    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: ListView.separated(
                    padding: const EdgeInsets.all(10),
                    // values
                    itemBuilder: (ctx, index) {
                      final _value = newList[index];
                      return Slidable(
                        key: Key(_value.id ?? ""),
                        startActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: kBackgroundColor,
                              foregroundColor: KBlackColor,
                              onPressed: (ctx) {
                                TransactionDB.instance
                                    .deleteTransaction(_value.id ?? "");
                              },
                              icon: Icons.delete,
                              label: 'Delete',
                            )
                          ],
                        ),
                        child: SizedBox(
                          height: 66,
                          child: Card(
                            color: KButtonColor,
                            elevation: 0,
                            child: ListTile(
                              leading: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: _value.type == CategoryType.income
                                        ? kGreenColor
                                        : kRedColor,
                                    borderRadius: BorderRadius.circular(3)),
                                child: Center(
                                  child: Text(
                                    parseDate(_value.date),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              trailing: Text(
                                '\u{20B9} ${_value.amount}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              title: Text(
                                _value.category.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
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
                    itemCount: newList.length),
              ),
            ),
          );
        });
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last}\n${_splitedDate.first}';
    // return '${date.day}\n${date.month}';
  }
}
