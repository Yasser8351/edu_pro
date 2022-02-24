import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view/timetable/timetable.dart';
import 'package:edu_pro/view_models/exams_view_model.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExameTimetable extends StatefulWidget {
  const ExameTimetable({Key? key}) : super(key: key);
  static const routeName = 'Exam';

  @override
  State<ExameTimetable> createState() => _ExameTimetableState();
}

class _ExameTimetableState extends State<ExameTimetable> {
  Future? _data;
  var api = Api();

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    setState(
      () {
        _data = Provider.of<ExamsViewModel>(context, listen: false)
            .fetchExams()
            .then((_) => setState(() {
                  _isLoading = false;
                }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var examList =
        Provider.of<ExamsViewModel>(context, listen: false).ExamsList;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Timetable.routeName, (route) => false);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          'Exams Timetable',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ConnectionNotifierToggler(
        onConnectionStatusChanged: (connected) {
          /// that means it is still in the initialization phase.
          if (connected == null) return;
          print(connected);
        },
        connected: examList == null
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
            : examList.length == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          child: Image.asset(
                            'assets/warning.gif',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            'No Data Found',
                            style: TextStyle(
                                fontSize: 20,
                                color:
                                    Theme.of(context).colorScheme.background),
                          ),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Container(
                        height: size.height,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                return Container(
                                  //height: size.height / 1.6,
                                  //color: Colors.grey,
                                  //height: 600,
                                  child: ListView.builder(
                                    itemCount: examList.length,
                                    itemBuilder: (context, index) {
                                      // String dateToDB = "";
                                      // dateToDB = "${examList[index].endDate}";
                                      // var dateToDay = DateTime.parse(dateToDB).day;
                                      // var dateToMonth =
                                      //     DateTime.parse(dateToDB).month;
                                      // var dateToYear = DateTime.parse(dateToDB).year;

                                      String dateFromDB = "";
                                      dateFromDB =
                                          "${examList[index].startDate}";
                                      var dateFromDay =
                                          DateTime.parse(dateFromDB).day;
                                      var dateFromMonth =
                                          DateTime.parse(dateFromDB).month;
                                      var dateFromYear =
                                          DateTime.parse(dateFromDB).year;

                                      var year =
                                          " $dateFromYear-$dateFromMonth-$dateFromDay";
                                      // var hourStart = DateTime.parse(
                                      //     "${examList[index].startDate}");
                                      // var minuteStart = DateTime.parse(
                                      //         "${examList[index].startDate}")
                                      //     .minute;
                                      // var microsecondStart = DateTime.parse(
                                      //         "${examList[index].startDate}")
                                      // .microsecond;
                                      // var day = TimeOfDay.fromDateTime(
                                      //     DateTime.parse(dateFromDB));
                                      // String date = DateFormat.yMMMd()
                                      //     .add_Hm()
                                      //     .format(DateTime.parse(dateFromDB));
                                      //print("day : $date");
                                      // var sd = DateFormat.yMMMMEEEEd()
                                      //     .format(DateTime.parse(dateFromDB));
                                      var day = DateFormat.EEEE()
                                          .format(DateTime.parse(dateFromDB));

                                      return Column(
                                        children: [
                                          Card(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onError,
                                            margin: EdgeInsets.all(10),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Container(
                                                width: double.infinity,
                                                child: Center(
                                                  child: Text(
                                                    "${examList[index].title}",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            margin: EdgeInsets.all(10),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 1,
                                                      horizontal: 1),
                                              child: ListTile(
                                                title: Text(
                                                  'Days',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                trailing: Text(
                                                  'Time        ',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            margin: EdgeInsets.all(10),
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                    '$day',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .background),
                                                  ),
                                                  subtitle: Text(
                                                    '$year',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .background),
                                                  ),
                                                  trailing: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        DateFormat("hh:mm a")
                                                            .format(DateTime.parse(
                                                                "${examList[index].startDate}")),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                      Text(
                                                        DateFormat("hh:mm a")
                                                            .format(DateTime.parse(
                                                                "${examList[index].endDate}")),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                );
                              }
                            },
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
