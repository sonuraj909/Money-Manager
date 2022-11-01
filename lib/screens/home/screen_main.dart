import 'dart:core';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/colors.dart';
import 'package:money_manager/constants.dart';
import 'package:money_manager/screens/category/screen_category.dart';
import 'package:money_manager/screens/home/screen_home.dart';
import 'package:money_manager/screens/home/widgets/bottom_navigation.dart';
import 'package:money_manager/screens/transactions/screen_main_transaction.dart';
import '../../db/category/category_db.dart';
import '../../db/transaction/transaction_db.dart';
import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';
import '../add_transaction/screen_add_transaction.dart';

class ScreenMain extends StatelessWidget {
  ScreenMain({super.key});

  double totalBalance = 0;

  double totalIncome = 0;

  double totalExpense = 0;
  final _items = [
    Icon(Icons.home_rounded),
    Icon(Icons.receipt_long_rounded),
    Icon(Icons.category_rounded),
  ];
  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
        calculateBalances(newList);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(28, 255, 255, 255),
                              blurRadius: 12,
                              offset: Offset(5, 5),
                            ),
                            BoxShadow(
                              color: Color.fromARGB(95, 255, 255, 255),
                              blurRadius: 8,
                              offset: Offset(-5, -5),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8),
                          color: KButtonColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Current Balance",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: KBlackColor,
                                ),
                              ),
                              kHeight,
                              Text(
                                '\u{20B9} $totalBalance',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: KBlackColor,
                                ),
                              ),
                              kHeight20,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_downward_rounded,
                                            color: kGreenColor,
                                          ),
                                          Text(
                                            "Income",
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      kHeight,
                                      Text(
                                        '\u{20B9} $totalIncome',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_upward_rounded,
                                            color: kRedColor,
                                          ),
                                          Text(
                                            "Expense",
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      kHeight,
                                      Text(
                                        '\u{20B9} $totalExpense',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Transaction',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: KBlackColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScreenMainTransaction(),
                          ),
                        );
                      },
                      child: Text('View all'),
                    )
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 370,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ValueListenableBuilder(
                      valueListenable:
                          TransactionDB.instance.transactionListNotifier,
                      builder: (BuildContext ctx,
                          List<TransactionModel> newList, Widget? _) {
                        return ListView.separated(
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
                                        color: _value.type ==
                                                CategoryType.income
                                            ? Color.fromARGB(200, 76, 175, 79)
                                            : Color.fromARGB(198, 244, 67, 54),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
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
                            return kHeight;
                          },
                          itemCount: (newList.length > 3) ? 3 : newList.length,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void ontap(BuildContext context, {required int index}) {
    Navigator.pop(context);
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ScreenHome()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScreenHome(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScreenCategory()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ScreenMainTransaction()),
        );
        break;
    }
  }

  calculateBalances(List<TransactionModel> categorys) {
    totalBalance = 0;
    totalExpense = 0;
    totalIncome = 0;
    for (TransactionModel category in categorys) {
      if (category.type == CategoryType.income) {
        totalBalance += category.amount;
        totalIncome += category.amount;
      } else {
        totalBalance -= category.amount;
        totalExpense += category.amount;
      }
    }
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last}\n${_splitedDate.first}';
    // return '${date.day}\n${date.month}';
  }
}
