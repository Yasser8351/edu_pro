/* */
import 'dart:math';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view_models/fees_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationDetails extends StatefulWidget {
  const RegistrationDetails({Key? key}) : super(key: key);
  static const routeName = 'RegistrationDetails';

  @override
  State<RegistrationDetails> createState() => _FeesInformationState();
}

class _FeesInformationState extends State<RegistrationDetails> {
  bool isSelectedSemester = false;
  Future? _dataFees;
  int yerId = 137;

  String? _valueAcademicYear;
  String? _val;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
//int.parse(_valueAcademicYear.toString()
    _dataFees = Provider.of<FeesViewModel>(context, listen: false)
        .fetchFees(yerId)
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  var _expand1 = true;
  var _expand2 = true;
  var _expand3 = true;
  var _expand4 = true;
  var _expand5 = true;
  var _expand6 = true;

  bool isSelected = false;
  var api = Api();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var feesList = Provider.of<FeesViewModel>(context, listen: false).FeesList;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Registration Details',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: api.isServerError
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
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    feesList!.length == 0
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 100),
                              child: Text(
                                "No Data Found",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black54),
                              ),
                            ),
                          )
                        : Container(
                            height: size.height - 70, //550
                            color: Colors.grey[50],
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: FutureBuilder(
                                future: _dataFees,
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
                                    return Container(
                                      height: 300,
                                      child: ListView.builder(
                                        itemCount:
                                            feesList.length, //resultList.length
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                height: _expand1
                                                    ? min(300 * 20.0 + 110, 140)
                                                    : 105,
                                                child: Card(
                                                  margin: EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      ListTile(
                                                        title: Text(
                                                          "Final Fees",
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary),
                                                        ),
                                                        trailing: IconButton(
                                                          icon: Icon(
                                                            _expand1
                                                                ? Icons
                                                                    .expand_less
                                                                : Icons
                                                                    .expand_more,
                                                            color: _expand1
                                                                ? Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary
                                                                : Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onSurface,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              _expand1 =
                                                                  !_expand1;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds: 300),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 15,
                                                                vertical: 4),
                                                        height: min(
                                                            10 * 20.0 + 10, 29),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Text(
                                                              _expand1
                                                                  ? "Total"
                                                                  : "",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black38,
                                                              ),
                                                            ),
                                                            Text(
                                                              _expand1
                                                                  ? "${feesList[index].finalFees} SDG"
                                                                  : "",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black38,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10), //final fees
                                              AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                height: _expand2
                                                    ? min(300 * 20.0 + 110, 140)
                                                    : 105,
                                                child: Card(
                                                  margin: EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      ListTile(
                                                        title: Text(
                                                          "course Fees",
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary),
                                                        ),
                                                        trailing: IconButton(
                                                          icon: Icon(
                                                            _expand2
                                                                ? Icons
                                                                    .expand_less
                                                                : Icons
                                                                    .expand_more,
                                                            color: _expand2
                                                                ? Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary
                                                                : Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onSurface,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              _expand2 =
                                                                  !_expand2;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds: 300),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 15,
                                                                vertical: 4),
                                                        height: min(
                                                            10 * 20.0 + 10, 29),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Text(
                                                              _expand2
                                                                  ? "Total"
                                                                  : "",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black38,
                                                              ),
                                                            ),
                                                            Text(
                                                              _expand2
                                                                  ? "${feesList[index].courseFees} SDG"
                                                                  : "",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black38,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  height: 10), //course fees
                                              AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                height: _expand3
                                                    ? min(300 * 20.0 + 110, 140)
                                                    : 105,
                                                child: Card(
                                                  margin: EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      ListTile(
                                                        title: Text(
                                                          "Registration Fees",
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary),
                                                        ),
                                                        trailing: IconButton(
                                                          icon: Icon(
                                                            _expand3
                                                                ? Icons
                                                                    .expand_less
                                                                : Icons
                                                                    .expand_more,
                                                            color: _expand3
                                                                ? Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary
                                                                : Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onSurface,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              _expand3 =
                                                                  !_expand3;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds: 300),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 15,
                                                                vertical: 4),
                                                        height: min(
                                                            10 * 20.0 + 10, 29),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Text(
                                                              _expand3
                                                                  ? "Total"
                                                                  : "",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black38,
                                                              ),
                                                            ),
                                                            Text(
                                                              _expand3
                                                                  ? "${feesList[index].registrationFees} SDG"
                                                                  : "",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black38,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  height:
                                                      10), //registrationFees
                                              AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                height: _expand4
                                                    ? min(300 * 20.0 + 110, 140)
                                                    : 105,
                                                child: Card(
                                                  margin: EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      ListTile(
                                                        title: Text(
                                                          "Admission Fees",
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary),
                                                        ),
                                                        trailing: IconButton(
                                                          icon: Icon(
                                                            _expand4
                                                                ? Icons
                                                                    .expand_less
                                                                : Icons
                                                                    .expand_more,
                                                            color: _expand4
                                                                ? Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary
                                                                : Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onSurface,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              _expand4 =
                                                                  !_expand4;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds: 300),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 15,
                                                                vertical: 4),
                                                        height: min(
                                                            10 * 20.0 + 10, 29),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Text(
                                                              _expand4
                                                                  ? "Total"
                                                                  : "",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black38,
                                                              ),
                                                            ),
                                                            Text(
                                                              _expand4
                                                                  ? "${feesList[index].admissionFees} SDG"
                                                                  : "",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black38,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10), //athr fees
                                              AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                height: _expand5
                                                    ? min(300 * 20.0 + 110, 140)
                                                    : 105,
                                                child: Card(
                                                  margin: EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      ListTile(
                                                        title: Text(
                                                          "Aether Fees",
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary),
                                                        ),
                                                        trailing: IconButton(
                                                          icon: Icon(
                                                            _expand5
                                                                ? Icons
                                                                    .expand_less
                                                                : Icons
                                                                    .expand_more,
                                                            color: _expand5
                                                                ? Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary
                                                                : Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onSurface,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              _expand5 =
                                                                  !_expand5;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds: 300),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 15,
                                                                vertical: 4),
                                                        height: min(
                                                            10 * 20.0 + 10, 29),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Text(
                                                              _expand5
                                                                  ? "${feesList[index].paymentMethodName}"
                                                                  : "",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black38,
                                                              ),
                                                            ),
                                                            Text(
                                                              _expand5
                                                                  ? ""
                                                                  : "",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black38,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),

                                              AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                height: _expand5
                                                    ? min(300 * 20.0 + 110, 140)
                                                    : 105,
                                                child: Card(
                                                  margin: EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      ListTile(
                                                        title: Text(
                                                          "payment Method",
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary),
                                                        ),
                                                        trailing: IconButton(
                                                          icon: Icon(
                                                            _expand5
                                                                ? Icons
                                                                    .expand_less
                                                                : Icons
                                                                    .expand_more,
                                                            color: _expand5
                                                                ? Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary
                                                                : Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onSurface,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              _expand5 =
                                                                  !_expand5;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds: 300),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 15,
                                                                vertical: 4),
                                                        height: min(
                                                            10 * 20.0 + 10, 29),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Text(
                                                              _expand5
                                                                  ? "${feesList[index].paymentMethodName}"
                                                                  : "",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black38,
                                                              ),
                                                            ),
                                                            Text(
                                                              _expand5
                                                                  ? ""
                                                                  : "",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black38,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  height: 10), //admissionFees
                                            ],
                                          );
                                        },
                                      ),
                                    );

                                    // return Container(
                                    //   height: 300,
                                    //   child: ListView.builder(
                                    //     itemCount:
                                    //         feesList.length, //resultList.length
                                    //     itemBuilder: (context, index) {
                                    //       return ListTile(
                                    //         title: Text(
                                    //           "${feesList[index].note}",
                                    //           style: TextStyle(color: Colors.black54),
                                    //         ),
                                    //         trailing: Text(
                                    //           "${feesList[index].feesInfoId}",
                                    //           style: TextStyle(color: Colors.black54),
                                    //         ),
                                    //       );
                                    //     },
                                    //   ),
                                    // );
                                  }
                                },
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}
