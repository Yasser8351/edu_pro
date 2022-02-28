import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/view_models/curriculum_view_model.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlanningStudy extends StatefulWidget {
  PlanningStudy({Key? key, this.ListCourse}) : super(key: key);
  static const routeName = 'PlanningStudy';
  var ListCourse;

  @override
  _PlanningStudyState createState() => _PlanningStudyState();
}

class _PlanningStudyState extends State<PlanningStudy> {
  var _isLoading = false;
  Future? _data, _dataProfile, _dataCourse;
  // var api = Api();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // setState(() {
    //   _isLoading = true;
    // });
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

    // _dataProfile = Provider.of<ProfileViewModel>(context, listen: false)
    //     .fetchProfile()
    //     .then((_) => setState(() {
    //           _isLoading = false;
    //         }));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var CurriculumList =
        Provider.of<CurriculumViewModel>(context, listen: false).CurriculumList;

    // var profileList =
    //     Provider.of<ProfileViewModel>(context, listen: false).ProfileList;
    var CourseList = Provider.of<CurriculumViewModel>(context, listen: false)
        .CurriculumCourseList;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Planning Study',
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Code",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Semester",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Credit Hours",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Container(
                            height: size.height / 5,
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
                                    itemCount: CourseList!.length,
                                    itemBuilder: (ctx, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, left: 10, right: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "1",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "${CourseList[index].knowledgeUnitName}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "${CourseList[index].totalCreditHours}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                ),
              ),
        disconnected: Center(key: UniqueKey(), child: ConnectionStatuesBars()),
      ),
    );
  }
}
