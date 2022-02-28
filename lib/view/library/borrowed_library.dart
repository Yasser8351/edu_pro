//DigetialLibrary
import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view/library/library.dart';
import 'package:edu_pro/view_models/library/library_brrowed_view_model.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:edu_pro/widget/error_connection.dart';
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
            ? ErrorConnection(message: "Server error please try again later")
            : borrowList.length == 0
                ? ErrorConnection(message: "No Data Found")
                : Container(
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
                                        child: CircularProgressIndicator());
                                  } else {
                                    if (snapshot.hasError) {
                                      return Text("some error");
                                    } else if (snapshot.hasData == null) {
                                      return Text("No data found");
                                    } else if (snapshot.hasData) {
                                      return Text("No data found");
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 10),
                                      child: Container(
                                        height: size.height - 200,
                                        child: ListView.builder(
                                          itemCount: borrowList.length,
                                          itemBuilder: (context, index) {
                                            String dateToDB = "";
                                            dateToDB =
                                                "${borrowList[index].bDate}";
                                            var dateToDay =
                                                DateTime.parse(dateToDB).day;
                                            var dateToMonth =
                                                DateTime.parse(dateToDB).month;
                                            var dateToYear =
                                                DateTime.parse(dateToDB).year;

                                            String dateFromDB = "";
                                            dateFromDB =
                                                "${borrowList[index].dueDate}";
                                            var dateFromDay =
                                                DateTime.parse(dateFromDB).day;
                                            var dateFromMonth =
                                                DateTime.parse(dateFromDB)
                                                    .month;
                                            var dateFromYear =
                                                DateTime.parse(dateFromDB).year;
                                            return Card(
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    leading: Text('Book Title',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        )),
                                                    trailing: Text(
                                                        "${borrowList[index].title}",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        )),
                                                  ),
                                                  ListTile(
                                                    leading: Text('Borrow Date',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        )),
                                                    trailing: Text(
                                                        "$dateFromYear-$dateFromMonth-$dateFromDay",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        )),
                                                  ),
                                                  ListTile(
                                                    leading: Text('Due Date',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        )),
                                                    trailing: Text(
                                                        "$dateToYear-$dateToMonth-$dateToDay",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                      ],
                    ),
                  ),
        disconnected: Center(key: UniqueKey(), child: ConnectionStatuesBars()),
      ),
    );
  }
}
