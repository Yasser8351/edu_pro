//ShowEServices
import 'package:edu_pro/view/e_services/e_services.dart';
import 'package:edu_pro/view/e_services/show_e_services_more_details.dart';
import 'package:edu_pro/view_models/academic_view_model.dart';
import 'package:edu_pro/view_models/e_services_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowEServices extends StatefulWidget {
  const ShowEServices({Key? key}) : super(key: key);
  static const routeName = "ShowEServices";

  @override
  _EServicesState createState() => _EServicesState();
}

class _EServicesState extends State<ShowEServices> {
  var _isLoading = false;
  Future? _dataAcademic, _dataRequsets;
  bool isSelectedYear = false;

  late int yerId = 0;

  String? _valueAcademicYear;
  @override
  void initState() {
    super.initState();
    _isLoading = true;

    _dataAcademic = Provider.of<AcademicViewModel>(context, listen: false)
        .fetchAcademic()
        .then((_) => setState(() {
              _isLoading = false;
            }));
  }

  @override
  void didChangeDependencies() {
    // setState(() {
    //   _isLoading = true;
    // });
    // _data = Provider.of<EServicesViewModel>(context, listen: false)
    //     .fetchEServices()
    //     .then((_) => setState(() {
    //           _isLoading = false;
    //         }));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var academicList =
        Provider.of<AcademicViewModel>(context, listen: false).AcademicList;
    var list =
        Provider.of<EServicesViewModel>(context, listen: false).EServicesList;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Show E-Services',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(EServices.routeName);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: 100,
                      child: FutureBuilder(
                        future: _dataAcademic,
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
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: isSelectedYear
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : Colors.black45,
                                            width: 1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: DropdownButtonHideUnderline(
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
                                            icon: Icon(Icons.arrow_drop_down,
                                                color: isSelectedYear
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                    : Colors.black45),
                                            items: academicList!
                                                .map(
                                                  (item) =>
                                                      DropdownMenuItem<String>(
                                                    child: Text(item.yearName
                                                        .toString()),
                                                    value:
                                                        item.yearId.toString(),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged: (value) {
                                              setState(
                                                () {
                                                  _isLoading = false;
                                                  isSelectedYear = true;
                                                  this._valueAcademicYear =
                                                      value;
                                                  // this._val = value;
                                                  print(
                                                      "_valueAcademicYear : $_valueAcademicYear");

                                                  setState(() {
                                                    _dataRequsets = Provider.of<
                                                                EServicesViewModel>(
                                                            context,
                                                            listen: false)
                                                        .fetchEServices(479)
                                                        .then((value) {
                                                      setState(() {
                                                        _isLoading = false;
                                                      });
                                                      // int.parse(
                                                      //     _valueAcademicYear
                                                      //         .toString()),
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
                  list!.length == 0
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Text(
                              isSelectedYear ? "No Data Found" : "",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black54),
                            ),
                          ),
                        )
                      : FutureBuilder(
                          future: _dataRequsets,
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
                                  Card(
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
                                            'Date',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            'Request Status',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            ' ',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          // Text(
                                          //   'Canceled',
                                          //   style: TextStyle(color: Colors.white),
                                          // ),
                                          // Text(
                                          //   'Request Status',
                                          //   style: TextStyle(color: Colors.white),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: size.height / 1.5,
                                    child: ListView.builder(
                                      itemCount: list.length,
                                      itemBuilder: (ctx, index) {
                                        var listData = list[index];
                                        String dateToDB = "";
                                        dateToDB = "${list[index].date}";
                                        var dateToDay =
                                            DateTime.parse(dateToDB).day;
                                        var dateToMonth =
                                            DateTime.parse(dateToDB).month;
                                        var dateToYear =
                                            DateTime.parse(dateToDB).year;

                                        print("list length: ${list.length}");
                                        return Container(
                                          height: size.height / 10,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: 80,
                                                child: Text(
                                                  "$dateToYear-$dateToMonth-$dateToDay",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Container(
                                                width: 80,
                                                child: Text(
                                                  "${list[index].requestStatusName}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              ShowEServicesMoreDetails(
                                                                price: listData
                                                                    .price,
                                                                canceled: listData
                                                                    .isCanceled,
                                                                paid: listData
                                                                    .isPaid,
                                                                paidAmount: listData
                                                                    .paidAmmount,
                                                              )));
                                                },
                                                child: Container(
                                                  width: 50,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: Colors.green[700],
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "View",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
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
                ],
              ),
            ),
    );
  }
}
