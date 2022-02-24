import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view/timetable/timetable.dart';
import 'package:edu_pro/view_models/lecture_timetable_view_model.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:edu_pro/widget/error_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LectureTimetable extends StatefulWidget {
  const LectureTimetable({Key? key}) : super(key: key);
  static const routeName = 'lecture';

  @override
  State<LectureTimetable> createState() => _LectureTimetableState();
}

class _LectureTimetableState extends State<LectureTimetable> {
  Future? _data;
  int _index = 0;
  bool isSelectedDay = true;

  bool _isLoading = false;

  String? _valueDay = 'Saturday';
  var _isInit = true;
  var api = Api();

  final _listDayes = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  @override
  void initState() {
    super.initState();
    _isLoading = true;
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      _data = Provider.of<LectureTimetableViewModel>(context, listen: false)
          .fetchLectureTimetable("$_valueDay")
          .then((_) => setState(() {
                _isLoading = false;
              }));
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var LectureList =
        Provider.of<LectureTimetableViewModel>(context, listen: false)
            .LectureTimetableList;
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
          'Lecture Timetable',
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
        connected: LectureList == null
            ? ErrorConnection(message: 'Server error please try again later')
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: isSelectedDay
                                ? Theme.of(context).colorScheme.primary
                                : Colors.black38,
                            width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            focusColor: Colors.green,
                            hint: const Text("Select Day"),
                            style: TextStyle(
                                color: isSelectedDay
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey[700]),
                            value: _valueDay,
                            isExpanded: true,
                            iconSize: 28,
                            icon: Icon(Icons.arrow_drop_down,
                                color: isSelectedDay
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.black38),
                            items: _listDayes
                                .map((String item) => DropdownMenuItem<String>(
                                    child: Text(item), value: item))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                print("$_valueDay");
                                isSelectedDay = true;
                                _valueDay = value.toString();
                                _data = Provider.of<LectureTimetableViewModel>(
                                        context,
                                        listen: false)
                                    .fetchLectureTimetable("$_valueDay")
                                    .then((_) => setState(() {
                                          _isLoading = false;
                                        }));
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  LectureList.length == 0
                      ? Center(
                          child: Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Text(
                            '',
                            style: TextStyle(fontSize: 20),
                          ),
                        ))
                      : Card(
                          color: Theme.of(context).colorScheme.primary,
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(
                              "$_valueDay",
                              //"${LectureList[_index].dayName}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                  LectureList.isEmpty
                      ? ErrorConnection(
                          message: isSelectedDay ? 'No Data Found' : '')
                      : Container(
                          height: size.height / 1.6,
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
                                    height: 400,
                                    child: ListView.builder(
                                      itemCount: LectureList.length,
                                      itemBuilder: (context, index) {
                                        _index = index;

                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "Lecture ${LectureList.length}",
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  "${LectureList[index].title}",
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${LectureList[index].startTime} - ",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                    Text(
                                                      "${LectureList[index].endTime}",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  "${LectureList[index].weekName}",
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  "${LectureList[index].hallName}",
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                ),
                                              ],
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
                ],
              ),
        disconnected: Center(key: UniqueKey(), child: ConnectionStatuesBars()),
      ),
    );
  }
}
