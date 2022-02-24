import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view/attendance/attendance.dart';
import 'package:edu_pro/view_models/attendance_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AttendanceMore extends StatefulWidget {
  const AttendanceMore(
      {Key? key, this.totalNumberOfLecture, this.absencePercentage})
      : super(key: key);
  static const routeName = "attendance_more";
  final totalNumberOfLecture;
  final absencePercentage;

  @override
  State<AttendanceMore> createState() => _AttendanceState();
}

class _AttendanceState extends State<AttendanceMore> {
  Future? _data;
  bool _isLoading = false;
  var api = Api();

  @override
  void initState() {
    super.initState();

    _data = Provider.of<AttendanceViewModel>(context, listen: false)
        .fetchAttendance(6560)
        .then((_) => setState(() {
              _isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var list =
        Provider.of<AttendanceViewModel>(context, listen: false).AttendanceList;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'More Details',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                Attendance.routeName, (route) => false);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: list == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    child: Image.asset(
                      'assets/warning.png',
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
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Text('Attendance from 01/01/2021 - 01/01/2022'),
                      ListTile(
                        title: Text(
                          'Total Number of lectures',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 16),
                        ),
                        trailing: Text(
                          '${widget.totalNumberOfLecture}',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 16),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Absent Percentage',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 16),
                        ),
                        trailing: Text(
                          '${widget.absencePercentage}',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 16),
                        ),
                      ),
                      FutureBuilder(
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
                            return Column(
                              children: [
                                Container(
                                  height: size.height - 211,
                                  child: ListView.builder(
                                    //physics: NeverScrollableScrollPhysics(),
                                    itemCount: list.length,
                                    itemBuilder: (ctx, index) {
                                      String dateToDB = "";
                                      dateToDB = "${list[index].attendTime}";
                                      var hour = DateTime.parse(dateToDB).hour;
                                      var second =
                                          DateTime.parse(dateToDB).second;
                                      var minute =
                                          DateTime.parse(dateToDB).minute;
                                      var timeZoneName =
                                          DateTime.parse(dateToDB).millisecond;

                                      String dateFromDB = "";
                                      dateFromDB = "${list[index].attendDate}";
                                      var dateFromDay =
                                          DateTime.parse(dateFromDB).day;
                                      var dateFromMonth =
                                          DateTime.parse(dateFromDB).month;
                                      var dateFromYear =
                                          DateTime.parse(dateFromDB).year;
                                      return Card(
                                        margin: EdgeInsets.only(bottom: 30),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        shadowColor: Colors.grey,
                                        elevation: 10,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ListTile(
                                              title: Text(
                                                'Date',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface,
                                                    fontSize: 16),
                                              ),
                                              trailing: Text(
                                                "$dateFromYear-$dateFromMonth-$dateFromDay",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            ListTile(
                                              title: Text(
                                                'Time',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface,
                                                    fontSize: 16),
                                              ),
                                              trailing: Text(
                                                "${DateFormat('KK:mm:ss a').format(DateTime.parse(dateToDB))}",
                                                // "$hour-$minute-$second $timeZoneName",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            ListTile(
                                              title: Text(
                                                'Attendance Status',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface,
                                                    fontSize: 16),
                                              ),
                                              trailing: Text(
                                                "${list[index].isAbsentText}",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            // ListTile(
                                            //   title: Text(
                                            //     'courseName',
                                            //     style: TextStyle(
                                            //         color: Theme.of(context)
                                            //             .colorScheme
                                            //             .onSurface,
                                            //         fontSize: 16),
                                            //   ),
                                            //   trailing: Text(
                                            //     "${list[index].courseName}",
                                            //     style: TextStyle(
                                            //         color: Theme.of(context)
                                            //             .colorScheme
                                            //             .onSurface,
                                            //         fontSize: 16),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
