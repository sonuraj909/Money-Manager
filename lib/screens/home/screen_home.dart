// ignore_for_file: avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/charts/screen_charts.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/screens/add_transaction/screen_add_transaction.dart';
import 'package:money_manager/screens/category/category_add_popup.dart';
import 'package:money_manager/screens/category/screen_category.dart';
import 'package:money_manager/screens/home/screen_main.dart';
import 'package:money_manager/screens/home/widgets/bottom_navigation.dart';
import 'package:money_manager/charts/overview/screen_statstics.dart';
import 'package:money_manager/screens/transactions/screen_transactions.dart';

import '../../colors.dart';
import '../settings/screen_settings.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final pages = [
    ScreenMain(),
    ScreenTransaction(),
    ScreenCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(selectedIndexNotifier: selectedIndexNotifier),
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: ValueListenableBuilder(
          valueListenable: ScreenHome.selectedIndexNotifier,
          builder: (BuildContext cxt, int value, Widget? _) {
            ScreenHome.selectedIndexNotifier.value = value;
            {
              if (value == 0) {
                return AppbarWidget(
                  title: "Money Manager",
                );
              }
              if (value == 1) {
                return AppbarWidget(
                  title: "Transactions",
                );
              } else {
                return AppbarWidget(
                  title: "Category",
                );
              }
            }
          },
        ),
      ),
      bottomNavigationBar: MoneyMangerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updatedIndex, _) {
            return pages[updatedIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0 ||
              selectedIndexNotifier.value == 1) {
            Navigator.of(context).pushNamed(ScreenaddTranscation.routeName);
          } else {
            showCategoryAddPopup(context);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
    required this.selectedIndexNotifier,
  }) : super(key: key);

  final ValueNotifier<int> selectedIndexNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext cxt, int value, Widget? _) {
        return Drawer(
          width: 250,
          backgroundColor: kBackgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text("sonu"),
                accountEmail: Text("sonu@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://appmaking.co/wp-content/uploads/2021/08/appmaking-logo-colored.png"),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home_rounded),
                title: const Text('Home'),
                onTap: () {
                  ScreenHome.selectedIndexNotifier.value = 0;
                  Navigator.pop(context);
                },
              ),
              ListTile(
                  leading: Icon(Icons.receipt_long_rounded),
                  title: const Text('Transactions'),
                  onTap: () {
                    ScreenHome.selectedIndexNotifier.value = 1;
                    Navigator.pop(context);
                  }),
              ListTile(
                  leading: Icon(Icons.category_rounded),
                  title: const Text('Category'),
                  onTap: () {
                    ScreenHome.selectedIndexNotifier.value = 2;
                    Navigator.pop(context);
                  }),
              ListTile(
                leading: Icon(Icons.pie_chart_rounded),
                title: const Text('Charts'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScreenCharts()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings_rounded),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScreenSettings()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ScreenCharts()));
          },
          icon: Icon(Icons.pie_chart_rounded),
        ),
      ],
    );
  }
}
