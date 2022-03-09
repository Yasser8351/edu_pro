import 'dart:convert';

import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/sharepref/user_share_pref.dart';
import 'package:edu_pro/view_models/profile_view_model.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:edu_pro/widget/error_connection.dart';
import 'package:edu_pro/widget/full_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../universities.dart';
import 'my_profile.dart';

class MyProfileDetail extends StatefulWidget {
  const MyProfileDetail({
    Key? key,
    this.image,
  }) : super(key: key);
  static const routeName = 'profileDetail';
  final String? image;

  @override
  State<MyProfileDetail> createState() => _MyProfileDetailState();
}

class _MyProfileDetailState extends State<MyProfileDetail> {
  var _isLoading = false;
  Future? _data;
  var api = Api();

  @override
  void initState() {
    super.initState();
    _data = Provider.of<ProfileViewModel>(context, listen: false)
        .fetchProfile()
        .then((_) => setState(() {
              _isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var list =
        Provider.of<ProfileViewModel>(context, listen: false).ProfileList;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              SharedPrefUser().logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Universities.routeName, (route) => false);
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => FullImage(image: "${widget.image}")));
              },
              child: CircleAvatar(
                maxRadius: 20,
                backgroundImage: MemoryImage(
                  base64Decode("${widget.image}"),
                ),
              ),
            ),
            SizedBox(width: 20),
            Text(
              'My Profile',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: ConnectionNotifierToggler(
        onConnectionStatusChanged: (connected) {
          /// that means it is still in the initialization phase.
          if (connected == null) return;
          print(connected);
        },
        connected: list == null
            ? ErrorConnection(message: "Server error please try again later")
            : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  height: size.height,
                  width: double.infinity,
                  child: Container(
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
                                  height: size.height - size.height / 3.3,
                                  child: _isLoading
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : FutureBuilder(
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
                                              return list.length == 0
                                                  ? Text('No Data Found!')
                                                  : Container(
                                                      padding:
                                                          EdgeInsets.all(22),
                                                      height: size.height / 4,
                                                      child: ListView.builder(
                                                        itemCount: list.length,
                                                        itemBuilder:
                                                            (ctx, index) =>
                                                                Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  5),
                                                            ),
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              ListTile(
                                                                title: Text(
                                                                  'Index',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                trailing: Text(
                                                                  list[index].facultyName ==
                                                                          null
                                                                      ? "No date"
                                                                      : "${list[index].facultyName}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black87),
                                                                ),
                                                              ),
                                                              ListTile(
                                                                title: Text(
                                                                  'Gender',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                trailing: Text(
                                                                  list[index].gender ==
                                                                          null
                                                                      ? "No date"
                                                                      : "${list[index].gender}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black87),
                                                                ),
                                                              ),
                                                              ListTile(
                                                                title: Text(
                                                                  'Birth Date',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                trailing: Text(
                                                                  list[index].birthdate ==
                                                                          null
                                                                      ? "No date"
                                                                      : "${list[index].birthdate}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black87),
                                                                ),
                                                              ),
                                                              ListTile(
                                                                title: Text(
                                                                  'Nationality',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                trailing: Text(
                                                                  list[index].nationalityName ==
                                                                          null
                                                                      ? "No date"
                                                                      : "${list[index].nationalityName}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black87),
                                                                ),
                                                              ),
                                                              ListTile(
                                                                title: Text(
                                                                  'Faculty',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                trailing: Text(
                                                                  list[index].facultyName ==
                                                                          null
                                                                      ? "No date"
                                                                      : "${list[index].facultyName}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black87),
                                                                ),
                                                              ),
                                                              ListTile(
                                                                title: Text(
                                                                  'Program',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                trailing: Text(
                                                                  list[index].programNameEn ==
                                                                          null
                                                                      ? "No date"
                                                                      : "${list[index].programNameEn}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black87),
                                                                ),
                                                              ),
                                                              ListTile(
                                                                title: Text(
                                                                  'specialization',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                trailing: Text(
                                                                  list[index].specializationName ==
                                                                          null
                                                                      ? "No date"
                                                                      : "${list[index].specializationName}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black87),
                                                                ),
                                                              ),
                                                              ListTile(
                                                                title: Text(
                                                                  'Semester',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                trailing: Text(
                                                                  list[index].semesterName ==
                                                                          null
                                                                      ? "No date"
                                                                      : "${list[index].semesterName}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black87),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                            }
                                          },
                                        ),
                                ),
                              ],
                            ),
                          ), //
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        disconnected: Center(key: UniqueKey(), child: ConnectionStatuesBars()),
      ),
    );
  }
}
