import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/provider/card_provider.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/widget/app_drawer.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:edu_pro/widget/error_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class CardInformation extends StatefulWidget {
  const CardInformation({Key? key}) : super(key: key);
  static const routeName = 'cardInformation';

  @override
  State<CardInformation> createState() => _CardInformationState();
}

class _CardInformationState extends State<CardInformation> {
  bool isLoading = false;
  var api = Api();

  @override
  initState() {
    super.initState();
    isLoading = true;
    Provider.of<CardProvider>(context, listen: false)
        .getCardInfo()
        .then((_) => setState(() {
              isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Card Information',
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
          /// that means it is still in the initialization phase.
          if (connected == null) return;
          print(connected);
        },
        connected: api.isServerError
            ? ErrorConnection(message: "Server error please try again later")
            : isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    margin: EdgeInsets.only(top: 10),
                    // height: 450,
                    width: double.infinity,
                    child: Consumer<CardProvider>(
                      builder: (context, value, child) {
                        return value.cardList.length == 0 && !value.error
                            ? Center(child: CircularProgressIndicator())
                            : value.error
                                ? ErrorConnection(
                                    message:
                                        "Server error please try again later")
                                : value.cardList['cardInfos'].length == 0
                                    ? ErrorConnection(message: "No Data Found")
                                    : ListView.builder(
                                        itemCount:
                                            value.cardList['cardInfos'].length,
                                        itemBuilder: (context, index) {
                                          return NewCard(
                                              map: value.cardList["cardInfos"]
                                                  [index]);
                                        },
                                      );
                      },
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
    print(map["notes"]);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            shadowColor: Colors.grey,
            elevation: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(
                    'Print DateTime',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Text(
                    map["printDateTime"] == null
                        ? "- - - -"
                        : "${map["printDateTime"].toString()}",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ListTile(
                  title: Text(
                    'print Reason Text',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Text(
                    map["printReasonText"] == null
                        ? "- - - -"
                        : "${map["printReasonText"].toString()}",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Academic Year No',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Text(
                    map["academicYear No"] == null
                        ? "- - - -"
                        : "${map["academicYearNo"].toString()}",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Active Card',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Text(
                    map["activeCard"] == null
                        ? "- - - -"
                        : "${map["activeCard"].toString()}",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Notes',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Text(
                    map["notes"] == '' || map["notes"] == null
                        ? "- - - -"
                        : "${map["notes"].toString()}",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
