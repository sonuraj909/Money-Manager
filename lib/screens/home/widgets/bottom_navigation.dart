// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/colors.dart';
import 'package:money_manager/screens/home/screen_home.dart';

class MoneyMangerBottomNavigation extends StatelessWidget {
  MoneyMangerBottomNavigation({Key? key}) : super(key: key);
  final items = [
    Icon(
      Icons.home,
    ),
    Icon(
      Icons.receipt_long_rounded,
      semanticLabel: 'Transactions',
    ),
    Icon(
      Icons.category,
      semanticLabel: 'Categories',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext cxt, int updatedIndex, Widget? _) {
        return CurvedNavigationBar(
          animationCurve: Curves.easeInOutBack,
          animationDuration: const Duration(milliseconds: 600),
          color: Colors.pink,
          backgroundColor: kBackgroundColor,
          items: items,
          index: updatedIndex,
          onTap: (newIndex) {
            ScreenHome.selectedIndexNotifier.value = newIndex;
          },
        );
        // // BottomNavigationBar(
        //   selectedItemColor: Colors.pink,
        //   unselectedItemColor: Colors.grey,
        //   currentIndex: updatedIndex,
        //   onTap: (newIndex) {
        //     ScreenHome.selectedIndexNotifier.value = newIndex;
        //   },
        //   items: [
        //     const BottomNavigationBarItem(
        //         icon: Icon(Icons.home), label: 'Transactions'),
        //     const BottomNavigationBarItem(
        //         icon: Icon(Icons.category), label: 'Categories'),
        //   ],
        // );
      },
    );
  }
}
