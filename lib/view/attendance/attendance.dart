import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view/attendance/attendance_more.dart';
import 'package:edu_pro/view_models/attendance_view_model.dart';
import 'package:edu_pro/view_models/subject_view_model.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:edu_pro/widget/error_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);
  static const routeName = "attendance";

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  bool _isLoading = false;

  bool isSelectedSubject = false;

  String? _valueSubject;

  Future? _data, _dataAttendance, _dataSubject;
  var api = Api();

  @override
  void initState() {
    super.initState();

    _dataSubject =
        Provider.of<SubjectAttendanceViewModel>(context, listen: false)
            .fetchSubjectAttendance()
            .then((_) => setState(() {
                  _isLoading = false;
                }));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var list =
        Provider.of<AttendanceViewModel>(context, listen: false).AttendanceList;
    var listSubject =
        Provider.of<SubjectAttendanceViewModel>(context, listen: false)
            .SubjectAttendanceList;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Home.routeName, (route) => false);
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
        connected: listSubject == null
            ? ErrorConnection(message: 'Server error please try again later')
            : listSubject.length == 0
                ? ErrorConnection(message: 'No Data Found')
                : _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(height: 15),
                              Container(
                                height: 100,
                                child: FutureBuilder(
                                  future: _dataSubject,
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
                                      return Container(
                                        height: size.height,
                                        child: ListView.builder(
                                          itemCount: 1,
                                          itemBuilder: (context, index) {
                                            return Container(
                                                height: size.height / 13,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  border: Border.all(
                                                      color: isSelectedSubject
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .primary
                                                          : Colors.black45,
                                                      width: 1),
                                                ),
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 12),
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                            child:
                                                                DropdownButton<
                                                                        String>(
                                                                    focusColor: Colors
                                                                        .green,
                                                                    hint: const Text(
                                                                        "Select Subject"),
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .primary),
                                                                    value:
                                                                        _valueSubject,
                                                                    isExpanded:
                                                                        true,
                                                                    iconSize:
                                                                        28,
                                                                    icon: Icon(
                                                                        Icons
                                                                            .arrow_drop_down,
                                                                        color: isSelectedSubject
                                                                            ? Theme.of(context)
                                                                                .colorScheme
                                                                                .primary
                                                                            : Colors
                                                                                .black45),
                                                                    items:
                                                                        listSubject
                                                                            .map(
                                                                              (item) => DropdownMenuItem<String>(
                                                                                child: Text(item.subjectName.toString()),
                                                                                value: item.courseId.toString(),
                                                                              ),
                                                                            )
                                                                            .toList(),
                                                                    onChanged: (value) =>
                                                                        setState(
                                                                            () {
                                                                          isSelectedSubject =
                                                                              true;
                                                                          this._valueSubject =
                                                                              value;
                                                                          _dataAttendance =
                                                                              AllApi().fetchAttendance(int.parse(_valueSubject.toString())); //courseId
                                                                          _data = Provider.of<AttendanceViewModel>(context, listen: false)
                                                                              .fetchAttendance(int.parse(_valueSubject.toString()))
                                                                              .then((value) {
                                                                            setState(
                                                                              () {
                                                                                _isLoading = false;
                                                                              },
                                                                            );
                                                                          });

                                                                          print(
                                                                              "courseId : $value");

                                                                          // String? _vB;
                                                                          // _valueSubject = _vB;
                                                                        })))));
                                          },
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 15),
                              list!.length == 0
                                  ? Center(
                                      child: Column(
                                        children: [
                                          isSelectedSubject
                                              ? Container(
                                                  width: 100,
                                                  height: 100,
                                                  child: Image.asset(
                                                    'assets/warning.gif',
                                                    // color: Colors.blue,
                                                  ),
                                                )
                                              : Text(''),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: Text(
                                              isSelectedSubject
                                                  ? 'No Data Found!'
                                                  : '',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : !isSelectedSubject
                                      ? Text('')
                                      : Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          shadowColor: Colors.grey,
                                          elevation: 10,
                                          child: FutureBuilder(
                                              future: _dataAttendance,
                                              builder: (context, snapshot) {
                                                print(
                                                    "snapshot ${snapshot.data}");

                                                return Container(
                                                  height: 220,
                                                  child: snapshot.data == null
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        )
                                                      : ListView.builder(
                                                          itemCount: 1,
                                                          itemBuilder:
                                                              (ctx, index) {
                                                            return Column(
                                                              children: [
                                                                ListTile(
                                                                  title: Text(
                                                                    'Absence Percentage',
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .onSurface,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                  trailing:
                                                                      Text(
                                                                    "${(snapshot.data as Map)['absencePercentage']}",
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .onSurface,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ),
                                                                ListTile(
                                                                  title: Text(
                                                                    'Lectures Attending',
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .onSurface,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                  trailing:
                                                                      Text(
                                                                    "${(snapshot.data as Map)['attended']}",
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .onSurface,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ),
                                                                ListTile(
                                                                  title: Text(
                                                                    'Lectures Absence',
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .onSurface,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                  trailing:
                                                                      Text(
                                                                    "${(snapshot.data as Map)['absent']}",
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .onSurface,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(MaterialPageRoute(
                                                                            builder: (ctx) => AttendanceMore(
                                                                                  absencePercentage: "${(snapshot.data as Map)['absencePercentage']}",
                                                                                  totalNumberOfLecture: "${(snapshot.data as Map)['totalLecture']}",
                                                                                )));
                                                                  },
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .info,
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .primary,
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              10),
                                                                      Text(
                                                                        'More Info',
                                                                        style:
                                                                            TextStyle(
                                                                          color: Theme.of(context)
                                                                              .colorScheme
                                                                              .primary,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                              ],
                                                            );
                                                          }),
                                                );
                                              }),
                                        ),
                            ],
                          ),
                        ),
                      ),
        disconnected: Center(key: UniqueKey(), child: ConnectionStatuesBars()),
      ),
    );
  }
}
