import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view/complaints/complaints.dart';
import 'package:edu_pro/view_models/complain_view_model.dart';
import 'package:edu_pro/widget/error_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyComplaints extends StatefulWidget {
  const MyComplaints({Key? key}) : super(key: key);
  static const routeName = 'my_complaints';

  @override
  State<MyComplaints> createState() => _MyComplaintsState();
}

class _MyComplaintsState extends State<MyComplaints> {
  var _isLoading = false;
  Future? _data;
  var api = Api();

  @override
  initState() {
    super.initState();
    Provider.of<ComplainViewModel>(context, listen: false)
        .fetchComplain()
        .then((_) => setState(() {
              _isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var list =
        Provider.of<ComplainViewModel>(context, listen: false).ComplainList;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                Complaints.routeName, (route) => false);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          'Active Complaints',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: list == null
          ? ErrorConnection(
              message: 'Server error please try again later',
            )
          : Container(
              padding: EdgeInsets.only(top: 15),
              child: list.length == 0
                  ? ErrorConnection(message: 'No Data Found')
                  : Column(
                      children: [
                        Card(
                          color: Theme.of(context).colorScheme.primary,
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(
                              'Title',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            trailing: Text(
                              'Complaints   ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.all(10),
                          child: Container(
                            child: _isLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : FutureBuilder(
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
                                        return Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                // /  height: size.height * .2,
                                                height: size.height / 1.5,

                                                child: ListView.builder(
                                                  itemCount: list.length,
                                                  itemBuilder: (ctx, index) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          child: Text(
                                                            "${list[index].title}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onSurface,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        SizedBox(height: 50),
                                                        Container(
                                                          width: 150,
                                                          child: ConstrainedBox(
                                                            constraints:
                                                                BoxConstraints(),
                                                            child: Text(
                                                              "${list[index].complaint}",
                                                              maxLines: 4,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .onSurface,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                          ),
                        ),
                      ],
                    ),
            ),
    );
  }
}
