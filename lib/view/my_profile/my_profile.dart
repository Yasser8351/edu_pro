import 'dart:convert';

import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/sharepref/user_share_pref.dart';
import 'package:edu_pro/view/my_profile/my_profile_detail.dart';
import 'package:edu_pro/view_models/profile_view_model.dart';
import 'package:edu_pro/widget/app_drawer.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:edu_pro/widget/error_connection.dart';
import 'package:edu_pro/widget/full_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../universities.dart';
import 'update_profile.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);
  static const routeName = 'myProfile';

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var _isLoading = false;
  Future? _data;
  var api = Api();

  String _address = '';
  String _phone = '';

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _data = Provider.of<ProfileViewModel>(context, listen: false)
        .fetchProfile()
        .then((_) => setState(() {
              _isLoading = false;
            }));
  }

  var image;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var list =
        Provider.of<ProfileViewModel>(context, listen: false).ProfileList;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              SharedPrefUser().logout();
              Navigator.of(context).pushNamed(Universities.routeName);
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 20),
            Text(
              'My Profile',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      drawer: AppDrawer(),
      body: ConnectionNotifierToggler(
        onConnectionStatusChanged: (connected) {
          if (connected == null) return;
          print(connected);
        },
        connected: list == null
            ? ErrorConnection(message: "Server error please try again later")
            : list.length == 0
                ? ErrorConnection(message: "No Data Found")
                : _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        margin: EdgeInsets.only(top: 10),
                        height: size.height,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                shadowColor: Colors.grey,
                                elevation: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: FutureBuilder(
                                        future: _data,
                                        builder: (_, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else {
                                            if (snapshot.hasError) {
                                              return Text("some error");
                                            } else if (snapshot.hasData ==
                                                null) {
                                              return Text("No data found");
                                            } else if (snapshot.hasData) {
                                              return Text("No data found");
                                            }
                                            return Container(
                                              // padding: EdgeInsets.all(22),
                                              height: size.height / 1.55,
                                              child: ListView.builder(
                                                itemCount: list.length,
                                                itemBuilder: (ctx, index) {
                                                  _address = list[index]
                                                      .permenantAddress
                                                      .toString();
                                                  _phone = list[index]
                                                      .mobileNum
                                                      .toString();
                                                  image =
                                                      "${list[index].photo}";
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(5),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const SizedBox(
                                                            height: 15),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder: (ctx) =>
                                                                        FullImage(
                                                                            image:
                                                                                image)));
                                                          },
                                                          child: CircleAvatar(
                                                            backgroundImage:
                                                                MemoryImage(
                                                              base64Decode(
                                                                  "$image"),
                                                            ),
                                                            maxRadius: 50,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        ListTile(
                                                          title: Text(
                                                            'Name',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14),
                                                          ),
                                                          trailing: Text(
                                                            "${list[index].fullName}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                        ListTile(
                                                          title: Text(
                                                            'Faculty',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14),
                                                          ),
                                                          trailing: Text(
                                                            "${list[index].facultyName}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                        ListTile(
                                                          title: Text(
                                                            'Program',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14),
                                                          ),
                                                          trailing: Text(
                                                            "${list[index].programNameEn}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                        ListTile(
                                                          title: Text(
                                                            'specialization',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14),
                                                          ),
                                                          trailing: Text(
                                                            "${list[index].specializationName}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                        ListTile(
                                                          title: Text(
                                                            'Batch',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14),
                                                          ),
                                                          trailing: Text(
                                                            "${list[index].batchName}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                        ListTile(
                                                          title: Text(
                                                            'Number',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14),
                                                          ),
                                                          trailing: Text(
                                                            "${list[index].mobileNum}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (ctx) => UpdateProfile(
                                                      image: image,
                                                    )));
                                      },
                                      icon: Icon(Icons.edit,
                                          color: Colors.black38)),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (ctx) => MyProfileDetail(
                                                    image: image,
                                                  )));
                                    },
                                    icon: Icon(Icons.view_module,
                                        color: Colors.black38),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
        disconnected: Center(key: UniqueKey(), child: ConnectionStatuesBars()),
      ),
    );
  }
}
