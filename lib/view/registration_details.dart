import 'package:edu_pro/models/registration_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:edu_pro/view_models/registration_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationDetails extends StatefulWidget {
  const RegistrationDetails({Key? key}) : super(key: key);
  static const routeName = "RegistrationDetails";

  @override
  State<RegistrationDetails> createState() => _RegistrationDetailsState();
}

class _RegistrationDetailsState extends State<RegistrationDetails> {
  Future? _data;

  bool _isLoading = false;
  var api = AllApi();
  @override
  void initState() {
    super.initState();
    _isLoading = true;

    _data = Provider.of<RegistrationViewModel>(context, listen: false)
        .fetchRegistration()
        .then((_) => setState(() {
              _isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var registrationList =
        Provider.of<RegistrationViewModel>(context, listen: false)
            .registrationList;
    return Scaffold(
      body: registrationList == null
          ? Text("No Data")
          : FutureBuilder<List<RegistrationFeesModel>?>(
              future: api.fetchRegistrationFees(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
                    return Text("some error");
                  } else if (snapshot.hasData == null) {
                    return Text("No data found");
                  } else if (snapshot.hasData) {
                    var list = snapshot.data;

                    print("list $list");

                    return list == null
                        ? Text("")
                        : Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            height: size.height * registrationList.length / 5.2,
                            child: ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (ctx, index) {
                                // String dateToDB = "";
                                // dateToDB = "${list[index].courseFeesSDG}";
                                // var dateToDay = DateTime.parse(dateToDB).day;
                                // var dateToMonth = DateTime.parse(dateToDB).month;
                                // var dateToYear = DateTime.parse(dateToDB).year;

                                // String dateFromDB = "";
                                // dateFromDB =
                                //     "${registrationList[index].dateFrom}";
                                // var dateFromDay = DateTime.parse(dateFromDB).day;
                                // var dateFromMonth =
                                //     DateTime.parse(dateFromDB).month;
                                // var dateFromYear =
                                //     DateTime.parse(dateFromDB).year;
                                return Card(
                                    margin: EdgeInsets.only(top: 10),
                                    elevation: 10,
                                    child: Column(children: [
                                      const SizedBox(height: 15),
                                      ListTile(
                                        title: Text(
                                          'course Fees SDG',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background),
                                        ),
                                        trailing: Text(
                                          '${list[index].courseFeesSDG}',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background),
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       vertical: 15, horizontal: 4),
                                      //   child: Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       Text(
                                      //         '${list[index].courseFeesSDG}',
                                      //         style: TextStyle(
                                      //             color: Theme.of(context)
                                      //                 .colorScheme
                                      //                 .background),
                                      //       ),
                                      //       const SizedBox(height: 20),
                                      //     ],
                                      //   ),
                                      // )
                                    ]));
                              },
                            ),
                          );
                  }
                  return Text("");
                }
              },
            ),
    );
  }
}
