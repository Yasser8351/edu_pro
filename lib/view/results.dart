import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view_models/results/result_view_model.dart';
import 'package:edu_pro/view_models/results/semester_view_model.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:edu_pro/widget/error_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'home.dart';

class Results extends StatefulWidget {
  const Results({Key? key}) : super(key: key);
  static const routeName = "results";

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  String? connectionType;

  bool isSelectedSemester = false;
  late int _semesterId;
  Future? _data, _dataResult;
  int _index = 0;
  var _isInit = true;

  String? _valueSemester;
  String? _val;

  bool _isLoading = false;
  var api = Api();

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
      _data = Provider.of<SemesterViewModel>(context, listen: false)
          .fetchSemester()
          .then(
            (_) => setState(
              () {
                _isLoading = false;
              },
            ),
          );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future refreshData() async {
    _data;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var semesterList =
        Provider.of<SemesterViewModel>(context, listen: false).SemesterList;

    var resultList =
        Provider.of<ResultViewModel>(context, listen: false).ResultList;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Results',
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
          if (connected == null) return;
          print(connected);
        },
        connected: Center(
            key: UniqueKey(),
            child: Stack(
              children: [
                semesterList == null || resultList == null
                    ? ErrorConnection(
                        message: "Server error please try again later")
                    : Stack(
                        children: [
                          SingleChildScrollView(
                            child: Container(
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: semesterList.length == 0
                                    ? ErrorConnection(
                                        message: "No Data Found",
                                      )
                                    : _isLoading
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Container(
                                                  height: 100,
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
                                                        if (snapshot.hasError) {
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
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Container(
                                                            height: size.height,
                                                            child: ListView
                                                                .builder(
                                                              itemCount: 1,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                _index = index;
                                                                print(_index);
                                                                return Container(
                                                                  height:
                                                                      size.height /
                                                                          13,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(4),
                                                                    border: Border.all(
                                                                        color: isSelectedSemester
                                                                            ? Theme.of(context)
                                                                                .colorScheme
                                                                                .primary
                                                                            : Colors
                                                                                .black45,
                                                                        width:
                                                                            1),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            12),
                                                                    child:
                                                                        DropdownButtonHideUnderline(
                                                                      child: DropdownButton<
                                                                          String>(
                                                                        focusColor:
                                                                            Colors.green,
                                                                        hint: const Text(
                                                                            "Select Semester"),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Theme.of(context).colorScheme.primary),
                                                                        value:
                                                                            _valueSemester,
                                                                        isExpanded:
                                                                            true,
                                                                        iconSize:
                                                                            28,
                                                                        icon: Icon(
                                                                            Icons
                                                                                .arrow_drop_down,
                                                                            color: isSelectedSemester
                                                                                ? Theme.of(context).colorScheme.primary
                                                                                : Colors.black45),
                                                                        items: semesterList
                                                                            .map(
                                                                              (item) => DropdownMenuItem<String>(
                                                                                child: Text(item.semesterName.toString()),
                                                                                value: item.semesterId.toString(),
                                                                              ),
                                                                            )
                                                                            .toList(),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                            () {
                                                                              _isLoading = false;
                                                                              isSelectedSemester = true;
                                                                              this._valueSemester = value;
                                                                              this._val = value;
                                                                              print("_valueSemester : $_valueSemester");
                                                                              setState(() {
                                                                                _index = index;
                                                                                _dataResult = Provider.of<ResultViewModel>(context, listen: false).fetchResult(int.parse(_valueSemester.toString())).then((value) {
                                                                                  setState(() {
                                                                                    _isLoading = false;
                                                                                  });
                                                                                });
                                                                              });
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
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: resultList.length == 0
                                                    ? Center(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            isSelectedSemester
                                                                ? Container(
                                                                    width: 100,
                                                                    height: 100,
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/warning.gif',
                                                                      // color: Colors.blue,
                                                                    ),
                                                                  )
                                                                : Text(''),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 15),
                                                              child: Text(
                                                                isSelectedSemester
                                                                    ? 'No Data Found'
                                                                    : '',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .background),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Card(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        margin: EdgeInsets.only(
                                                            left: 5, right: 5),
                                                        child: ListTile(
                                                          title: Text(
                                                            'Result',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                              ),
                                              Container(
                                                height: size.height - 200,
                                                color: Colors.grey[50],
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15),
                                                  child: FutureBuilder(
                                                    future: _dataResult,
                                                    builder: (_, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      } else {
                                                        if (snapshot.hasError) {
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
                                                        return resultList
                                                                    .length ==
                                                                0
                                                            ? Text('')
                                                            : Card(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left: 5,
                                                                        right:
                                                                            5),
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      size.height -
                                                                          100,
                                                                  child: ListView
                                                                      .builder(
                                                                    itemCount:
                                                                        resultList
                                                                            .length,
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return ListTile(
                                                                        title:
                                                                            Text(
                                                                          "${resultList[index].courseName}",
                                                                          style: TextStyle(
                                                                              color: Colors.black54,
                                                                              fontSize: 18),
                                                                        ),
                                                                        trailing:
                                                                            Text(
                                                                          "${resultList[index].grade}",
                                                                          style: TextStyle(
                                                                              color: Colors.black54,
                                                                              fontSize: 18),
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
                                              )
                                            ],
                                          ),
                              ),
                            ),
                          ),
                        ],
                      ),
             
              ],
            )),
        disconnected: Center(key: UniqueKey(), child: ConnectionStatuesBars()),
      ),
    );
  }
}
