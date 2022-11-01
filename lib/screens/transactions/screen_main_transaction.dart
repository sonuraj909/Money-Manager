import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/screens/transactions/screen_transactions.dart';

class ScreenMainTransaction extends StatelessWidget {
  const ScreenMainTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: ScreenTransaction(),
    );
  }
}
