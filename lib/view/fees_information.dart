/* */
import 'dart:math';

import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view_models/academic_view_model.dart';
import 'package:edu_pro/view_models/fees_view_model.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:edu_pro/widget/error_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class FeesInformation extends StatefulWidget {
  const FeesInformation({Key? key}) : super(key: key);
  static const routeName = 'feesInformation';

  @override
  State<FeesInformation> createState() => _FeesInformationState();
}

class _FeesInformationState extends State<FeesInformation> {
  bool isSelectedSemester = false;
  Future? _data, _dataFees;
  late int yerId = 0;

  String? _valueAcademicYear;
  String? _val;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;

    _data = Provider.of<AcademicViewModel>(context, listen: false)
        .fetchAcademic()
        .then((_) => setState(() {
              _isLoading = false;
            }));
  }

  Future refreshData() async {
    _data;
  }

  var _expand1 = true;
  var _expand2 = true;
  var _expand3 = true;
  var _expand4 = true;
  var _expand5 = true;
  var _expand6 = true;
  var api = Api();

  bool isSelected = false;

  String? _value;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var academicList =
        Provider.of<AcademicViewModel>(context, listen: false).AcademicList;
    var feesList = Provider.of<FeesViewModel>(context, listen: false).FeesList;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Fees Information ',
          style: TextStyle(
            color: Colors.white,
          ),
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
        connected: academicList == null
            ? ErrorConnection(
                message: 'Server error please try again later',
              )
            : academicList.length == 0
                ? ErrorConnection(message: 'No Data Found')
                : SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              height: 100,
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
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
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
                                                    color: isSelectedSemester
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
                                                  child: DropdownButton<String>(
                                                    focusColor: Colors.green,
                                                    hint: const Text(
                                                        "Select Academic Year"),
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary),
                                                    value: _valueAcademicYear,
                                                    isExpanded: true,
                                                    iconSize: 28,
                                                    icon: Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            isSelectedSemester
                                                                ? Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary
                                                                : Colors
                                                                    .black45),
                                                    items: academicList
                                                        .map(
                                                          (item) =>
                                                              DropdownMenuItem<
                                                                  String>(
                                                            child: Text(item
                                                                .yearName
                                                                .toString()),
                                                            value: item.yearId
                                                                .toString(),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChanged: (value) {
                                                      setState(
                                                        () {
                                                          _isLoading = false;
                                                          isSelectedSemester =
                                                              true;
                                                          this._valueAcademicYear =
                                                              value;
                                                          this._val = value;
                                                          print(
                                                              "_valueAcademicYear : $_valueAcademicYear");

                                                          setState(
                                                            () {
                                                              print(_valueAcademicYear
                                                                  .toString());
                                                              _dataFees = Provider.of<
                                                                          FeesViewModel>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .fetchFees(int.parse(
                                                                      _valueAcademicYear
                                                                          .toString()))
                                                                  .then(
                                                                      (value) {
                                                                setState(() {
                                                                  _isLoading =
                                                                      false;
                                                                });
                                                              });
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          feesList!.length == 0
                              ? isSelectedSemester
                                  ? ErrorConnection(
                                      message: 'No Data Found',
                                    )
                                  : Text('')
                              : Container(
                                  height: size.height / 1.4, //550
                                  color: Colors.grey[50],
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: FutureBuilder(
                                      future: _dataFees,
                                      builder: (_, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else {
                                          if (snapshot.hasError) {
                                            return Text("some error");
                                          } else if (snapshot.hasData == null) {
                                            return Text("No data found");
                                          } else if (snapshot.hasData) {
                                            return Text("No data found");
                                          }
                                          return Container(
                                            height: 300,
                                            child: ListView.builder(
                                              itemCount: feesList
                                                  .length, //resultList.length
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    AnimatedContainer(
                                                      duration: Duration(
                                                          milliseconds: 300),
                                                      height: _expand1
                                                          ? min(
                                                              300 * 20.0 + 110,
                                                              140)
                                                          : 105,
                                                      child: Card(
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        child: Column(
                                                          children: [
                                                            ListTile(
                                                              title: Text(
                                                                "Final Fees",
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .primary),
                                                              ),
                                                              trailing:
                                                                  IconButton(
                                                                icon: Icon(
                                                                  _expand1
                                                                      ? Icons
                                                                          .expand_less
                                                                      : Icons
                                                                          .expand_more,
                                                                  color: _expand1
                                                                      ? Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .primary
                                                                      : Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .onSurface,
                                                                ),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    _expand1 =
                                                                        !_expand1;
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            AnimatedContainer(
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      300),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          4),
                                                              height: min(
                                                                  10 * 20.0 +
                                                                      10,
                                                                  29),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Text(
                                                                    _expand1
                                                                        ? "Total"
                                                                        : "",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .black38,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    _expand1
                                                                        ? "${feesList[index].finalFees} SDG"
                                                                        : "",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .black38,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            10), //final fees
                                                    AnimatedContainer(
                                                      duration: Duration(
                                                          milliseconds: 300),
                                                      height: _expand2
                                                          ? min(
                                                              300 * 20.0 + 110,
                                                              140)
                                                          : 105,
                                                      child: Card(
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        child: Column(
                                                          children: [
                                                            ListTile(
                                                              title: Text(
                                                                "course Fees",
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .primary),
                                                              ),
                                                              trailing:
                                                                  IconButton(
                                                                icon: Icon(
                                                                  _expand2
                                                                      ? Icons
                                                                          .expand_less
                                                                      : Icons
                                                                          .expand_more,
                                                                  color: _expand2
                                                                      ? Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .primary
                                                                      : Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .onSurface,
                                                                ),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    _expand2 =
                                                                        !_expand2;
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            AnimatedContainer(
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      300),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          4),
                                                              height: min(
                                                                  10 * 20.0 +
                                                                      10,
                                                                  29),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Text(
                                                                    _expand2
                                                                        ? "Total"
                                                                        : "",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .black38,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    _expand2
                                                                        ? "${feesList[index].courseFees} SDG"
                                                                        : "",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .black38,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            10), //course fees
                                                    AnimatedContainer(
                                                      duration: Duration(
                                                          milliseconds: 300),
                                                      height: _expand3
                                                          ? min(
                                                              300 * 20.0 + 110,
                                                              140)
                                                          : 105,
                                                      child: Card(
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        child: Column(
                                                          children: [
                                                            ListTile(
                                                              title: Text(
                                                                "Registration Fees",
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .primary),
                                                              ),
                                                              trailing:
                                                                  IconButton(
                                                                icon: Icon(
                                                                  _expand3
                                                                      ? Icons
                                                                          .expand_less
                                                                      : Icons
                                                                          .expand_more,
                                                                  color: _expand3
                                                                      ? Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .primary
                                                                      : Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .onSurface,
                                                                ),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    _expand3 =
                                                                        !_expand3;
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            AnimatedContainer(
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      300),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          4),
                                                              height: min(
                                                                  10 * 20.0 +
                                                                      10,
                                                                  29),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Text(
                                                                    _expand3
                                                                        ? "Total"
                                                                        : "",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .black38,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    _expand3
                                                                        ? "${feesList[index].registrationFees} SDG"
                                                                        : "",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .black38,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            10), //registrationFees
                                                    AnimatedContainer(
                                                      duration: Duration(
                                                          milliseconds: 300),
                                                      height: _expand4
                                                          ? min(
                                                              300 * 20.0 + 110,
                                                              140)
                                                          : 105,
                                                      child: Card(
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        child: Column(
                                                          children: [
                                                            ListTile(
                                                              title: Text(
                                                                "Admission Fees",
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .primary),
                                                              ),
                                                              trailing:
                                                                  IconButton(
                                                                icon: Icon(
                                                                  _expand4
                                                                      ? Icons
                                                                          .expand_less
                                                                      : Icons
                                                                          .expand_more,
                                                                  color: _expand4
                                                                      ? Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .primary
                                                                      : Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .onSurface,
                                                                ),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    _expand4 =
                                                                        !_expand4;
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            AnimatedContainer(
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      300),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          4),
                                                              height: min(
                                                                  10 * 20.0 +
                                                                      10,
                                                                  29),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Text(
                                                                    _expand4
                                                                        ? "Total"
                                                                        : "",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .black38,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    _expand4
                                                                        ? "${feesList[index].admissionFees} SDG"
                                                                        : "",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .black38,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            10), //admissionFees
                                                    AnimatedContainer(
                                                      duration: Duration(
                                                          milliseconds: 300),
                                                      height: _expand5
                                                          ? min(
                                                              300 * 20.0 + 110,
                                                              140)
                                                          : 105,
                                                      child: Card(
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        child: Column(
                                                          children: [
                                                            ListTile(
                                                              title: Text(
                                                                "payment Method",
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .primary),
                                                              ),
                                                              trailing:
                                                                  IconButton(
                                                                icon: Icon(
                                                                  _expand5
                                                                      ? Icons
                                                                          .expand_less
                                                                      : Icons
                                                                          .expand_more,
                                                                  color: _expand5
                                                                      ? Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .primary
                                                                      : Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .onSurface,
                                                                ),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    _expand5 =
                                                                        !_expand5;
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            AnimatedContainer(
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      300),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          4),
                                                              height: min(
                                                                  10 * 20.0 +
                                                                      10,
                                                                  29),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Text(
                                                                    _expand5
                                                                        ? "${feesList[index].paymentMethodName}"
                                                                        : "",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .black38,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    _expand5
                                                                        ? ""
                                                                        : "",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .black38,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            10), //admissionFees
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
                    ),
                  ),
        disconnected: Center(key: UniqueKey(), child: ConnectionStatuesBars()),
      ),
    );
  }
}
