import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view_models/restrictions_view_model.dart';
import 'package:edu_pro/view_models/results/semester_view_model.dart';
import 'package:edu_pro/widget/app_drawer.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:edu_pro/widget/error_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Restrictions extends StatefulWidget {
  const Restrictions({Key? key}) : super(key: key);
  static const routeName = 'restrictions';

  @override
  State<Restrictions> createState() => _RestrictionsState();
}

class _RestrictionsState extends State<Restrictions> {
  bool isSelectedSemester = false;
  int _semesterId = 1227;
  Future? _data, _dataResult;

  String? _valueSemester;
  String? _val;

  bool _isLoading = false;
  var api = Api();

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    setState(() {
      _data = Provider.of<SemesterViewModel>(context, listen: false)
          .fetchSemester()
          .then((_) => setState(() {
                _isLoading = false;
              }));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var semesterList =
        Provider.of<SemesterViewModel>(context, listen: false).SemesterList;

    var restrictionsList =
        Provider.of<RestrictionsViewModel>(context, listen: false)
            .RestrictionsList;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Restrictions',
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
      body: ConnectionNotifierToggler(
        onConnectionStatusChanged: (connected) {
          if (connected == null) return;
          print(connected);
        },
        connected: semesterList == null
            ? ErrorConnection(
                message: 'Server error please try again later',
              )
            : Container(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : semesterList.length == 0
                          ? ErrorConnection(
                              message: 'No Data Founds',
                            )
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Container(
                                    height: 100,
                                    child: FutureBuilder(
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
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                          color: isSelectedSemester
                                                              ? Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary
                                                              : Colors.black45,
                                                          width: 1),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 12),
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton<
                                                            String>(
                                                          focusColor:
                                                              Colors.green,
                                                          hint: const Text(
                                                              "Select Semester"),
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary),
                                                          value: _valueSemester,
                                                          isExpanded: true,
                                                          iconSize: 28,
                                                          icon: Icon(
                                                              Icons
                                                                  .arrow_drop_down,
                                                              color: isSelectedSemester
                                                                  ? Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .primary
                                                                  : Colors
                                                                      .black45),
                                                          items: semesterList
                                                              .map(
                                                                (item) =>
                                                                    DropdownMenuItem<
                                                                        String>(
                                                                  child: Text(item
                                                                      .semesterName
                                                                      .toString()),
                                                                  value: item
                                                                      .semesterId
                                                                      .toString(),
                                                                ),
                                                              )
                                                              .toList(),
                                                          onChanged: (value) {
                                                            setState(
                                                              () {
                                                                _isLoading =
                                                                    false;
                                                                isSelectedSemester =
                                                                    true;
                                                                this._valueSemester =
                                                                    value;
                                                                this._val =
                                                                    value;
                                                                setState(() {
                                                                  _dataResult = Provider.of<
                                                                              RestrictionsViewModel>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .fetchRestrictions(
                                                                          1227) //
                                                                      .then(
                                                                          (value) {
                                                                    setState(
                                                                      () {
                                                                        _isLoading =
                                                                            false;
                                                                      },
                                                                    );
                                                                  });
                                                                });

                                                                print(
                                                                    "_semesterId  : $_semesterId");
                                                                (int.parse(
                                                                    _valueSemester
                                                                        .toString()));
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
                                restrictionsList!.length == 0
                                    ? Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 50),
                                          child: Text(
                                            isSelectedSemester
                                                ? "No Data Found"
                                                : "",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 1),
                                        child: Card(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          margin: EdgeInsets.all(10),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Type",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                                Container(
                                                  child: Text(
                                                    "Status",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                Text(
                                                  "Note",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                Container(
                                  height: 350,
                                  color: Colors.grey[50],
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: FutureBuilder(
                                      future: _dataResult,
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
                                              itemCount: restrictionsList
                                                  .length, //restrictionsList.length
                                              itemBuilder: (context, index) {
                                                print(restrictionsList.length);
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 68,
                                                      child: Text(
                                                        "${restrictionsList[index].restrictionType}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: size.height / 15,
                                                      child: Text(
                                                        "${restrictionsList[index].activeStatus}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 65,
                                                      child: Text(
                                                        "${restrictionsList[index].note}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black54),
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
                                )
                              ],
                            ),
                ),
              ),
        disconnected: Center(key: UniqueKey(), child: ConnectionStatuesBars()),
      ),
    );
  }
}
