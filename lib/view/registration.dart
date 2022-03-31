import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:edu_pro/view_models/registration_view_model.dart';
import 'package:edu_pro/widget/app_drawer.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:edu_pro/widget/error_connection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'registration_details.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);
  static const routeName = 'Registration';

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool isSelectedSemester = false;
  Future? _data;

  bool _isLoading = false;
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy');
  final String currentYear = formatter.format(now);
  String currency = "sd";
  String paymentMethod = "Immediate"; // Immediate = 1, Installment = 2
  int currencyNo = 1;

  @override
  void initState() {
    super.initState();
    _isLoading = true;

    _data = Provider.of<RegistrationViewModel>(context, listen: false)
        .fetchRegistration()
        .then((_) => setState(() {
              _isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var registrationList =
        Provider.of<RegistrationViewModel>(context, listen: false)
            .registrationList;
    print('current Year $registrationList');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registration',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : registrationList == null
              ? ErrorConnection(message: "Server error please try again later")
              : ConnectionNotifierToggler(
                  onConnectionStatusChanged: (connected) {
                    if (connected == null) return;
                    print(connected);
                  },
                  connected: Center(
                    key: UniqueKey(),
                    child: SingleChildScrollView(
                      child: Container(
                        height: size.height,
                        child: _isLoading
                            ? Center(child: CircularProgressIndicator())
                            : Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    'Installments Policy',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 18),
                                  ),
                                  const SizedBox(height: 10),
                                  Card(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    margin: EdgeInsets.only(left: 5, right: 5),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Name',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            '              From',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            '             To',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'Percentage',
                                            style: TextStyle(
                                              color: Colors.white,
                                              //fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  FutureBuilder(
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
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          height: 230,
                                          // height: size.height *
                                          //     registrationList.length /
                                          //     5.2,
                                          child: ListView.builder(
                                            itemCount: registrationList.length,
                                            itemBuilder: (ctx, index) {
                                              String dateToDB = "";
                                              dateToDB =
                                                  "${registrationList[index].dateTo}";
                                              var dateToDay =
                                                  DateTime.parse(dateToDB).day;
                                              var dateToMonth =
                                                  DateTime.parse(dateToDB)
                                                      .month;
                                              var dateToYear =
                                                  DateTime.parse(dateToDB).year;

                                              String dateFromDB = "";
                                              dateFromDB =
                                                  "${registrationList[index].dateFrom}";
                                              var dateFromDay =
                                                  DateTime.parse(dateFromDB)
                                                      .day;
                                              var dateFromMonth =
                                                  DateTime.parse(dateFromDB)
                                                      .month;
                                              var dateFromYear =
                                                  DateTime.parse(dateFromDB)
                                                      .year;
                                              return Card(
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                elevation: 10,
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 15),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15,
                                                          horizontal: 4),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: 50,
                                                            child: Text(
                                                              '${registrationList[index].installmentName}',
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .background),
                                                            ),
                                                          ),
                                                          Text(
                                                            '$dateFromYear-$dateFromMonth-$dateFromDay',
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .background),
                                                          ),
                                                          Text(
                                                            '$dateToYear-$dateToMonth-$dateToDay',
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .background),
                                                          ),
                                                          Text(
                                                            '${registrationList[index].percentage.toString()}%  ',
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .background),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Select currency',
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Radio(
                                              value: "sd",
                                              groupValue: currency,
                                              onChanged: (value) {
                                                setState(() {
                                                  currency = value.toString();
                                                });
                                              }),
                                          Text("SDG"),
                                        ],
                                      ),
                                      const SizedBox(width: 20),
                                      Row(
                                        children: [
                                          Radio(
                                              value: "usd",
                                              groupValue: currency,
                                              onChanged: (value) {
                                                setState(() {
                                                  currency = value.toString();
                                                });
                                              }),
                                          Text("USD"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Row(
                                  //       children: [
                                  //         Radio(
                                  //             value: "Immediate",
                                  //             groupValue: paymentMethod,
                                  //             onChanged: (value) {
                                  //               setState(() {
                                  //                 paymentMethod = value.toString();
                                  //               });
                                  //             }),
                                  //         Text("Immediate"),
                                  //       ],
                                  //     ),
                                  //     const SizedBox(width: 20),
                                  //     Row(
                                  //       children: [
                                  //         Radio(
                                  //             value: "Installment",
                                  //             groupValue: paymentMethod,
                                  //             onChanged: (value) {
                                  //               setState(() {
                                  //                 paymentMethod = value.toString();
                                  //               });
                                  //             }),
                                  //         Text("Installment"),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                  const SizedBox(height: 40),
                                  GestureDetector(
                                    onTap: () {
                                      if (currency == "sd") {
                                        currencyNo = 1;
                                      } else {
                                        currencyNo = 2;
                                      }
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  RegistrationDetails(
                                                    currencyNo: currencyNo,
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 60),
                                      child: Container(
                                        height: 40.0,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                        child: Center(
                                          child: Text(
                                            'Show Fees Information',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                  disconnected:
                      Center(key: UniqueKey(), child: ConnectionStatuesBars()),
                ),
    );
  }
}

/*

import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view_models/registration_view_model.dart';
import 'package:edu_pro/widget/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);
  static const routeName = 'Registration';

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool _isLoading = false;
  var api = Api();
  var futureAlbum;
  Future? _data;

  @override
  initState() {
    super.initState();
    _isLoading = true;
    _data = Provider.of<RegistrationViewModel>(context, listen: false)
        .fetchRegistration()
        .then((_) => setState(() {
              _isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var registrationList =
        Provider.of<RegistrationViewModel>(context, listen: false)
            .RegistrationList;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Registration',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(Home.routeName);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Container(
          //color: Colors.grey,
          height: size.height,
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Installments Policy',
                      style: TextStyle(color: Colors.black54, fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      color: Theme.of(context).colorScheme.primary,
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '              From',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '             To',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Percentage',
                              style: TextStyle(
                                color: Colors.white,
                                //fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future: _data,
                      builder: (_, snapshot) {
                        // var registrationList = snapshot.data;
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
                          return registrationList == null
                              ? Text("Server Error")
                              : Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  height: size.height *
                                      registrationList.length /
                                      5.2,
                                  child: ListView.builder(
                                    itemCount: registrationList.length,
                                    itemBuilder: (ctx, index) {
                                      var data = registrationList[index];
                                      String dateToDB = "";
                                      dateToDB =
                                          "${registrationList[index].dateTo}";
                                      var dateToDay =
                                          DateTime.parse(dateToDB).day;
                                      var dateToMonth =
                                          DateTime.parse(dateToDB).month;
                                      var dateToYear =
                                          DateTime.parse(dateToDB).year;

                                      String dateFromDB = "";
                                      dateFromDB =
                                          "${registrationList[index].dateFrom}";
                                      var dateFromDay =
                                          DateTime.parse(dateFromDB).day;
                                      var dateFromMonth =
                                          DateTime.parse(dateFromDB).month;
                                      var dateFromYear =
                                          DateTime.parse(dateFromDB).year;
                                      return Card(
                                        margin: EdgeInsets.only(top: 10),
                                        elevation: 10,
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 15),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 4),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 50,
                                                    child: Text(
                                                      '${registrationList[index].installmentId}',
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .background),
                                                    ),
                                                  ),
                                                  Text(
                                                    '$dateFromYear-$dateFromMonth-$dateFromDay',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .background),
                                                  ),
                                                  Text(
                                                    '$dateToYear-$dateToMonth-$dateToDay',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .background),
                                                  ),
                                                  Text(
                                                    '${registrationList[index].percentage.toString()}%  ',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .background),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Immediate',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .background),
                                                ),
                                                const SizedBox(width: 5),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                        }
                      },
                    ),
                    /*
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Radio(
                                value: "sd",
                                groupValue: currency,
                                onChanged: (value) {
                                  setState(() {
                                    currency = value.toString();
                                  });
                                }),
                            Text("SD"),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            Radio(
                                value: "usd",
                                groupValue: currency,
                                onChanged: (value) {
                                  setState(() {
                                    currency = value.toString();
                                  });
                                }),
                            Text("USD"),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Radio(
                                value: "Immediate",
                                groupValue: paymentMethod,
                                onChanged: (value) {
                                  setState(() {
                                    paymentMethod = value.toString();
                                  });
                                }),
                            Text("Immediate"),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            Radio(
                                value: "Installment",
                                groupValue: paymentMethod,
                                onChanged: (value) {
                                  setState(() {
                                    paymentMethod = value.toString();
                                  });
                                }),
                            Text("Installment"),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                   */
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context)
                        //     .pushNamed(RegistrationDetails.routeName);
                      },
                      child: Container(
                        height: 40.0,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).colorScheme.primary),
                        child: Center(
                          child: Text(
                            'Confirm', //Next
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

*/
