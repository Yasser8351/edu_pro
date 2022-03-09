import 'dart:convert';

import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view/news&events/news&events.dart';
import 'package:edu_pro/view_models/news_view_model.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:edu_pro/widget/error_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'events_more.dart';

class CurrentNews extends StatefulWidget {
  const CurrentNews({Key? key}) : super(key: key);
  static const routeName = 'Current_event';

  @override
  State<CurrentNews> createState() => _CurrentNewsState();
}

class _CurrentNewsState extends State<CurrentNews> {
  var _isLoading = false;
  Future? _data;
  var api = Api();
  @override
  void initState() {
    super.initState();

    _isLoading = true;

    _data = Provider.of<NewsViewModel>(context, listen: false)
        .fetchNews(false)
        .then((_) => setState(() {
              _isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var list = Provider.of<NewsViewModel>(context, listen: false).NewsList;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(News.routeName, (route) => false);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          'Current News & event',
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
                    ? ErrorConnection(message: "No News or Events Found")
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
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (ctx) => EventsMore(
                                                        facultyName: list[index]
                                                            .facultyName,
                                                        batchName: list[index]
                                                            .batchName,
                                                        programNameEn:
                                                            list[index]
                                                                .programNameEn,
                                                        newsAndEventsDescription:
                                                            list[index]
                                                                .NewsAndEventsDescription,
                                                        specializationName: list[
                                                                index]
                                                            .specializationName,
                                                        activityTimeFrom:
                                                            "$dateFromYear-$dateFromMonth-$dateFromDay",
                                                        activityTimeTo:
                                                            '$dateToYear-$dateToMonth-$dateToDay',
                                                        newsAndEventsType: list[
                                                                index]
                                                            .NewsAndEventsTypeName,
                                                        newsAndEventsTypeName:
                                                            list[index]
                                                                .NewsAndEventsTypeName,
                                                      )));
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 80,
                                              height: 80,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: Colors.white),
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
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Card(
                                                elevation: 10,
                                                child: SizedBox(
                                                  height: size.height / 3.1,
                                                  width: size.width - 100,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ListTile(
                                                        title: Text(
                                                          'From :  $dateFromYear-$dateFromMonth-$dateFromDay',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondaryVariant),
                                                        ),
                                                      ),
                                                      ListTile(
                                                        title: Text(
                                                          'To :  $dateToYear-$dateToMonth-$dateToDay',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondaryVariant),
                                                        ),
                                                      ),
                                                      ListTile(
                                                        title: Text(
                                                          '${list[index].NewsAndEventsDescription}',
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondaryVariant),
                                                        ),
                                                      ),
                                                      ListTile(
                                                        title: Text(
                                                          'Read more',
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
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
