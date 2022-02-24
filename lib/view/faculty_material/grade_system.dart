import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view/faculty_material/faculty_material.dart';
import 'package:edu_pro/view_models/grade_system_mark_view_model.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GradeSystem extends StatefulWidget {
  const GradeSystem({Key? key}) : super(key: key);
  static const routeName = "gradeSystem";

  @override
  State<GradeSystem> createState() => _GradeSystemState();
}

class _GradeSystemState extends State<GradeSystem> {
  var _isLoading = false;
  Future? _dataMark;
  var api = Api();

  @override
  initState() {
    super.initState();
    Provider.of<GradeSystemMarkViewModel>(context, listen: false)
        .fetchGradeSystem()
        .then((_) => setState(() {
              _isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var listMark = Provider.of<GradeSystemMarkViewModel>(context, listen: false)
        .GradeSystemList;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Grade System',
          style: TextStyle(color: Colors.white),
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
        connected: listMark == null
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
                            color: Theme.of(context).colorScheme.background),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                child: listMark.length == 0
                    ? Center(
                        child: Text(
                        _isLoading ? '' : 'No Data Found',
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ))
                    : _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Card(
                                color: Theme.of(context).colorScheme.primary,
                                margin: EdgeInsets.all(10),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Grade Name',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        'Maximum',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        'Minimum',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                child: FutureBuilder(
                                  future: _dataMark,
                                  builder: (_, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    } else {
                                      if (snapshot.hasError) {
                                        return Text("some error");
                                      } else if (snapshot.hasData == null) {
                                        return Text("No data found");
                                      }
                                      return Container(
                                        height:
                                            size.height / 3.5 - listMark.length,
                                        // height:
                                        //     size.height / listMark.length - 30,
                                        child: ListView.builder(
                                          itemCount: listMark.length,
                                          itemBuilder: (ctx, index) {
                                            var list = listMark[index];

                                            return Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 10,
                                                    bottom: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                        width: 70,
                                                        child: Text(
                                                            '${list.classificationName}')),
                                                    Text('${list.maximum}  '),
                                                    Text('${list.minimum}'),
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
                            ],
                          ),
              ),
        disconnected: Center(key: UniqueKey(), child: ConnectionStatuesBars()),
      ),
    );
  }
}
