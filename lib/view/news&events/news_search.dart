import 'dart:convert';

import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:edu_pro/view_models/news_view_model.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'events_more.dart';

class NewsSearch extends StatefulWidget {
  const NewsSearch(
      {Key? key, this.dateFrom = '', this.dateTo = '', this.isNews = false})
      : super(key: key);
  static const routeName = 'News_Search';

  final String dateFrom;
  final String dateTo;
  final bool isNews;

  @override
  State<NewsSearch> createState() => _CurrentNewsState();
}

class _CurrentNewsState extends State<NewsSearch> {
  var _isLoading = false;
  Future? _data;
  var api = AllApi();
  @override
  void initState() {
    super.initState();

    _isLoading = true;

    _data = Provider.of<NewsViewModel>(context, listen: false)
        .fetchSearchNews(
          widget.dateFrom,
          widget.dateTo,
        )
        .then((_) => setState(() {
              _isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var list =
        Provider.of<NewsViewModel>(context, listen: false).NewsSearchList;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          widget.isNews ? 'Search Activities' : 'Search News & Events',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ConnectionNotifierToggler(
        onConnectionStatusChanged: (connected) {
          if (connected == null) return;
          print(connected);
        },
        connected: list == null
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
                        'No News or Events Found',
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.background),
                      ),
                    ),
                  ],
                ),
              )
            : _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : list.length == 0
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
                                'No News or Events Found',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        color: Colors.white,
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
                                      padding: const EdgeInsets.only(
                                          bottom: 20, left: 10, right: 10),
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
                                        child: Card(
                                          elevation: 10,
                                          //  margin: EdgeInsets.symmetric(horizontal: 10),
                                          child: Column(
                                            children: [
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
                                              //const SizedBox(height: 10),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30, right: 30),
                                                child: Divider(
                                                  height: 5,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: SizedBox(
                                                      height: size.height / 3,
                                                      width: size.width - 200,
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
