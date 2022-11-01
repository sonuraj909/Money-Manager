import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/colors.dart';
import 'package:money_manager/constants.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Settings',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Profile
              kHeight,
              Text(
                'Profile',
                style: headstyle(),
              ),
              kHeight20,
              Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                    color: KButtonColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        maxRadius: 30,
                        backgroundImage: NetworkImage(
                            "https://appmaking.co/wp-content/uploads/2021/08/appmaking-logo-colored.png"),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('UserName'),
                          Text('UserEmail@gmail.com'),
                        ],
                      ),
                      Icon(Icons.edit),
                    ],
                  ),
                ),
              ),
              kHeight30,

              //Notification

              Text(
                'Notification',
                style: headstyle(),
              ),
              kHeight20,
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                    color: KButtonColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.notifications,
                            size: 30,
                          ),
                          Text(
                            'Daily Reminder',
                            style: headstyle(),
                          ),
                          Icon(
                            Icons.toggle_off,
                            size: 40,
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.alarm_rounded,
                            size: 30,
                          ),
                          Text(
                            'Notification Time',
                            style: headstyle(),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                '1:00 pm',
                                style: headstyle(),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              kHeight30,

              //Others

              Text(
                'Others',
                style: headstyle(),
              ),
              kHeight20,
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.clear_all_rounded,
                        size: 30,
                      ),
                      label: Text(
                        'Reset Data',
                        style: headstyle(),
                      ),
                    ),
                  ),
                  kHeight,
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.feedback_rounded,
                        size: 30,
                      ),
                      label: Text(
                        'Feedback',
                        style: headstyle(),
                      ),
                    ),
                  ),
                  kHeight50,
                  Center(
                    child: Text(
                      ' from \n© SR',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  TextStyle headstyle() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    );
  }
}
