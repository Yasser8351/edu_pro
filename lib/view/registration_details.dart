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
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    height: size.height * registrationList.length / 5.2,
                    child: ListView.builder(
                      itemCount: registrationList.length,
                      itemBuilder: (ctx, index) {
                        String dateToDB = "";
                        dateToDB = "${registrationList[index].dateTo}";
                        var dateToDay = DateTime.parse(dateToDB).day;
                        var dateToMonth = DateTime.parse(dateToDB).month;
                        var dateToYear = DateTime.parse(dateToDB).year;

                        String dateFromDB = "";
                        dateFromDB = "${registrationList[index].dateFrom}";
                        var dateFromDay = DateTime.parse(dateFromDB).day;
                        var dateFromMonth = DateTime.parse(dateFromDB).month;
                        var dateFromYear = DateTime.parse(dateFromDB).year;
                        return Card(
                          margin: EdgeInsets.only(top: 10),
                          elevation: 10,
                          child: Column(
                            children: [
                              const SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 50,
                                      child: Text(
                                        '${registrationList[index].installmentName}',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background),
                                      ),
                                    ),
                                    Text(
                                      '$dateFromYear-$dateFromMonth-$dateFromDay',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background),
                                    ),
                                    Text(
                                      '$dateToYear-$dateToMonth-$dateToDay',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background),
                                    ),
                                    Text(
                                      '${registrationList[index].percentage.toString()}%  ',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
    );
  }
}
