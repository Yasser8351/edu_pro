import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view_models/curriculum_view_model.dart';
import 'package:edu_pro/view_models/profile_view_model.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Curriculum extends StatefulWidget {
  const Curriculum({Key? key}) : super(key: key);
  static const routeName = 'Curriculum';

  @override
  _CurriculumState createState() => _CurriculumState();
}

class _CurriculumState extends State<Curriculum> {
  var _isLoading = false;
  Future? _data, _dataProfile, _dataCourse;
  var api = Api();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });
    _data = Provider.of<CurriculumViewModel>(context, listen: false)
        .fetchCurriculum()
        .then((_) => setState(() {
              _isLoading = false;
            }));
    _dataCourse = Provider.of<CurriculumViewModel>(context, listen: false)
        .fetchCurriculumCourse()
        .then((_) => setState(() {
              _isLoading = false;
            }));

    _dataProfile = Provider.of<ProfileViewModel>(context, listen: false)
        .fetchProfile()
        .then((_) => setState(() {
              _isLoading = false;
            }));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var CurriculumList =
        Provider.of<CurriculumViewModel>(context, listen: false).CurriculumList;

    var profileList =
        Provider.of<ProfileViewModel>(context, listen: false).ProfileList;
    var CourseList = Provider.of<CurriculumViewModel>(context, listen: false)
        .CurriculumCourseList;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Curriculum',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: ConnectionNotifierToggler(
        onConnectionStatusChanged: (connected) {
          /// that means it is still in the initialization phase.
          if (connected == null) return;
          print(connected);
        },
        connected: CurriculumList == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      child: Image.asset(
                        'assets/warning.gif',
                        // color: Colors.blue,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        'Server error please try again later',
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.background),
                      ),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          height: 130,
                          child: FutureBuilder(
                            future: _data,
                            builder: (_, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                if (snapshot.hasError) {
                                  return Text("some error");
                                } else if (snapshot.hasData == null) {
                                  return Text("No data found");
                                } else if (snapshot.hasData) {
                                  return Text("No data found");
                                }
                                return ListView.builder(
                                  itemCount: CurriculumList.length,
                                  itemBuilder: (ctx, index) {
                                    var list = profileList![index];
                                    String dateFromDB = "";
                                    dateFromDB =
                                        "${CurriculumList[index].dateFrom}";
                                    var dateFromDay =
                                        DateTime.parse(dateFromDB).day;
                                    var dateFromMonth =
                                        DateTime.parse(dateFromDB).month;
                                    var dateFromYear =
                                        DateTime.parse(dateFromDB).year;
                                    return Container(
                                      height: size.height, //this size
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            "${list.facultyName}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${CurriculumList[index].curriculumName}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "$dateFromYear-$dateFromMonth-$dateFromDay",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          ListTile(
                                            trailing: Text('Program Name'),
                                            leading: Text('No.'),
                                          ),
                                          ListTile(
                                            trailing:
                                                Text("${list.programNameEn}"),
                                            leading: Text('1'),
                                          ),
                                          Text(
                                            "Curriculum for ${list.programNameEn}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          ListTile(
                                            trailing:
                                                Text('Specialization Name'),
                                            leading: Text('No.'),
                                          ),
                                          ListTile(
                                            trailing: Text(
                                                "${list.specializationName}"),
                                            leading: Text('1'),
                                          ),
                                          Text(
                                            "${list.specializationName}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Program Structure and CourseSyllabus",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            "Curriculum Components of ${list.specializationName}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                     
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('No.'),
                                Text('Code'),
                                Column(
                                  children: [
                                    Text('Knowledge'),
                                    Text('Area'),
                                  ],
                                ),
                                Text('Credit Hours(3)'),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          'Planning Study for General',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          color: Colors.grey,
                          height: 100,
                          child: FutureBuilder(
                            future: _dataCourse,
                            builder: (_, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                if (snapshot.hasError) {
                                  return Text("some error");
                                } else if (snapshot.hasData == null) {
                                  return Text("No data found");
                                } else if (snapshot.hasData) {
                                  return Text("No data found");
                                }
                                return ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (ctx, index) {
                                    return Container(
                                      height: 100, //this size
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          //const SizedBox(height: 15),
                                          Card(
                                            elevation: 10,
                                            child: Column(
                                              children: [
                                                Text(
                                                    "${CourseList![index].unitName}"),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    //	Knowledge Unit	Credit Hours(3)
                                                    Text('No.'),
                                                    Text("Code"),
                                                    Text("Knowledge Unit"),
                                                    Text("Credit Hours"),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text('1'),
                                                    Text(
                                                        "${CourseList[index].code}"),
                                                    Text(
                                                        "${CourseList[index].knowledgeUnitName}"),
                                                    Text(
                                                        "${CourseList[index].totalCreditHours}"),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
               
                        Container(
                          height: 333,
                          child: FutureBuilder(
                            future: _dataCourse,
                            builder: (_, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                if (snapshot.hasError) {
                                  return Text("some error");
                                } else if (snapshot.hasData == null) {
                                  return Text("No data found");
                                } else if (snapshot.hasData) {
                                  return Text("No data found");
                                }
                                return ListView.builder(
                                  itemCount: CourseList!.length,
                                  itemBuilder: (ctx, index) {
                                    return Column(
                                      children: [
                                        Container(
                                          height: 70, //this size
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("Code"),
                                                  Text(
                                                      "${CourseList[index].semesterName}"),
                                                  Text("CH"),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      "${CourseList[index].code}"),
                                                  Text(
                                                      "${CourseList[index].unitName}"),
                                                  Text(
                                                      "${CourseList[index].totalCreditHours}"),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                            "Total Credit Hours :${CourseList[index].totalCreditHours}"),
                                        const SizedBox(height: 10),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                        Text(
                          "Course Specification for All Semesters",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 333,
                          child: FutureBuilder(
                            future: _dataCourse,
                            builder: (_, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                if (snapshot.hasError) {
                                  return Text("some error");
                                } else if (snapshot.hasData == null) {
                                  return Text("No data found");
                                } else if (snapshot.hasData) {
                                  return Text("No data found");
                                }
                                return ListView.builder(
                                  itemCount: CourseList!.length,
                                  itemBuilder: (ctx, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Course Code"),
                                            Text("Course Name"),
                                            Text("Credit Hours"),
                                          ],
                                        ),
                                        Container(
                                          height: 70, //this size
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("${CourseList[index].code}"),
                                              Text(
                                                  "${CourseList[index].unitName}"),
                                              Text(
                                                  "${CourseList[index].totalCreditHours}"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // child: Column(
                //   children: [
                //     Text('Faculty of Business Administration'),
                //     FutureBuilder(
                //       future: _data,
                //       builder: (_, snapshot) {
                //         if (snapshot.connectionState == ConnectionState.waiting) {
                //           return Center(child: CircularProgressIndicator());
                //         } else {
                //           if (snapshot.hasError) {
                //             return Text("some error");
                //           } else if (snapshot.hasData == null) {
                //             return Text("No data found");
                //           } else if (snapshot.hasData) {
                //             return Text("No data found");
                //           }
                //           return Column(
                //             children: [
                //               Container(
                //                 //size.height / 1.3,
                //                 height: 111,
                //                 child: ListView.builder(
                //                   itemCount: CurriculumList.length,
                //                   itemBuilder: (ctx, index) {
                //                     String dateFromDB = "";
                //                     dateFromDB = "${CurriculumList[index].dateFrom}";
                //                     var dateFromDay = DateTime.parse(dateFromDB).day;
                //                     var dateFromMonth =
                //                         DateTime.parse(dateFromDB).month;
                //                     var dateFromYear = DateTime.parse(dateFromDB).year;
                //                     //dateTo
                //                     return Container(
                //                       height: 100,
                //                       decoration: BoxDecoration(
                //                         color: Colors.white,
                //                         borderRadius: BorderRadius.all(
                //                           Radius.circular(10),
                //                         ),
                //                       ),
                //                       child: Column(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.spaceAround,
                //                         children: [
                //                           Container(
                //                             // width: 800,
                //                             child: Text(
                //                               "${CurriculumList[index].curriculumName}",
                //                               // overflow: TextOverflow.ellipsis,
                //                               style: TextStyle(
                //                                   color: Colors.black54,
                //                                   fontSize: 14,
                //                                   fontWeight: FontWeight.normal),
                //                               textAlign: TextAlign.center,
                //                             ),
                //                           ),
                //                           Text(
                //                             "$dateFromYear-$dateFromMonth-$dateFromDay",
                //                             overflow: TextOverflow.ellipsis,
                //                             style: TextStyle(
                //                                 color: Colors.black54,
                //                                 fontSize: 14,
                //                                 fontWeight: FontWeight.normal),
                //                             textAlign: TextAlign.center,
                //                           ),
                //                         ],
                //                       ),
                //                     );
                //                   },
                //                 ),
                //               ),
                //               Card(
                //                 color: Theme.of(context).colorScheme.primary,
                //                 margin: EdgeInsets.all(10),
                //                 child: Padding(
                //                   padding: const EdgeInsets.only(
                //                       left: 20, right: 20, top: 10, bottom: 10),
                //                   child: Row(
                //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //                     children: [
                //                       Text(
                //                         'curriculum Name',
                //                         style: TextStyle(color: Colors.white),
                //                       ),
                //                       Text(
                //                         'Date From',
                //                         style: TextStyle(color: Colors.white),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           );
                //         }
                //       },
                //     ),
                //     FutureBuilder(
                //       future: _data,
                //       builder: (_, snapshot) {
                //         if (snapshot.connectionState == ConnectionState.waiting) {
                //           return Center(child: CircularProgressIndicator());
                //         } else {
                //           if (snapshot.hasError) {
                //             return Text("some error");
                //           } else if (snapshot.hasData == null) {
                //             return Text("No data found");
                //           } else if (snapshot.hasData) {
                //             return Text("No data found");
                //           }
                //           return ListView.builder(
                //             itemCount: CurriculumList.length,
                //             itemBuilder: (ctx, index) {
                //               var list = profileList[index];
                //               return Container(
                //                 height: 400,
                //                 decoration: BoxDecoration(
                //                   color: Colors.white,
                //                   borderRadius: BorderRadius.all(
                //                     Radius.circular(10),
                //                   ),
                //                 ),
                //                 child: Column(
                //                   children: [
                //                     ListTile(
                //                       trailing: Text('Program Name'),
                //                       leading: Text('No.'),
                //                     ),
                //                     ListTile(
                //                       trailing: Text("${list.programNameEn}"),
                //                       leading: Text('1'),
                //                     ),
                //                   ],
                //                 ),
                //               );
                //             },
                //           );
                //         }
                //       },
                //     ),
                //     Column(
                //       children: [
                //         Text('Faculty of Business Administration'),
                //         Text('test he portal'),
                //         Text('23/11/2021'),
                //       ],
                //     ),
                //     ListTile(
                //       trailing: Text('Program Name'),
                //       leading: Text('No.'),
                //     ),
                //     ListTile(
                //       trailing: Text('Bachelor'),
                //       leading: Text('23/11/2021'),
                //     ),
                //     Text('Curriculum for Bachelor'),
                //     ListTile(
                //       leading: Text('No.'),
                //       trailing: Text('Specialization Name'),
                //     ),
                //     ListTile(
                //       leading: Text('1.'),
                //       trailing: Text('General'),
                //     ),
                //   ],
                // ),
              ),
        disconnected: Center(key: UniqueKey(), child: ConnectionStatuesBars()),
      ),
    );
  }
}

/*
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view_models/curriculum_view_model.dart';
import 'package:edu_pro/view_models/profile_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Curriculum extends StatefulWidget {
  const Curriculum({Key? key}) : super(key: key);
  static const routeName = 'Curriculum';

  @override
  _CurriculumState createState() => _CurriculumState();
}

class _CurriculumState extends State<Curriculum> {
  var _isLoading = false;
  Future? _data, _dataProfile, _dataCourse;
  var api = Api();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });
    _data = Provider.of<CurriculumViewModel>(context, listen: false)
        .fetchCurriculum()
        .then((_) => setState(() {
              _isLoading = false;
            }));
    _dataCourse = Provider.of<CurriculumViewModel>(context, listen: false)
        .fetchCurriculumCourse()
        .then((_) => setState(() {
              _isLoading = false;
            }));

    _dataProfile = Provider.of<ProfileViewModel>(context, listen: false)
        .fetchProfile()
        .then((_) => setState(() {
              _isLoading = false;
            }));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var CurriculumList =
        Provider.of<CurriculumViewModel>(context, listen: false).CurriculumList;

    var profileList =
        Provider.of<ProfileViewModel>(context, listen: false).ProfileList;
    var CourseList = Provider.of<CurriculumViewModel>(context, listen: false)
        .CurriculumCourseList;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Curriculum',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: api.isServerError
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'assets/warning.gif',
                      // color: Colors.blue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      'Server error please try again later',
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.background),
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.grey,
                    height: 111,
                    child: FutureBuilder(
                      future: _data,
                      builder: (_, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          if (snapshot.hasError) {
                            return Text("some error");
                          } else if (snapshot.hasData == null) {
                            return Text("No data found");
                          } else if (snapshot.hasData) {
                            return Text("No data found");
                          }
                          return ListView.builder(
                            itemCount: CurriculumList.length,
                            itemBuilder: (ctx, index) {
                              var list = profileList[index];
                              String dateFromDB = "";
                              dateFromDB = "${CurriculumList[index].dateFrom}";
                              var dateFromDay = DateTime.parse(dateFromDB).day;
                              var dateFromMonth =
                                  DateTime.parse(dateFromDB).month;
                              var dateFromYear =
                                  DateTime.parse(dateFromDB).year;
                              return Container(
                                height: size.height, //this size
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "${list.facultyName}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${CurriculumList[index].curriculumName}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "$dateFromYear-$dateFromMonth-$dateFromDay",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    ListTile(
                                      trailing: Text('Program Name'),
                                      leading: Text('No.'),
                                    ),
                                    ListTile(
                                      trailing: Text("${list.programNameEn}"),
                                      leading: Text('1'),
                                    ),
                                    Text(
                                      "Curriculum for ${list.programNameEn}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    ListTile(
                                      trailing: Text('Specialization Name'),
                                      leading: Text('No.'),
                                    ),
                                    ListTile(
                                      trailing:
                                          Text("${list.specializationName}"),
                                      leading: Text('1'),
                                    ),
                                    Text(
                                      "${list.specializationName}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Program Structure and CourseSyllabus",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "Curriculum Components of ${list.specializationName}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('No.'),
                          Text('Code'),
                          Column(
                            children: [
                              Text('Knowledge'),
                              Text('Area'),
                            ],
                          ),
                          Text('Credit Hours(3)'),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    'Planning Study for General',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 55,
                    child: FutureBuilder(
                      future: _dataCourse,
                      builder: (_, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          if (snapshot.hasError) {
                            return Text("some error");
                          } else if (snapshot.hasData == null) {
                            return Text("No data found");
                          } else if (snapshot.hasData) {
                            return Text("No data found");
                          }
                          return ListView.builder(
                            itemCount: CourseList.length,
                            itemBuilder: (ctx, index) {
                              return Container(
                                height:
                                    size.height / CourseList.length, //this size
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 15),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text('1'),
                                    //     Text("${CourseList[index].code}"),
                                    //     Text("${CourseList[index].unitName}"),
                                    //     Text("${CourseList[index].totalCreditHours}"),
                                    //   ],
                                    // ),

                                    Card(
                                      elevation: 10,
                                      child: Column(
                                        children: [
                                          Text("${CourseList[index].unitName}"),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              //	Knowledge Unit	Credit Hours(3)
                                              Text('No.'),
                                              Text("Code"),
                                              Text("Knowledge Unit"),
                                              Text("Credit Hours"),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('1'),
                                              Text("${CourseList[index].code}"),
                                              Text(
                                                  "${CourseList[index].knowledgeUnitName}"),
                                              Text(
                                                  "${CourseList[index].totalCreditHours}"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    height: 333,
                    child: FutureBuilder(
                      future: _dataCourse,
                      builder: (_, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          if (snapshot.hasError) {
                            return Text("some error");
                          } else if (snapshot.hasData == null) {
                            return Text("No data found");
                          } else if (snapshot.hasData) {
                            return Text("No data found");
                          }
                          return ListView.builder(
                            itemCount: CourseList.length,
                            itemBuilder: (ctx, index) {
                              return Column(
                                children: [
                                  Container(
                                    height: 70, //this size
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Code"),
                                            Text(
                                                "${CourseList[index].semesterName}"),
                                            Text("CH"),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("${CourseList[index].code}"),
                                            Text(
                                                "${CourseList[index].unitName}"),
                                            Text(
                                                "${CourseList[index].totalCreditHours}"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                      "Total Credit Hours :${CourseList[index].totalCreditHours}"),
                                  const SizedBox(height: 10),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Text(
                    "Course Specification for All Semesters",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              // child: Column(
              //   children: [
              //     Text('Faculty of Business Administration'),
              //     FutureBuilder(
              //       future: _data,
              //       builder: (_, snapshot) {
              //         if (snapshot.connectionState == ConnectionState.waiting) {
              //           return Center(child: CircularProgressIndicator());
              //         } else {
              //           if (snapshot.hasError) {
              //             return Text("some error");
              //           } else if (snapshot.hasData == null) {
              //             return Text("No data found");
              //           } else if (snapshot.hasData) {
              //             return Text("No data found");
              //           }
              //           return Column(
              //             children: [
              //               Container(
              //                 //size.height / 1.3,
              //                 height: 111,
              //                 child: ListView.builder(
              //                   itemCount: CurriculumList.length,
              //                   itemBuilder: (ctx, index) {
              //                     String dateFromDB = "";
              //                     dateFromDB = "${CurriculumList[index].dateFrom}";
              //                     var dateFromDay = DateTime.parse(dateFromDB).day;
              //                     var dateFromMonth =
              //                         DateTime.parse(dateFromDB).month;
              //                     var dateFromYear = DateTime.parse(dateFromDB).year;
              //                     //dateTo
              //                     return Container(
              //                       height: 100,
              //                       decoration: BoxDecoration(
              //                         color: Colors.white,
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(10),
              //                         ),
              //                       ),
              //                       child: Column(
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.spaceAround,
              //                         children: [
              //                           Container(
              //                             // width: 800,
              //                             child: Text(
              //                               "${CurriculumList[index].curriculumName}",
              //                               // overflow: TextOverflow.ellipsis,
              //                               style: TextStyle(
              //                                   color: Colors.black54,
              //                                   fontSize: 14,
              //                                   fontWeight: FontWeight.normal),
              //                               textAlign: TextAlign.center,
              //                             ),
              //                           ),
              //                           Text(
              //                             "$dateFromYear-$dateFromMonth-$dateFromDay",
              //                             overflow: TextOverflow.ellipsis,
              //                             style: TextStyle(
              //                                 color: Colors.black54,
              //                                 fontSize: 14,
              //                                 fontWeight: FontWeight.normal),
              //                             textAlign: TextAlign.center,
              //                           ),
              //                         ],
              //                       ),
              //                     );
              //                   },
              //                 ),
              //               ),
              //               Card(
              //                 color: Theme.of(context).colorScheme.primary,
              //                 margin: EdgeInsets.all(10),
              //                 child: Padding(
              //                   padding: const EdgeInsets.only(
              //                       left: 20, right: 20, top: 10, bottom: 10),
              //                   child: Row(
              //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //                     children: [
              //                       Text(
              //                         'curriculum Name',
              //                         style: TextStyle(color: Colors.white),
              //                       ),
              //                       Text(
              //                         'Date From',
              //                         style: TextStyle(color: Colors.white),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           );
              //         }
              //       },
              //     ),
              //     FutureBuilder(
              //       future: _data,
              //       builder: (_, snapshot) {
              //         if (snapshot.connectionState == ConnectionState.waiting) {
              //           return Center(child: CircularProgressIndicator());
              //         } else {
              //           if (snapshot.hasError) {
              //             return Text("some error");
              //           } else if (snapshot.hasData == null) {
              //             return Text("No data found");
              //           } else if (snapshot.hasData) {
              //             return Text("No data found");
              //           }
              //           return ListView.builder(
              //             itemCount: CurriculumList.length,
              //             itemBuilder: (ctx, index) {
              //               var list = profileList[index];
              //               return Container(
              //                 height: 400,
              //                 decoration: BoxDecoration(
              //                   color: Colors.white,
              //                   borderRadius: BorderRadius.all(
              //                     Radius.circular(10),
              //                   ),
              //                 ),
              //                 child: Column(
              //                   children: [
              //                     ListTile(
              //                       trailing: Text('Program Name'),
              //                       leading: Text('No.'),
              //                     ),
              //                     ListTile(
              //                       trailing: Text("${list.programNameEn}"),
              //                       leading: Text('1'),
              //                     ),
              //                   ],
              //                 ),
              //               );
              //             },
              //           );
              //         }
              //       },
              //     ),
              //     Column(
              //       children: [
              //         Text('Faculty of Business Administration'),
              //         Text('test he portal'),
              //         Text('23/11/2021'),
              //       ],
              //     ),
              //     ListTile(
              //       trailing: Text('Program Name'),
              //       leading: Text('No.'),
              //     ),
              //     ListTile(
              //       trailing: Text('Bachelor'),
              //       leading: Text('23/11/2021'),
              //     ),
              //     Text('Curriculum for Bachelor'),
              //     ListTile(
              //       leading: Text('No.'),
              //       trailing: Text('Specialization Name'),
              //     ),
              //     ListTile(
              //       leading: Text('1.'),
              //       trailing: Text('General'),
              //     ),

              //   ],

              // ),
            ),
    );
  }
}

*/
