import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view/faculty_material/faculty_material.dart';
import 'package:edu_pro/view_models/calnder_view_model.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Calender extends StatefulWidget {
  const Calender({Key? key, this.isHome}) : super(key: key);
  static const routeName = "calender";
  final isHome;

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  var _isLoading = false;
  Future? _data;
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
    _data = Provider.of<CalenderViewModel>(context, listen: false)
        .fetchCalender()
        .then((_) => setState(() {
              _isLoading = false;
            }));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var list =
        Provider.of<CalenderViewModel>(context, listen: false).CalenderList;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calender',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            widget.isHome
                ? Navigator.of(context)
                    .pushNamedAndRemoveUntil(Home.routeName, (route) => false)
                : Navigator.of(context).pushNamedAndRemoveUntil(
                    FacultyMaterial.routeName, (route) => false);
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
        connected: list == null
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
            : list.length == 0
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
                                color:
                                    Theme.of(context).colorScheme.background),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : list.length == 0
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
                                        'No Data Found!',
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
                            : FutureBuilder(
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
                                    return Column(
                                      children: [
                                        Card(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          margin: EdgeInsets.all(10),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                top: 10,
                                                bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  'Topic',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  'From',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  'To',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          //height: size.height * .2,
                                          height: size.height / 1.3,

                                          child: ListView.builder(
                                            itemCount: list.length,
                                            itemBuilder: (ctx, index) {
                                              String dateToDB = "";
                                              dateToDB =
                                                  "${list[index].dateFrom}";
                                              var dateToDay =
                                                  DateTime.parse(dateToDB).day;
                                              var dateToMonth =
                                                  DateTime.parse(dateToDB)
                                                      .month;
                                              var dateToYear =
                                                  DateTime.parse(dateToDB).year;

                                              String dateFromDB = "";
                                              dateFromDB =
                                                  "${list[index].dateTo}";
                                              var dateFromDay =
                                                  DateTime.parse(dateFromDB)
                                                      .day;
                                              var dateFromMonth =
                                                  DateTime.parse(dateFromDB)
                                                      .month;
                                              var dateFromYear =
                                                  DateTime.parse(dateFromDB)
                                                      .year;

                                              //dateTo
                                              return Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                      width: 80,
                                                      child: Text(
                                                        "${list[index].topic}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    Text(
                                                      "$dateToYear-$dateToMonth-$dateToDay",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Text(
                                                      "$dateFromYear-$dateFromMonth-$dateFromDay",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
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
                  ),
        disconnected: Center(key: UniqueKey(), child: ConnectionStatuesBars()),
      ),
    );
  }
}
