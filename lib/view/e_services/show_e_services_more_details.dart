import 'package:edu_pro/view/e_services/show_e_services.dart';
import 'package:edu_pro/view_models/e_services_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowEServicesMoreDetails extends StatefulWidget {
  const ShowEServicesMoreDetails(
      {Key? key, this.price, this.paidAmount, this.paid, this.canceled})
      : super(key: key);
  static const routeName = "ShowEServicesMoreDetails";
  final price;
  final paidAmount;
  final paid;
  final canceled;
  @override
  _EServicesState createState() => _EServicesState();
}

class _EServicesState extends State<ShowEServicesMoreDetails> {
  var _isLoading = false;
  Future? _data;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });
    // _data = Provider.of<EServicesViewModel>(context, listen: false)
    //     .fetchEServices()
    //     .then((_) => setState(() {
    //           _isLoading = false;
    //         }));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var list =
        Provider.of<EServicesViewModel>(context, listen: false).EServicesList;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'More E-Services',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(ShowEServices.routeName);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Card(
              color: Theme.of(context).colorScheme.primary,
              margin: EdgeInsets.all(10),
              child: Padding(
                //padding: EdgeInsets.all(0),
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Paid Amount',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Paid',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Canceled',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    //width: 80,
                    child: Text(
                      '${widget.price.toString()}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    // width: 80,
                    child: Text(
                      '${widget.paidAmount.toString()}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: widget.paid
                        ? Icon(
                            Icons.checklist_sharp,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.check_box_outline_blank,
                            color: Colors.black54,
                          ),
                    // child: Text(
                    //   '${widget.paid.toString()}',
                    //   overflow: TextOverflow.ellipsis,
                    //   style: TextStyle(
                    //       color: Colors.black54,
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.normal),
                    //   textAlign: TextAlign.center,
                    // ),
                  ),
                  Container(
                    child: widget.canceled
                        ? Icon(
                            Icons.checklist_sharp,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.check_box_outline_blank,
                            color: Colors.black54,
                          ),
                    // child: Text(
                    //   '${widget.canceled.toString()}',
                    //   overflow: TextOverflow.ellipsis,
                    //   style: TextStyle(
                    //       color: Colors.black54,
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.normal),
                    //   textAlign: TextAlign.center,
                    // ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigator.of(context)
                    //     .pushNamed(ShowEServicesMoreDetails.routeName);
                  },
                  child: Container(
                    width: 50,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.green[700],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "View",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    // Navigator.of(context)
                    //     .pushNamed(ShowEServicesMoreDetails.routeName);
                  },
                  child: Container(
                    width: 70,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.green[900],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Services",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      /*
      body: Container(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : FutureBuilder(
                future: _data,
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
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
                        Card(
                          color: Theme.of(context).colorScheme.primary,
                          margin: EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Date',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'Request Status',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  ' ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                // Text(
                                //   'Canceled',
                                //   style: TextStyle(color: Colors.white),
                                // ),
                                // Text(
                                //   'Request Status',
                                //   style: TextStyle(color: Colors.white),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: size.height / 1.24,
                          child: ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (ctx, index) {
                              String dateToDB = "";
                              dateToDB = "${list[index].date}";
                              var dateToDay = DateTime.parse(dateToDB).day;
                              var dateToMonth = DateTime.parse(dateToDB).month;
                              var dateToYear = DateTime.parse(dateToDB).year;

                              print("list length: ${list.length}");
                              return Container(
                                height: size.height / 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: 80,
                                      child: Text(
                                        "$dateToYear-$dateToMonth-$dateToDay",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text(
                                        "${list[index].requestStatusName}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.green[700],
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "View",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
      ),
   */
    );
  }
}
