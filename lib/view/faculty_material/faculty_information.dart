import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/provider/faculty_info_provider.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view/faculty_material/faculty_material.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:edu_pro/widget/error_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FacultyInformation extends StatefulWidget {
  const FacultyInformation({Key? key}) : super(key: key);
  static const routeName = 'facultyInformation';

  @override
  State<FacultyInformation> createState() => _FacultyInformationState();
}

class _FacultyInformationState extends State<FacultyInformation> {
  bool isLoading = false;
  var api = Api();

  @override
  initState() {
    super.initState();
    isLoading = true;
    Provider.of<FacultyInfoProvider>(context, listen: false)
        .getFacultyInfo()
        .then((_) => setState(() {
              isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Faculty Information',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                FacultyMaterial.routeName, (route) => false);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: ConnectionNotifierToggler(
        onConnectionStatusChanged: (connected) {
          /// that means it is still in the initialization phase.
          if (connected == null) return;
          print(connected);
        },
        connected: isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                margin: EdgeInsets.only(top: 10),
                // height: 450,
                width: double.infinity,
                child: Consumer<FacultyInfoProvider>(
                  builder: (context, value, child) {
                    return value.cardList.length == 0 && !value.error
                        ? Center(child: CircularProgressIndicator())
                        : value.error
                            ? ErrorConnection(
                                message: "Server error please try again later")
                            : value.cardList['facultyInfos'].length == 0
                                ? ErrorConnection(message: "No Data Found")
                                : ListView.builder(
                                    itemCount:
                                        value.cardList['facultyInfos'].length,
                                    itemBuilder: (context, index) {
                                      return NewCard(
                                          map: value.cardList["facultyInfos"]
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
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${map["facultyName"]}",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "${map["deanName"]}",
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "${map["headofExamsNameEn"]}",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "${map["registrarNameEn"]}",
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "${map["major"]}",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: 100,
                    child: Text(
                      "Number of Semesters ${map["semistersCount"]}",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
