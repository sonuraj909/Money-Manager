import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/colors.dart';
import 'package:money_manager/constants.dart';
import '../../db/transaction/transaction_db.dart';
import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';

class ScreenStatstics extends StatelessWidget {
  ScreenStatstics({super.key});

  double totalBalance = 0;

  double totalIncome = 0;

  double totalExpense = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: TransactionDB.instance.transactionListNotifier,
          builder: (BuildContext ctx, List<TransactionModel> overviewList,
              Widget? _) {
            getOverViewData(overviewList);
            final expensePercent = (totalExpense / totalIncome * 100).toInt();
            final balancePercent = 100 - expensePercent;
            return Padding(
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: Column(
                children: [
                  const Text(
                    "Overview Pie Chart",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 5 / 4,
                    child: DChartPie(
                      strokeWidth: 2,
                      animate: true,
                      data: [
                        {'domain': 'Balance', 'measure': balancePercent},
                        {'domain': 'Expense', 'measure': expensePercent},
                      ],
                      fillColor: (pieData, index) {
                        switch (pieData['domain']) {
                          case 'Balance':
                            return Colors.green;
                          default:
                            return Colors.red;
                        }
                      },
                      pieLabel: (pieData, index) {
                        return "${pieData['domain']}:\n${pieData['measure']}%";
                      },
                      labelPosition: PieLabelPosition.inside,
                      labelFontSize: 14,
                    ),
                  ),
                  kHeight20,
                  Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                      color: KButtonColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Overview Data",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        kHeight30,
                        Text(
                          '🟩Total Income: \u{20B9} $totalIncome',
                          style: Style(),
                        ),
                        kHeight,
                        Text(
                          '🟥Total Expense:\u{20B9} $totalExpense',
                          style: Style(),
                        ),
                        kHeight,
                        Text(
                          '⚪Current Balance:\u{20B9} $totalBalance',
                          style: Style(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  TextStyle Style() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }

  void getOverViewData(List<TransactionModel> overviewList) {
    totalBalance = 0;
    totalExpense = 0;
    totalIncome = 0;
    for (TransactionModel category in overviewList) {
      if (category.type == CategoryType.income) {
        totalBalance += category.amount;
        totalIncome += category.amount;
      } else {
        totalBalance -= category.amount;
        totalExpense += category.amount;
      }
    }
    print(overviewList);
  }
}
