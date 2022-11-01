import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/screens/home/screen_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/pngwing.com.png",
              height: 200,
            ),
            Text(
              'Money Manager',
              style: TextStyle(
                color: Color.fromARGB(255, 174, 14, 67),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> gotoLogin() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => ScreenHome(),
      ),
    );
  }

  Future<void> checkUserLoggedIn() async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    // _sharedPrefs.setBool(SAVE_KEY_NAME, true)
    final _userLoggedIn = _sharedPrefs.getBool(SAVE_KEY_NAME);
    if (_userLoggedIn == null || _userLoggedIn == false) {
      gotoLogin();
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => ScreenHome()));
    }
  }
}
