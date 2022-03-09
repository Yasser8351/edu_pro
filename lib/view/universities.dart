/* */
import 'package:connection_notifier/connection_notifier.dart';
import 'package:edu_pro/view_models/universitiey_model_view.dart';
import 'package:edu_pro/widget/check_internet_connection.dart';
import 'package:edu_pro/widget/error_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    _isLoading = true;

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
    return Scaffold(
      body: ConnectionNotifierToggler(
        onConnectionStatusChanged: (connected) {
          if (connected == null) return;
        },
        connected: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : list == null
                ?
                // GestureDetector(
                //     onTap: () {
                //       setState(() {
                //         _data = Provider.of<UniversitieyModelView>(context,
                //                 listen: false)
                //             .fetchAcademic()
                //             .then((_) => setState(() {
                //                   _isLoading = false;
                //                 }));
                //       });
                //     },
                //     child: Center(
                //       child: Stack(
                //         children: [
                //           Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Container(
                //                 width: 120,
                //                 height: 120,
                //                 child: SvgPicture.asset(
                //                   'assets/warning.svg',
                //                   color: Theme.of(context).colorScheme.primary,
                //                 ),
                //               ),
                //               Padding(
                //                 padding: const EdgeInsets.only(top: 20),
                //                 child: Text(
                //                   "Server error please try again later",
                //                   style: TextStyle(
                //                       fontSize: 20,
                //                       color:
                //                           Theme.of(context).colorScheme.background),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),
                //   )

                Center(
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              child: SvgPicture.asset(
                                'assets/warning.svg',
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: Text(
                                "No Internet found",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 120),
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isLoading = true;
                                      _data =
                                          Provider.of<UniversitieyModelView>(
                                                  context,
                                                  listen: false)
                                              .fetchAcademic()
                                              .then((_) => setState(() {
                                                    _isLoading = false;
                                                  }));
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'try again',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Icon(Icons.refresh, color: Colors.white),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                // Text('Something wrong')
                : SingleChildScrollView(
                    child: Container(
                      height: size.height,
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : list.length == 0
                              ? ErrorConnection(message: "No Data Found")
                              : ListView(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 15),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Center(
                                        child: Text(
                                          'Select University',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      height: size.height,
                                      child: FutureBuilder(
                                        future: _data,
                                        builder: (_, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else {
                                            if (snapshot.hasError) {
                                              return Text("some error");
                                            } else if (snapshot.hasData ==
                                                null) {
                                              return Text("No data found");
                                            } else if (snapshot.hasData) {
                                              return Text("No data found");
                                            }

                                            return GridView.builder(
                                              padding: EdgeInsets.all(10.0),
                                              primary: false,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: list.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      childAspectRatio: 2 / 2,
                                                      mainAxisSpacing: 10,
                                                      crossAxisSpacing: 10),
                                              itemBuilder: (ctx, index) {
                                                return Column(
                                                  children: [
                                                    Card(
                                                      elevation: 10,
                                                      child: Container(
                                                        height: size.height / 7,
                                                        width: size.width / 3,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    10.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    10.0),
                                                          ),
                                                        ),
                                                        child: Ink(
                                                          child: InkWell(
                                                            onTap: () {
                                                              UniversitiesName:
                                                              list[index].isActive ==
                                                                      false
                                                                  ? Fluttertoast.showToast(
                                                                      msg:
                                                                          "will be added soon",
                                                                      toastLength:
                                                                          Toast
                                                                              .LENGTH_SHORT,
                                                                      gravity: ToastGravity
                                                                          .CENTER,
                                                                      timeInSecForIosWeb:
                                                                          1,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .green,
                                                                      textColor:
                                                                          Colors
                                                                              .white,
                                                                      fontSize:
                                                                          16.0)
                                                                  : Navigator.of(
                                                                          context)
                                                                      .pushReplacement(
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (ctx) =>
                                                                                LoginHome(
                                                                          UniversitiesName:
                                                                              list[index].imageUrl,
                                                                          UniversitiesId:
                                                                              list[index].universityId,
                                                                          UniversityURL:
                                                                              list[index].universityUrl,
                                                                        ),
                                                                      ),
                                                                    );
                                                            },
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                              child:
                                                                  FadeInImage(
                                                                placeholder:
                                                                    AssetImage(
                                                                        "assets/placeholder.png"),
                                                                image: NetworkImage(
                                                                    "${list[index].imageUrl}"),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                    ),
                  ),
        disconnected: Center(key: UniqueKey(), child: ConnectionStatuesBars()),
      ),
    );
  }
}
