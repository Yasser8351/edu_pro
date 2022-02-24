import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/provider/announcements_provider.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/widget/app_drawer.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Announcements extends StatefulWidget {
  const Announcements({Key? key}) : super(key: key);
  static const routeName = "announcements";

  @override
  State<Announcements> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  bool isLoading = false;
  var api = Api();

  @override
  initState() {
    super.initState();
    isLoading = true;

    Provider.of<AnnouncementsProvider>(context, listen: false)
        .getAnnouncements()
        .then((_) => setState(() {
              isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Announcements',
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
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
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
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.background),
                      ),
                    ),
                  ],
                ),
              )
            : isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    child: Card(
                      margin: EdgeInsets.all(1),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 2, right: 2),
                        child: Consumer<AnnouncementsProvider>(
                          builder: (context, value, child) {
                            return value.anouncementsList.length == 0 &&
                                    !value.error
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
                                    : value.anouncementsList['announcements']
                                                .length ==
                                            0
                                        ? Center(
                                            child: Text(
                                            'No Announcements Found',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black54),
                                          ))
                                        : Column(
                                            children: [
                                              Card(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                margin: EdgeInsets.all(10),
                                                child: ListTile(
                                                  trailing: Text(
                                                      "Date    ", //announcementDate
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20)),
                                                  title: Text("Title",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20)),
                                                ),
                                              ),
                                              Expanded(
                                                child: ListView.builder(
                                                  itemCount: value
                                                      .anouncementsList[
                                                          'announcements']
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return NewCard(
                                                        map: value.anouncementsList[
                                                                "announcements"]
                                                            [index]);
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
    String dateToDB = "";
    dateToDB = "${map["announcementDate"]}";
    var dateToDay = DateTime.parse(dateToDB).day;
    var dateToMonth = DateTime.parse(dateToDB).month;
    var dateToYear = DateTime.parse(dateToDB).year;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        trailing: Text('$dateToYear-$dateToMonth-$dateToDay',
            style: TextStyle(
              color: Colors.black,
            )),
        title: Text("${map["announcementTitle"].toString()}",
            style: TextStyle(
              color: Colors.black,
            )),
      ),
    );
  }
}
