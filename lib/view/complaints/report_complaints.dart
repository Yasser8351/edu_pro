import 'package:edu_pro/services/all_api.dart';
import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view/complaints/add_complaints.dart';
import 'package:edu_pro/view/complaints/complaints.dart';
import 'package:edu_pro/view/complaints/my_complaints.dart';
import 'package:edu_pro/view/complaints/update_complain.dart';
import 'package:edu_pro/view_models/complain_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ReportComplaints extends StatefulWidget {
  const ReportComplaints({Key? key}) : super(key: key);
  static const routeName = 'report_complaints';

  @override
  State<ReportComplaints> createState() => _ReportComplaintsState();
}

class _ReportComplaintsState extends State<ReportComplaints> {
  var _isLoading = false;
  Future? _data;
  late int complaintId;
  TextEditingController title = TextEditingController();
  TextEditingController complain = TextEditingController();

  final _form = GlobalKey<FormState>();
  var api = Api();

  bool isLoading = false;
  bool initStates = false;

  @override
  initState() {
    super.initState();

    _data = Provider.of<ComplainViewModel>(context, listen: false)
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
          'Report Complaint',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => AddComplaints()));
            },
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Add",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(width: 12),
                ],
              ),
            ),
          ),
          // TextButton.icon(
          //     onPressed: () {
          //       Navigator.of(context).push(MaterialPageRoute(
          //           builder: (ctx) => AddComplaints(
          //                 typePage: "Add",
          //               )));
          //     },
          //     icon: Icon(
          //       Icons.add,
          //       color: Colors.white,
          //     ),
          //     label: Text(
          //       "Add",
          //       style: TextStyle(color: Colors.white, fontSize: 16),
          //     ))
        ],
      ),
      body: list == null
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
          : _isLoading
              ? Center(child: CircularProgressIndicator())
              : list.length == 0
                  ? Center(
                      child: Text(
                        'No Data Found',
                        style: TextStyle(fontSize: 25, color: Colors.black54),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Card(
                            color: Theme.of(context).colorScheme.primary,
                            margin: EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Title',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Complaints',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  SizedBox(width: 5),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.all(10),
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
                                        }
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            // height: 550,
                                            height: size.height / 1.34,
                                            child: ListView.builder(
                                              // physics: NeverScrollableScrollPhysics(),
                                              itemCount: list!.length,
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
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        "${list![index].title}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ),
                                                    SizedBox(width: 40),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        width: 80,
                                                        child: Text(
                                                          "${list![index].complaint}",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .black54),
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        onPressed: () {
                                                          complaintId = int.parse(
                                                              "${list![index].complaintId}");
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                              title: Text(
                                                                  "Delete Complain"),
                                                              content: Text(
                                                                  "Do you want to remove the complaint?"),
                                                              actions: [
                                                                TextButton(
                                                                  child: Text(
                                                                      "Yes"),
                                                                  onPressed:
                                                                      () {
                                                                    AllApi()
                                                                        .deleteComplain(
                                                                            complaintId)
                                                                        .then(
                                                                      (value) {
                                                                        {
                                                                          if (value) {
                                                                            Fluttertoast.showToast(
                                                                                msg: "Deleted successfully",
                                                                                toastLength: Toast.LENGTH_SHORT,
                                                                                gravity: ToastGravity.CENTER,
                                                                                timeInSecForIosWeb: 1,
                                                                                backgroundColor: Colors.green,
                                                                                textColor: Colors.white,
                                                                                fontSize: 16.0);
                                                                          } else {
                                                                            Fluttertoast.showToast(
                                                                                msg: "an error occurred",
                                                                                toastLength: Toast.LENGTH_SHORT,
                                                                                gravity: ToastGravity.CENTER,
                                                                                timeInSecForIosWeb: 1,
                                                                                backgroundColor: Colors.red,
                                                                                textColor: Colors.white,
                                                                                fontSize: 16.0);
                                                                          }
                                                                        }
                                                                      },
                                                                    );
                                                                    _data = Provider.of<ComplainViewModel>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .fetchComplain()
                                                                        .then((value) =>
                                                                            {
                                                                              isLoading = false,
                                                                              Navigator.of(context).pop(),
                                                                              list = Provider.of<ComplainViewModel>(context, listen: false).ComplainList,
                                                                              setState(() {})
                                                                            });
                                                                  },
                                                                ),
                                                                TextButton(
                                                                  child: Text(
                                                                      "No"),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            false);
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        icon: Icon(
                                                          Icons.delete,
                                                          size: 20,
                                                        )),
                                                    SizedBox(width: 5),
                                                    IconButton(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        onPressed: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder: (ctx) =>
                                                                      UpdateComplaints(
                                                                        editTitle:
                                                                            "${list![index].title.toString()}",
                                                                        editComplaint:
                                                                            "${list![index].complaint.toString()}",
                                                                        complaintId:
                                                                            "${list![index].complaintId}",
                                                                        isChecked: list![index].isChecked
                                                                                as bool
                                                                            ? true
                                                                            : false,
                                                                      )));
                                                          //"${list![index].isChecked}"
                                                        },
                                                        icon: Icon(
                                                          Icons.edit,
                                                          size: 20,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
    );
  }
}

/*
   child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'test',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.background),
                  ),
                  Text(
                    'for test',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.background),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Delete',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.background),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary
                          Edit
                          ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Edit',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.background),
                      ),
                    ),
                  ),
                ],
              ),
           
*/
