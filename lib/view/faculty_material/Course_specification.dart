import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view_models/curriculum_view_model.dart';
import 'package:edu_pro/view_models/profile_view_model.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseSpecification extends StatefulWidget {
  const CourseSpecification({Key? key}) : super(key: key);
  static const routeName = 'CourseSpecification';

  @override
  __CourseSpecificationStateState createState() =>
      __CourseSpecificationStateState();
}

class __CourseSpecificationStateState extends State<CourseSpecification> {
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
          'Course Specification for All Semesters',
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
            ? Text('')
            : SizedBox(
                height: size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        elevation: 10,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Course Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  'Course Code',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            Container(
                              height: 100,
                              // height: size.height / 1.5,
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
                                      shrinkWrap: true,
                                      itemCount: CourseList!.length,
                                      itemBuilder: (ctx, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "${CourseList[index].courseOutcome}",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        "${CourseList[index].code}",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                            ],
                                          ),
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
                      Card(
                        elevation: 10,
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              // height: size.height / 1.5,
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
                                      shrinkWrap: true,
                                      itemCount: CourseList!.length,
                                      itemBuilder: (ctx, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "${CourseList[index].assesmentMethod}",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                            ],
                                          ),
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
                      Card(
                        elevation: 10,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Text(
                                'Course Properties',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Container(
                                height: size.height,
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
                                        shrinkWrap: true,
                                        itemCount: CourseList!.length,
                                        itemBuilder: (ctx, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 1),
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 20),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "Has Prize",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Icon(CourseList[index]
                                                                .hasPrize
                                                            ? Icons.check_box
                                                            : Icons
                                                                .check_box_outline_blank)
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "Count in GPA",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Icon(CourseList[index]
                                                                .countInGpa
                                                            ? Icons.check_box
                                                            : Icons
                                                                .check_box_outline_blank)
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "Linked to Subject	",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Icon(CourseList[index]
                                                                .linkedToSubject
                                                            ? Icons.check_box
                                                            : Icons
                                                                .check_box_outline_blank)
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 30),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "Continuous",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Icon(CourseList[index]
                                                                .isContinuous
                                                            ? Icons.check_box
                                                            : Icons
                                                                .check_box_outline_blank)
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "Elective",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Icon(CourseList[index]
                                                                .isElective
                                                            ? Icons.check_box
                                                            : Icons
                                                                .check_box_outline_blank)
                                                      ],
                                                    ),
                                                  ],
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
                            ],
                          ),
                        ),
                      ),

                      // Container(
                      //   height: 100,
                      //   // height: size.height / 1.5,
                      //   child: FutureBuilder(
                      //     future: _data,
                      //     builder: (_, snapshot) {
                      //       if (snapshot.connectionState ==
                      //           ConnectionState.waiting) {
                      //         return Center(child: CircularProgressIndicator());
                      //       } else {
                      //         if (snapshot.hasError) {
                      //           return Text("some error");
                      //         } else if (snapshot.hasData == null) {
                      //           return Text("No data found");
                      //         } else if (snapshot.hasData) {
                      //           return Text("No data found");
                      //         }
                      //         return ListView.builder(
                      //           shrinkWrap: true,
                      //           itemCount: CourseList!.length,
                      //           itemBuilder: (ctx, index) {
                      //             return Padding(
                      //               padding: const EdgeInsets.symmetric(
                      //                   horizontal: 10),
                      //               child: Column(
                      //                 children: [
                      //                   Column(
                      //                     mainAxisAlignment:
                      //                         MainAxisAlignment.start,
                      //                     children: [
                      //                       Row(
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment
                      //                                 .spaceBetween,
                      //                         children: [
                      //                           Text(
                      //                             "courseOutcome",
                      //                             style: TextStyle(
                      //                                 fontSize: 14,
                      //                                 fontWeight:
                      //                                     FontWeight.bold),
                      //                           ),
                      //                           Text(
                      //                             "reference",
                      //                             style: TextStyle(
                      //                                 fontSize: 14,
                      //                                 fontWeight:
                      //                                     FontWeight.bold),
                      //                           ),
                      //                         ],
                      //                       ),
                      //                       Row(
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment
                      //                                 .spaceBetween,
                      //                         children: [
                      //                           Text(
                      //                             "${CourseList[index].courseOutcome}",
                      //                             style: TextStyle(
                      //                                 fontSize: 14,
                      //                                 fontWeight:
                      //                                     FontWeight.bold),
                      //                           ),
                      //                           Container(
                      //                             width: 30,
                      //                             child: Text(
                      //                               "${CourseList[index].reference}",
                      //                               style: TextStyle(
                      //                                   fontSize: 14,
                      //                                   fontWeight:
                      //                                       FontWeight.bold),
                      //                             ),
                      //                           ),
                      //                         ],
                      //                       ),
                      //                     ],
                      //                   ),
                      //                   const SizedBox(height: 10),
                      //                 ],
                      //               ),
                      //             );
                      //           },
                      //         );
                      //       }
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
        disconnected: Center(key: UniqueKey(), child: ConnectionStatuesBars()),
      ),
    );
  }
}
