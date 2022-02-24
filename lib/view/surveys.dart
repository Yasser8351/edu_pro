import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/provider/survey_provider.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/widget/app_drawer.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home.dart';

class Surveys extends StatefulWidget {
  const Surveys({Key? key}) : super(key: key);
  static const routeName = "Surveys";

  @override
  State<Surveys> createState() => _SurveysState();
}

class _SurveysState extends State<Surveys> {
  bool isLoading = false;
  var api = Api();

  @override
  initState() {
    super.initState();
    isLoading = true;

    Provider.of<SurveyProvider>(context, listen: false)
        .getSurvey()
        .then((_) => setState(() {
              isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Surveys',
          style: TextStyle(color: Colors.white),
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
          /// that means it is still in the initialization phase.
          if (connected == null) return;
          print(connected);
        },
        connected: api.isServerError
            ? Column(
                children: [
                  Center(
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
                            'Server error please try again later',
                            style: TextStyle(
                                fontSize: 20,
                                color:
                                    Theme.of(context).colorScheme.background),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    child: Card(
                      margin: EdgeInsets.all(1),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 2, right: 2),
                        child: Consumer<SurveyProvider>(
                          builder: (context, value, child) {
                            return value.surveyList.length == 0 && !value.error
                                ? Center(child: CircularProgressIndicator())
                                : value.error
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                              padding: const EdgeInsets.only(
                                                  top: 15),
                                              child: Text(
                                                'Server error please try again later',
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
                                    : Column(
                                        children: [
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount: value
                                                  .surveyList['surveys'].length,
                                              itemBuilder: (context, index) {
                                                return NewCard(
                                                    map: value.surveyList[
                                                        "surveys"][index]);
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                          },
                        ),
                      ),
                    ),
                  ),
        disconnected: Center(key: UniqueKey(), child: ConnectionStatuesBars()),
      ),
    );
  }
}

class NewCard extends StatelessWidget {
  const NewCard({Key? key, required this.map}) : super(key: key);
  final Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),

      child: Card(
        margin: EdgeInsets.only(bottom: 20),
        elevation: 10,
        child: Column(
          children: [
            ListTile(
              leading: Text("Title",
                  style: TextStyle(
                    color: Colors.black,
                  )),
              trailing: Text("${map["surveyTitle"]}",
                  style: TextStyle(
                    color: Colors.black,
                  )),
            ),
            ListTile(
              leading: Text("Start Date",
                  style: TextStyle(
                    color: Colors.black,
                  )),
              trailing: Text("${map["startDate"]}",
                  style: TextStyle(
                    color: Colors.black,
                  )),
            ),
            ListTile(
              leading: Text("End Date",
                  style: TextStyle(
                    color: Colors.black,
                  )),
              trailing: Text("${map["endDate"]}",
                  style: TextStyle(
                    color: Colors.black,
                  )),
            ),
            ListTile(
              leading: Text("Show Survey",
                  style: TextStyle(
                    color: Colors.black,
                  )),
              trailing: ElevatedButton(
                onPressed: () {
                  launch('${map["surveyLink"].toString()}');
                },
                child: Text(
                  'Select',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              // trailing: GestureDetector(
              //   onTap: () {
              //     launch('${map["surveyLink"].toString()}');
              //   },
              //   child: Card(
              //     color: Theme.of(context).colorScheme.primary,
              //     child: Padding(
              //       padding: const EdgeInsets.all(6.0),
              //       child: Text(
              //         'Select',
              //         style: TextStyle(color: Colors.white, fontSize: 12),
              //       ),
              //     ),
              //   ),
              // ),
            ),
          ],
        ),
      ),

      // child: Column(
      //   children: [
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.only(bottom: 20),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Container(
      //                 width: 100,
      //                 child: Text("${map["surveyTitle"]}",
      //                     style: TextStyle(
      //                       color: Theme.of(context).colorScheme.primary,
      //                     )),
      //               ),
      //               SizedBox(width: 4),
      //               Text("${map["startDate"].toString()}",
      //                   style: TextStyle(
      //                     color: Theme.of(context).colorScheme.primary,
      //                   )),
      //               SizedBox(width: 4),
      //               Text("${map["endDate"].toString()}",
      //                   style: TextStyle(
      //                     color: Theme.of(context).colorScheme.primary,
      //                   )),
      //               SizedBox(width: 0),
      //               ElevatedButton(
      //                 onPressed: () {
      //                   //surveyLink
      //                   launch('${map["surveyLink"].toString()}');
      //                 },
      //                 child: Text(
      //                   'Select',
      //                   style: TextStyle(color: Colors.white, fontSize: 12),
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}
