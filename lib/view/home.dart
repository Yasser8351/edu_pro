import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view/library/library.dart';
import 'package:edu_pro/view/timetable/timetable.dart';
import 'package:edu_pro/view_models/profile_view_model.dart';
import 'package:edu_pro/widget/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'attendance/attendance.dart';
import 'calender.dart';
import 'fees_information.dart';
import 'results.dart';

class Home extends StatefulWidget {
  const Home(
      {Key? key, this.userName, this.UniversitiesId, this.isLogin = false})
      : super(key: key);
  static const routeName = "home";
  final userName;
  final UniversitiesId;
  final isLogin;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  String image = '';
  int universitiesId = 0;
  DateTime timeBackPressed = DateTime.now();
  var api = Api();
  @override
  void initState() {
    super.initState();
  }

  Color cardBackgroundColor = Colors.grey;

  void changeColor(Color changeToColor) {
    setState(() {
      cardBackgroundColor = changeToColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var list =
        Provider.of<ProfileViewModel>(context, listen: false).ProfileList;

    return Stack(children: [
      Align(
          alignment: Alignment.topCenter,
          child: WillPopScope(
              onWillPop: () async {
                final differenc = DateTime.now().difference(timeBackPressed);
                final exitApp = differenc >= Duration(seconds: 2);

                timeBackPressed = DateTime.now();

                if (exitApp) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      duration: Duration(seconds: 2),
                      content: Text(
                        "اضغط مرة أخري للخروج",
                        textAlign: TextAlign.right,
                      ),
                    ),
                  );
                  return false;
                } else {
                  return true;
                }
              },
              child: Scaffold(
                key: _drawerKey,
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        _drawerKey.currentState!.openDrawer();
                      },
                      icon: Icon(Icons.menu, color: Colors.white)),
                  elevation: 0,
                  title: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                drawer: AppDrawer(),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50.0),
                            bottomRight: Radius.circular(50.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(Attendance.routeName);
                                },
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    shadowColor: Colors.grey,
                                    elevation: 10,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                            Icons
                                                .pending_actions_rounded, //pending_actions_rounded
                                            size: 60,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                        Text(
                                          'Attendance',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(Results.routeName);
                                },
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    shadowColor: Colors.grey,
                                    elevation: 10,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Container(
                                        //   width: 65,
                                        //   height: 65,
                                        //   child: Image.asset(
                                        //     'assets/exam.gif',
                                        //     // color: Colors.blue,
                                        //   ),
                                        // ),
                                        Icon(Icons.analytics_outlined,
                                            size: 60,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                        const SizedBox(height: 15),
                                        Text(
                                          'Results',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Navigator.of(context).pushNamed(Calender.routeName);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => Calender(
                                            isHome: true,
                                          )));
                                },
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    shadowColor: Colors.grey,
                                    elevation: 10,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Container(
                                        //   width: 65,
                                        //   height: 65,
                                        //   child: Image.asset(
                                        //     'assets/calendar.gif',
                                        //     // color: Colors.blue,
                                        //   ),
                                        // ),
                                        Icon(Icons.date_range,
                                            size: 60,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                        const SizedBox(height: 15),
                                        Text(
                                          'Calender',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(FeesInformation.routeName);
                                },
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    shadowColor: Colors.grey,
                                    elevation: 10,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.monetization_on_outlined,
                                            size: 60,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                        const SizedBox(height: 15),
                                        Text(
                                          'Fees Information',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(Timetable.routeName);
                                },
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    shadowColor: Colors.grey,
                                    elevation: 10,
                                    //color: Colors.black,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.timer,
                                            size: 60,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                        // Container(
                                        //   width: 65,
                                        //   height: 65,
                                        //   child: Image.asset(
                                        //     'assets/clock.gif',
                                        //     // color: Colors.blue,
                                        //   ),
                                        // ),
                                        const SizedBox(height: 15),
                                        Text(
                                          'Timetable',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(Library.routeName);
                                },
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    shadowColor: Colors.grey,
                                    elevation: 10,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.library_books,
                                            size: 60,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                        const SizedBox(height: 15),
                                        Text(
                                          'Library',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      //Spacer(),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Theme.of(context).colorScheme.primary,
                          height: size.height / 13,
                          child: Center(
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 15),
                                Text('copyright @ 2022 - ALl Rights Reserved',
                                    style: TextStyle(color: Colors.white)),
                                const SizedBox(height: 5),
                                Text('Hash Information Technology',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )))
    ]);
  }
}
