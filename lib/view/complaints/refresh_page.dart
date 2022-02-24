import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:edu_pro/view/complaints/report_complaints.dart';
import 'package:flutter/material.dart';

class RefreshPage extends StatefulWidget {
  const RefreshPage({Key? key}) : super(key: key);
  static const routeName = 'RefreshPage';

  @override
  State<RefreshPage> createState() => _RefreshPageState();
}

class _RefreshPageState extends State<RefreshPage> {
  @override
  initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.10),
        child: EasySplashScreen(
          durationInSeconds: 1,
          navigator: ReportComplaints(),
          logo: Image.asset(
            'assets/logo2.png',
            fit: BoxFit.fill,
          ),
          logoSize: 0,
          backgroundColor: Colors.white,
          loaderColor: Theme.of(context).colorScheme.primary,

        ),
      ),
    );
  }
}
