import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/charts/overview/screen_statstics.dart';
import 'package:money_manager/splash.dart';

class ScreenCharts extends StatelessWidget {
  const ScreenCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Charts',
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.pie_chart_rounded),
                text: 'Overview',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ScreenStatstics(),
          ],
        ),
      ),
    );
  }
}
