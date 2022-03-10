//ComingActivities
import 'dart:convert';

import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view/my_activties/activity_more.dart';
import 'package:edu_pro/view_models/activity_view_model.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:edu_pro/widget/error_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComingActivities extends StatefulWidget {
  const ComingActivities({Key? key}) : super(key: key);
  static const routeName = 'Coming_Activities';

  @override
  State<ComingActivities> createState() => _ComingActivitiesState();
}

class _ComingActivitiesState extends State<ComingActivities> {
  var _isLoading = false;
  Future? _data;
  var api = Api();
  @override
  void initState() {
    super.initState();

    _isLoading = true;
    _data = Provider.of<ActivityViewModel>(context, listen: false)
        .fetchActivity(true)
        .then((_) => setState(() {
              _isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var activityList =
        Provider.of<ActivityViewModel>(context, listen: false).ActivityList;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          'Coming Activities',
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
            : activityList == null
                ? ErrorConnection(
                    message: 'Server error please try again later',
                  )
                : activityList.length == 0
                    ? ErrorConnection(
                        message: 'No Activities Found',
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
                                  itemCount: activityList.length,
                                  itemBuilder: (ctx, index) {
                                    String dateToDB = "";
                                    dateToDB = "${activityList[index].dateTo}";
                                    var dateToDay =
                                        DateTime.parse(dateToDB).day;
                                    var dateToMonth =
                                        DateTime.parse(dateToDB).month;
                                    var dateToYear =
                                        DateTime.parse(dateToDB).year;

                                    String dateFromDB = "";
                                    dateFromDB =
                                        "${activityList[index].dateFrom}";
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
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (ctx) => ActivityMore(
                                                  facultyName: activityList[index]
                                                      .facultyName,
                                                  activityTimeFrom:
                                                      activityList[index]
                                                          .dateFrom,
                                                  activityTimeTo:
                                                      activityList[index]
                                                          .dateTo,
                                                  batchName: activityList[index]
                                                      .batchName,
                                                  newsAndActivityDescription:
                                                      activityList[index]
                                                          .ActivitysAndEventsDescription,
                                                  newsAndActivityTypeName:
                                                      activityList[index]
                                                          .activityName,
                                                  programNameEn:
                                                      activityList[index]
                                                          .programNameEn,
                                                  specializationName:
                                                      activityList[index]
                                                          .specializationName)));
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
                                                              "${activityList[index].image}")),
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
                                                                '${activityList[index].ActivitysAndEventsDescription}',
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
