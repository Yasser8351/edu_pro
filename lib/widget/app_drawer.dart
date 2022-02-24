import 'dart:convert';

import 'package:edu_pro/sharepref/user_share_pref.dart';
import 'package:edu_pro/view/e_services/e_services.dart';
import 'package:edu_pro/view/fees_information.dart';
import 'package:edu_pro/view/my_activties/activities.dart';
import 'package:edu_pro/view/announcements.dart';
import 'package:edu_pro/view/card_information.dart';
import 'package:edu_pro/view/complaints/complaints.dart';
import 'package:edu_pro/view/faculty_material/faculty_material.dart';
import 'package:edu_pro/view/home.dart';
import 'package:edu_pro/view/medical_profile.dart';
import 'package:edu_pro/view/my_profile/my_profile.dart';
import 'package:edu_pro/view/news&events/news&events.dart';
import 'package:edu_pro/view/restrictions.dart';
import 'package:edu_pro/view/surveys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class AppDrawer extends StatefulWidget {
  AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  DateTime timeBackPressed = DateTime.now();

  late SharedPreferences _prefs;
  String? photoImage;
  String userName = '', middleName = '', image = '';
  int ActivityList = 0;
  int NewsList = 0;
  int SurveysListFromShared = 0;

  var _list;

  @override
  void initState() {
    super.initState();
    save();
  }

  Future<void> save() async {
    userName = await SharedPrefUser().getUserName();
    middleName = await SharedPrefUser().getMiddleName();
    image = await SharedPrefUser().getImage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 60,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 1],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 35),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(MyProfile.routeName);
                },
                child: Container(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // CircleAvatar(
                        //   backgroundColor: Colors.white,
                        //   child: Icon(Icons.person),
                        // ),
                        CircleAvatar(
                          maxRadius: 20,
                          backgroundImage: MemoryImage(
                            base64Decode("$image"),
                          ),
                          // backgroundColor:
                          //     Theme.of(context).colorScheme.primary,
                        ),

                        const SizedBox(width: 20),
                        Container(
                          width: 210,
                          child: Text(
                            '$userName $middleName',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 18, left: 18),
                child: Divider(color: Colors.white),
              ),
              ListTile(
                selectedTileColor: Colors.black,
                selected: true,
                title: Text(
                  'Home',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                leading: Icon(
                  Icons.dashboard,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(Home.routeName);
                },
              ),
              ListTile(
                title: Text(
                  'News & Events',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                leading: Icon(
                  Icons.date_range,
                  color: Colors.white,
                ),
                trailing: Text(''),
                // Badge(
                //     child: Icon(
                //       Icons.notifications,
                //       color: Colors.white,
                //     ),
                //     value: '$NewsList',
                //     color: Colors.green),
                onTap: () {
                  Navigator.of(context).pushNamed(News.routeName);
                },
              ),
              ListTile(
                title: Text(
                  'My Activities',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                leading: Container(
                  height: 23,
                  width: 25,
                  child: Icon(
                    Icons.local_activity,
                    color: Colors.white,
                  ),
                  // child: SvgPicture.asset(
                  //   'assets/act.svg',
                  //   color: Colors.white,
                  // ),
                ),
                // leading: Icon(
                //   Icons.article_rounded,
                //   color: Colors.white,
                // ),
                trailing: Text(''),
                onTap: () {
                  Navigator.of(context).pushNamed(Activities.routeName);
                },
              ),
              ListTile(
                title: Text(
                  'Announcements',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                leading: Icon(
                  Icons.campaign_outlined,
                  color: Colors.white,
                ),
                trailing: Text(''),
                //  Badge(
                //     child: Icon(
                //       Icons.notifications,
                //       color: Colors.white,
                //     ),
                //     value: '2',
                //     //value: cart.itemCount.toString(),
                //     color: Colors.green),
                onTap: () {
                  Navigator.of(context).pushNamed(Announcements.routeName);
                },
              ),
              // ListTile(
              //   title: Text(
              //     'Surveys',
              //     style: TextStyle(color: Colors.white, fontSize: 15),
              //   ),
              //   leading: Icon(
              //     Icons.receipt_long,
              //     color: Colors.white,
              //   ),
              //   trailing: SurveysListFromShared >= SurveysListFromDB.length
              //       ? Text('')
              //       : Badge(
              //           child: Icon(
              //             Icons.notifications,
              //             color: Colors.white,
              //           ),
              //           value:
              //               '${SurveysListFromDB.length - SurveysListFromShared}',
              //           color: Colors.green),
              //   onTap: () {
              //     Navigator.of(context).pushNamed(Surveys.routeName);
              //     // SharedPrefUser().clearSurveys();
              //   },
              // ),
              ListTile(
                title: Text(
                  'Surveys',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                leading: Icon(
                  Icons.receipt_long,
                  color: Colors.white,
                ),
                trailing: Text(''),
                onTap: () {
                  Navigator.of(context).pushNamed(Surveys.routeName);
                  // SharedPrefUser().clearSurveys();
                },
              ),
              // ListTile(
              //   title: Text(
              //     feesList.length == 0 ? 'Registration' : 'Fees Information',
              //     style: TextStyle(color: Colors.white, fontSize: 15),
              //   ),
              //   leading: Icon(
              //     Icons.repeat,
              //     color: Colors.white,
              //   ),
              //   onTap: () {
              //     feesList.length == 0
              //         ? Navigator.of(context).pushNamed(Registration.routeName)
              //         : Navigator.of(context)
              //             .pushNamed(FeesInformation.routeName);
              //   },
              // ),

              ListTile(
                title: Text(
                  'Faculty Material',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                leading: Icon(
                  Icons.receipt,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(FacultyMaterial.routeName);
                },
              ),

              // ListTile(
              //   title: Text(
              //     'E-Services',
              //     style: TextStyle(color: Colors.white, fontSize: 15),
              //   ),
              //   leading: Icon(
              //     Icons.supervised_user_circle_sharp,
              //     color: Colors.white,
              //   ),
              //   onTap: () {
              //     Navigator.of(context).pushNamed(EServices.routeName);
              //   },
              // ),
              ListTile(
                title: Text(
                  'Card Information',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                leading: Icon(
                  Icons.credit_card,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(CardInformation.routeName);
                },
              ),
              ListTile(
                title: Text(
                  'Restrictions',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                leading: Icon(
                  Icons.reset_tv,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(Restrictions.routeName);
                },
              ),
              // ListTile(
              //   title: Text(
              //     'Staff Directory',
              //     style: TextStyle(color: Colors.white, fontSize: 15),
              //   ),
              //   leading: Icon(
              //     Icons.person_pin_rounded,
              //     color: Colors.white,
              //   ),
              //   onTap: () {
              //     Navigator.of(context).pushNamed(StaffDirectory.routeName);
              //   },
              // ),
              ListTile(
                title: Text(
                  'Complaints',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                leading: Icon(
                  Icons.messenger_sharp,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(Complaints.routeName);
                },
              ),
              ListTile(
                title: Text(
                  'Medical Profile',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                leading: Icon(
                  Icons.medical_services,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(MedicalProfile.routeName);
                },
              ),
              /*
                   ListTile(
                title: Text(
                  'My Profile',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                leading: Icon(
                  Icons.person_sharp,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(MyProfile.routeName);
                },
              ),
         
              */
            ],
          ),
        ),
      ),
    );
  }
}
