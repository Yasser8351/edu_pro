import 'dart:convert';

import 'package:edu_pro/sharepref/user_share_pref.dart';
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
import 'package:edu_pro/view_models/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AppDrawer extends StatefulWidget {
  AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  DateTime timeBackPressed = DateTime.now();

  String? photoImage;
  String userName = '', middleName = '', image = '';
  late bool saveImage = false;
  Future? _data;

  @override
  void initState() {
    super.initState();

    save();
  }

  Future<void> save() async {
    userName = await SharedPrefUser().getUserName();
    middleName = await SharedPrefUser().getMiddleName();
    image = await SharedPrefUser().getImage();
    if (image.isEmpty) {
      saveImage = false;
      _data = Provider.of<ProfileViewModel>(context, listen: false)
          .fetchProfile()
          .then((_) => setState(() {}));
    } else {
      saveImage = true;
    }
    setState(() {});
  }

  Future<void> saveImages(String image) async {
    await SharedPrefUser().saveImage(image);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var list =
        Provider.of<ProfileViewModel>(context, listen: false).ProfileList;

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
                child: saveImage
                    ? GestureDetector(
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
                                CircleAvatar(
                                  maxRadius: 20,
                                  backgroundImage: MemoryImage(
                                    base64Decode("$image"),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Container(
                                  width: 210,
                                  child: Text(
                                    '$userName $middleName',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : list == null
                        ? Text("")
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CircleAvatar(
                                      maxRadius: 20, child: Icon(Icons.person)),
                                  Container(
                                    width: 210,
                                    child: Text(
                                      '$userName $middleName',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                              FutureBuilder(
                                future: _data,
                                builder: (_, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Text('');
                                  } else {
                                    if (snapshot.hasError) {
                                      return Text("some error");
                                    } else if (snapshot.hasData == null) {
                                      return Text("No data found");
                                    } else if (snapshot.hasData) {
                                      return Text("No data found");
                                    }
                                    return Container(
                                      // padding: EdgeInsets.all(22),
                                      height: 5,
                                      child: ListView.builder(
                                        itemCount: list.length,
                                        itemBuilder: (ctx, index) {
                                          image = "${list[index].photo}";
                                          saveImages(image);
                                          return Row(
                                            children: [
                                              SizedBox(
                                                child: CircleAvatar(
                                                  maxRadius: 0,
                                                  backgroundImage: MemoryImage(
                                                    base64Decode("$image"),
                                                  ),
                                                ),
                                              ),
                                              // Container(
                                              //   width: 210,
                                              //   child: Text(
                                              //     '$userName $middleName',
                                              //     style: TextStyle(
                                              //         color: Colors.black,
                                              //         fontSize: 15),
                                              //   ),
                                              // ),
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
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
                ),
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
                onTap: () {
                  Navigator.of(context).pushNamed(Announcements.routeName);
                },
              ),
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
                },
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
