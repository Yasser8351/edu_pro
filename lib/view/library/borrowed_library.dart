//DigetialLibrary
import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view/library/library.dart';
import 'package:edu_pro/view_models/library/library_brrowed_view_model.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';

class BorrowedLibrary extends StatefulWidget {
  const BorrowedLibrary({Key? key}) : super(key: key);
  static const routeName = 'Borrowed';

  @override
  State<BorrowedLibrary> createState() => _BorrowedLibraryState();
}

class _BorrowedLibraryState extends State<BorrowedLibrary> {
  Future? _data;

  bool _isLoading = false;
  var api = Api();

  String d = "";
  DateTime? todayDate;
  @override
  void initState() {
    super.initState();
    _isLoading = true;

    _data = Provider.of<LibraryBorrowViewModel>(context, listen: false)
        .fetchBorrow()
        .then((_) => setState(() {
              _isLoading = false;
            }));
  }

  void convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);
    print(formatDate(DateTime(1989, 2, 21), [yy, '-', M, '-', d]));
    print(todayDate);
    print(formatDate(todayDate,
        [yyyy, '/', mm, '/', dd, ' ', hh, ':', nn, ':', ss, ' ', am]));
    todayDate = DateTime.parse("sss");
    print(formatDate(DateTime(1989, 2, 21), [yy, '-', M, '-', d]));
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    final size = MediaQuery.of(context).size;
    var borrowList =
        Provider.of<LibraryBorrowViewModel>(context, listen: false).BorrowList;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Library.routeName, (route) => false);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          'Borrowed Library',
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
        connected: borrowList == null
            ? Center(
                child: Stack(
                  children: [
                    Column(
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
                            'Server error please try again later',
                            style: TextStyle(
                                fontSize: 20,
                                color:
                                    Theme.of(context).colorScheme.background),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : borrowList.length == 0
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
                : Container(
                    child: Column(
                      children: [
                        Container(
                          height: 550,
                          child: Card(
                            margin: EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 20, right: 20),
                              child: Column(
                                children: [
                                  _isLoading
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
                                              return Column(
                                                children: [
                                                  Card(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    margin: EdgeInsets.all(0),
                                                    child: Padding(
                                                      //    padding: EdgeInsets.all(0),
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              right: 20,
                                                              top: 10,
                                                              bottom: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Book Title',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            'Borrow Date',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            'Due Date',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 100,
                                                    //color: Colors.black45,
                                                    margin: EdgeInsets.all(4),
                                                    child: FutureBuilder(
                                                      future: _data,
                                                      builder: (_, snapshot) {
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return Center(
                                                              child:
                                                                  CircularProgressIndicator());
                                                        } else {
                                                          if (snapshot
                                                              .hasError) {
                                                            return Text(
                                                                "some error");
                                                          } else if (snapshot
                                                                  .hasData ==
                                                              null) {
                                                            return Text(
                                                                "No data found");
                                                          } else if (snapshot
                                                              .hasData) {
                                                            return Text(
                                                                "No data found");
                                                          }
                                                          print(borrowList
                                                              .length);

                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Container(
                                                              height: 55,
                                                              child: ListView
                                                                  .builder(
                                                                itemCount:
                                                                    borrowList
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  String
                                                                      dateToDB =
                                                                      "";
                                                                  dateToDB =
                                                                      "${borrowList[index].bDate}";
                                                                  var dateToDay =
                                                                      DateTime.parse(
                                                                              dateToDB)
                                                                          .day;
                                                                  var dateToMonth =
                                                                      DateTime.parse(
                                                                              dateToDB)
                                                                          .month;
                                                                  var dateToYear =
                                                                      DateTime.parse(
                                                                              dateToDB)
                                                                          .year;

                                                                  String
                                                                      dateFromDB =
                                                                      "";
                                                                  dateFromDB =
                                                                      "${borrowList[index].dueDate}";
                                                                  var dateFromDay =
                                                                      DateTime.parse(
                                                                              dateFromDB)
                                                                          .day;
                                                                  var dateFromMonth =
                                                                      DateTime.parse(
                                                                              dateFromDB)
                                                                          .month;
                                                                  var dateFromYear =
                                                                      DateTime.parse(
                                                                              dateFromDB)
                                                                          .year;
                                                                  return Column(
                                                                    children: [
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("${borrowList[index].title}",
                                                                                  style: TextStyle(
                                                                                    color: Theme.of(context).colorScheme.primary,
                                                                                  )),
                                                                              Text("$dateFromYear-$dateFromMonth-$dateFromDay",
                                                                                  style: TextStyle(
                                                                                    color: Theme.of(context).colorScheme.primary,
                                                                                  )),
                                                                              Text("$dateToYear-$dateToMonth-$dateToDay",
                                                                                  style: TextStyle(
                                                                                    color: Theme.of(context).colorScheme.primary,
                                                                                  )),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          );
                                                        }
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
                      ],
                    ),
                  ),
        disconnected: Center(key: UniqueKey(), child: ConnectionStatuesBars()),
      ),
    );
  }
}
