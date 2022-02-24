import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/provider/faculty_info_provider.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view/faculty_material/faculty_material.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
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
                            : value.cardList['facultyInfos'].length == 0
                                ? Center(
                                    child: Text(
                                    'No Data Found',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondaryVariant),
                                  ))
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  trailing: Text(
                    "${map["facultyName"]}",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  title: Text(
                    'Faculty',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                ListTile(
                  trailing: Container(
                    width: 200,
                    child: Text(
                      "${map["deanName"]}",
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  title: Text(
                    'Dean Name',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                ListTile(
                  trailing: Text(
                    "${map["headofExamsNameEn"]}",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  title: Text(
                    'Head of Exams',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                ListTile(
                  trailing: Container(
                    width: 150,
                    child: Text(
                      "${map["registrarNameEn"]}",
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  title: Text(
                    'Registrar Name',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                ListTile(
                  trailing: Text(
                    "${map["major"]}",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  title: Text(
                    'major',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                ListTile(
                  trailing: Text(
                    "${map["semistersCount"]}",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  title: Text(
                    'No. of Semesters',
                    style: TextStyle(fontSize: 14, color: Colors.black),
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
