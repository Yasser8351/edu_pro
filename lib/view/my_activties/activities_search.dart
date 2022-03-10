import 'dart:convert';

import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view/my_activties/activity_more.dart';
import 'package:edu_pro/view_models/activity_view_model.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:edu_pro/widget/error_connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivitiesSearch extends StatefulWidget {
  const ActivitiesSearch(
      {Key? key, this.dateFrom = '', this.dateTo = '', this.isNews = false})
      : super(key: key);
  static const routeName = 'Activities_Search';

  final String dateFrom;
  final String dateTo;
  final bool isNews;

  @override
  State<ActivitiesSearch> createState() => _CurrentNewsState();
}

class _CurrentNewsState extends State<ActivitiesSearch> {
  var _isLoading = false;
  Future? _data;
  var api = Api();
  @override
  void initState() {
    super.initState();
    _isLoading = true;

    _data = Provider.of<ActivityViewModel>(context, listen: false)
        .fetchSearchActivity(widget.dateFrom, widget.dateTo)
        .then((_) => setState(() {
              _isLoading = false;
            }));
  }
  //(2021-10-30,2021-11-28)

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var list = Provider.of<ActivityViewModel>(context, listen: false)
        .ActivitySearchList;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          'More Details',
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
        connected: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : list == null
                ? ErrorConnection(
                    message: "Server error please try again later")
                : list.length == 0
                    ? ErrorConnection(
                        message: widget.isNews
                            ? 'No News or Events Found'
                            : 'No Activities Found',
                      )
                    : Container(
                        height: double.infinity - 200,
                        padding: EdgeInsets.only(top: 15),
                        child: FutureBuilder(
                          future: _data,
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
                              return Container(
                                height: size.height,
                                child: ListView.builder(
                                  itemCount: list.length,
                                  itemBuilder: (ctx, index) {
                                    String dateToDB = "";
                                    dateToDB = "${list[index].dateTo}";
                                    var dateToDay =
                                        DateTime.parse(dateToDB).day;
                                    var dateToMonth =
                                        DateTime.parse(dateToDB).month;
                                    var dateToYear =
                                        DateTime.parse(dateToDB).year;

                                    String dateFromDB = "";
                                    dateFromDB = "${list[index].dateFrom}";
                                    var dateFromDay =
                                        DateTime.parse(dateFromDB).day;
                                    var dateFromMonth =
                                        DateTime.parse(dateFromDB).month;
                                    var dateFromYear =
                                        DateTime.parse(dateFromDB).year;
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      ActivityMore(
                                                        facultyName: list[index]
                                                            .facultyName,
                                                        batchName: list[index]
                                                            .batchName,
                                                        programNameEn:
                                                            list[index]
                                                                .programNameEn,
                                                        newsAndActivityDescription:
                                                            list[index]
                                                                .ActivitysAndEventsDescription,
                                                        specializationName: list[
                                                                index]
                                                            .specializationName,
                                                        activityTimeFrom:
                                                            "$dateFromYear-$dateFromMonth-$dateFromDay",
                                                        activityTimeTo:
                                                            '$dateToYear-$dateToMonth-$dateToDay',
                                                        newsAndActivityTypeName:
                                                            list[index]
                                                                .activityName,
                                                      )));
                                        },
                                        child: Card(
                                          elevation: 10,
                                          //  margin: EdgeInsets.symmetric(horizontal: 10),
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 10),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: SizedBox(
                                                  width: 80,
                                                  height: 80,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white),
                                                          color: Colors.grey),
                                                      child: FadeInImage(
                                                        placeholder: AssetImage(
                                                            "assets/placeholder.png"),
                                                        image: MemoryImage(
                                                          (base64Decode(
                                                              "${list[index].image}")),
                                                        ),
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 15,
                                                    bottom: 15),
                                                child: Divider(
                                                  height: 5,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: SizedBox(
                                                      height: size.height / 6,
                                                      width: size.width - 200,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'From :  $dateFromYear-$dateFromMonth-$dateFromDay',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .secondaryVariant),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'To :  $dateToYear-$dateToMonth-$dateToDay',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .secondaryVariant),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                '${list[index].ActivitysAndEventsDescription}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .secondaryVariant),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Read more',
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .primary),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
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
