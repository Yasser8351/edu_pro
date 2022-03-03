/* */
import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/view_models/universitiey_model_view.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:edu_pro/widget/error_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_home.dart';

class Universities extends StatefulWidget {
  const Universities({Key? key}) : super(key: key);
  static const routeName = "Universities";

  @override
  State<Universities> createState() => _UniversitiesState();
}

class _UniversitiesState extends State<Universities> {
  var _isLoading = false;
  Future? _data;
  @override
  void initState() {
    super.initState();
    _data = Provider.of<UniversitieyModelView>(context, listen: false)
        .fetchAcademic()
        .then((_) => setState(() {
              _isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var list =
        Provider.of<UniversitieyModelView>(context, listen: false).AcademicList;
    print("list $list");
    return Scaffold(
      body: ConnectionNotifierToggler(
        onConnectionStatusChanged: (connected) {
          /// that means it is still in the initialization phase.
          if (connected == null) return;
        },
        connected: list == null
            ? ErrorConnection(message: "Server error please try again later")
            : Container(
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : list.length == 0
                        ? ErrorConnection(message: "No Data Found")
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Text(
                                    'Select The University',
                                    style: TextStyle(
                                        color: Colors.black45, fontSize: 18),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                height: size.height / 1.3,
                                child: FutureBuilder(
                                  future: _data,
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
                                      } else if (snapshot.hasData) {
                                        return Text("No data found");
                                      }

                                      return GridView.builder(
                                        padding: EdgeInsets.all(10.0),
                                        itemCount: list.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 2 / 2,
                                                mainAxisSpacing: 10,
                                                crossAxisSpacing: 10),
                                        itemBuilder: (ctx, index) {
                                          // return ListView.builder(
                                          //   itemCount: list.length,
                                          //   itemBuilder: (ctx, index) {
                                          return Column(
                                            children: [
                                              Card(
                                                elevation: 10,
                                                child: Container(
                                                  height: size.height / 7,
                                                  width: size.width / 3,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(10.0),
                                                      bottomRight:
                                                          Radius.circular(10.0),
                                                      topLeft:
                                                          Radius.circular(10.0),
                                                      topRight:
                                                          Radius.circular(10.0),
                                                    ),
                                                  ),
                                                  child: Ink(
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (ctx) =>
                                                                    LoginHome(
                                                                      UniversitiesName: list[index].universitieid ==
                                                                              1
                                                                          ? 'umst'
                                                                          : list[index].universitieid == 7
                                                                              ? 'national'
                                                                              : list[index].universitieid == 3
                                                                                  ? 'uofk'
                                                                                  : list[index].universitieid == 8
                                                                                      ? 'neelain'
                                                                                      : 'umst',
                                                                      UniversitiesId:
                                                                          1,
                                                                    )));
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 5),
                                                        child: Image.asset(
                                                          list[index].universitieid ==
                                                                  1
                                                              ? 'assets/umst.png'
                                                              : list[index]
                                                                          .universitieid ==
                                                                      7
                                                                  ? 'assets/national.png'
                                                                  : list[index]
                                                                              .universitieid ==
                                                                          3
                                                                      ? 'assets/uofk.png'
                                                                      : list[index].universitieid ==
                                                                              8
                                                                          ? 'assets/neelain.png'
                                                                          : 'assets/umst.png',
                                                          height: 100,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                          //umst = 1
                                          //national  = 2
                                          //neelain = 3
                                          //bannaga = 4
                                          //safwa = 5
                                          //ibnsina = 6
                                          //uofk = 7
                                          // return Text(
                                          //   "${list[index].imageUrl}",
                                          //   overflow: TextOverflow.ellipsis,
                                          //   style: TextStyle(
                                          //       color: Colors.black54,
                                          //       fontSize: 14,
                                          //       fontWeight: FontWeight.normal),
                                          //   textAlign: TextAlign.center,
                                          // );
                                        },
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

      /*
      body: Container(
        height: size.height,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //umst = 1
                //national  = 2
                //neelain = 3
                //bannaga = 4
                //safwa = 5
                //ibnsina = 6
                //uofk = 7
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      'Select The University',
                      style: TextStyle(color: Colors.black45, fontSize: 18),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 10,
                      child: Container(
                        height: size.height / 7,
                        width: size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Ink(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => LoginHome(
                                        UniversitiesName: 'umst',
                                        UniversitiesId: 1,
                                      )));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Image.asset(
                                'assets/umst.png',
                                height: 100,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: Container(
                        height: size.height / 7,
                        width: size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Ink(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => LoginHome(
                                      UniversitiesName: 'national',
                                      UniversitiesId: 2)));
                            },
                            child: Image.asset(
                              'assets/national.png',
                              height: 100,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 10,
                      child: Container(
                        height: size.height / 7,
                        width: size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Ink(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => LoginHome(
                                        UniversitiesName: 'neelain',
                                        UniversitiesId: 3,
                                      )));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Image.asset(
                                'assets/neelain.png',
                                height: 100,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: Container(
                        height: size.height / 7,
                        width: size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Ink(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => LoginHome(
                                      UniversitiesName: 'bannaga',
                                      UniversitiesId: 4)));
                            },
                            child: Image.asset(
                              'assets/bannaga.png',
                              height: 100,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 10,
                      child: Container(
                        height: size.height / 7,
                        width: size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Ink(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => LoginHome(
                                      UniversitiesName: 'safwa',
                                      UniversitiesId: 5)));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Image.asset(
                                'assets/safwa.png',
                                height: 100,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: Container(
                        height: size.height / 7,
                        width: size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Ink(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => LoginHome(
                                      UniversitiesName: 'ibnsina',
                                      UniversitiesId: 6)));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Image.asset(
                                'assets/ibnsina.png',
                                height: 100,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 10,
                      child: Container(
                        height: size.height / 7,
                        width: size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Ink(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => LoginHome(
                                      UniversitiesName: 'uofk',
                                      UniversitiesId: 7)));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Image.asset(
                                'assets/uofk.png',
                                height: 100,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: size.height / 7,
                      width: size.width / 3,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
     */
    );
  }
}
