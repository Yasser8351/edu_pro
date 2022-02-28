import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/view_models/curriculum_view_model.dart';
import 'package:edu_pro/view_models/profile_view_model.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:edu_pro/widget/error_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Course_specification.dart';
import 'planning_study.dart';
import 'program_structure.dart';

class HomeCurriculum extends StatefulWidget {
  const HomeCurriculum({Key? key}) : super(key: key);

  static const routeName = 'CurriculumHome';

  @override
  _HomeCurriculumState createState() => _HomeCurriculumState();
}

class _HomeCurriculumState extends State<HomeCurriculum> {
  var _isLoading = false;
  Future? _data, _dataProfile, _dataCourse;

  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var CurriculumList =
        Provider.of<CurriculumViewModel>(context, listen: false).CurriculumList;

    var profileList =
        Provider.of<ProfileViewModel>(context, listen: false).ProfileList;
    var CourseList = Provider.of<CurriculumViewModel>(context, listen: false);
    print("CourseList ${CurriculumList!}");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Curriculum",
          style: TextStyle(color: Colors.white),
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
          if (connected == null) return;
          print(connected);
        },
        connected: CurriculumList == null
            ? ErrorConnection(message: "Server error please try again later")
            : CurriculumList.length == 0
                ? ErrorConnection(message: "No data found")
                : Container(
                    height: size.height,
                    // height: size.height / 1.5,
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
                            shrinkWrap: true,
                            itemCount: CurriculumList.length,
                            itemBuilder: (ctx, index) {
                              var list = profileList![index];
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Card(
                                        elevation: 10,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 13),
                                            Text(
                                              "${list.facultyName}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                            Text(
                                              "${CurriculumList[index].curriculumName}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                            Text(
                                              "$dateFromYear-$dateFromMonth-$dateFromDay",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                            ListTile(
                                              trailing: Text(
                                                'Program Name',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                              leading: Text(
                                                'No.',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                            ListTile(
                                              trailing: Text(
                                                "${list.programNameEn}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                              leading: Text(
                                                '1',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "Curriculum for ${list.programNameEn}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                            ListTile(
                                              trailing: Text(
                                                'Specialization Name',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                              leading: Text(
                                                'No.',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                            ListTile(
                                              trailing: Text(
                                                "${list.specializationName}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                              leading: Text(
                                                '1',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    ProgramStructure(
                                                      facultyName:
                                                          "${list.facultyName}",
                                                    )));
                                      },
                                      child: Card(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                    'Program Structure and Course Syllabus',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.navigate_next,
                                                  size: 35,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (ctx) => PlanningStudy(
                                                      ListCourse: CourseList,
                                                    )));
                                      },
                                      child: Card(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                    'Planning Study',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.navigate_next,
                                                  size: 35,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    CourseSpecification()));
                                      },
                                      child: Card(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                    'Course Specification for All Semesters',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.navigate_next,
                                                  size: 35,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ],
                                            )),
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
        disconnected: Center(key: UniqueKey(), child: ConnectionStatuesBars()),
      ),
    );
  }
}
