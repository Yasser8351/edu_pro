import 'package:edu_pro/sharepref/user_share_pref.dart';
import 'package:edu_pro/view/login_home.dart';
import 'package:edu_pro/view/universities.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

import 'home.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    getUserStatus();
  }

  bool userStatus = false;

  getUserStatus() async {
    SharedPrefUser prefs = SharedPrefUser();
    bool currentStatus = await prefs.isLogin();
    if (currentStatus) {}
    setState(() {
      userStatus = currentStatus;
    });

    print("userStatus $userStatus");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.10),
        child: EasySplashScreen(
          durationInSeconds: 3,
          navigator: userStatus ? Home() : const Universities(),
          // title: Text(
          //   'EDU.PRO',
          //   style: TextStyle(
          //       color: Theme.of(context).colorScheme.primary,
          //       fontSize: 18,
          //       fontWeight: FontWeight.bold),
          // ),
          logo: Image.asset(
            'assets/logo2.png',
            fit: BoxFit.fill,
          ),
          logoSize: 220,
          backgroundColor: Colors.white,
          loaderColor: Colors.white,
        ),
      ),
    );
  }
}
