import 'package:edu_pro/models/registration_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:edu_pro/view/home.dart';
import 'package:edu_pro/view_models/registration_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationDetails extends StatefulWidget {
  const RegistrationDetails({Key? key, this.currencyNo}) : super(key: key);
  static const routeName = "RegistrationDetails";
  final currencyNo;

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

    print(widget.currencyNo);

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
                            height: size.height * registrationList.length,
                            child: ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (ctx, index) {
                                return Column(
                                  children: [
                                    Card(
                                      margin: EdgeInsets.only(top: 10),
                                      elevation: 10,
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 15),
                                          ListTile(
                                            title: Text(
                                              widget.currencyNo == 1
                                                  ? 'Course Fees SDG'
                                                  : 'Course Fees USD',
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
                                          ListTile(
                                            title: Text(
                                              widget.currencyNo == 1
                                                  ? 'Admission Fees SDG'
                                                  : 'Admission Fees USD',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background),
                                            ),
                                            trailing: Text(
                                              '${list[index].admissionFeesSDG}',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background),
                                            ),
                                          ),
                                          ////////////////////////////////////////
                                          ListTile(
                                            title: Text(
                                              widget.currencyNo == 1
                                                  ? 'Foreigners Course Fees SDG'
                                                  : 'Foreigners Course Fees USD',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background),
                                            ),
                                            trailing: Text(
                                              '${list[index].foreignersCourseFeesUSD}',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background),
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              widget.currencyNo == 1
                                                  ? 'Registration Fees SDG'
                                                  : 'Registration Fees USD',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background),
                                            ),
                                            trailing: Text(
                                              '${list[index].registerationFeesSDG}',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background),
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              widget.currencyNo == 1
                                                  ? 'Bridging Fees SDG'
                                                  : 'Bridging Fees USD',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background),
                                            ),
                                            trailing: Text(
                                              '${list[index].bridgingFeesSDG}',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background),
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Training Fees',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background),
                                            ),
                                            trailing: Text(
                                              '${list[index].trainingFees}',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 50),
                                    GestureDetector(
                                      onTap: () {
                                        AllApi()
                                            .sendFeesData(
                                              widget.currencyNo,
                                              widget.currencyNo == 1
                                                  ? list[index].courseFeesSDG
                                                  : list[index].courseFeesUSD,
                                              widget.currencyNo == 1
                                                  ? list[index].admissionFeesSDG
                                                  : list[index]
                                                      .admissionFeesUSD,
                                              widget.currencyNo == 1
                                                  ? list[index]
                                                      .registerationFeesSDG
                                                  : list[index]
                                                      .registerationFeesUSD,
                                              list[index].trainingFees,
                                            )
                                            .then(
                                              (value) => {
                                                if (value)
                                                  {
                                                    setState(() {
                                                      _isLoading = false;

                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              backgroundColor:
                                                                  Colors.green,
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          2),
                                                              content: Text(
                                                                  "Fees added successfully")));

                                                      Navigator.of(context)
                                                          .pushNamedAndRemoveUntil(
                                                              Home.routeName,
                                                              (route) => false);
                                                      // title.clear();
                                                      // complain.clear();
                                                    }),
                                                  }
                                                else
                                                  {
                                                    setState(() {
                                                      _isLoading = false;
                                                    }),
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        title: Text(
                                                            "An error occurred!"),
                                                        content: Text(
                                                            "Something wrong"),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text("Ok"))
                                                        ],
                                                      ),
                                                    ),
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            backgroundColor:
                                                                Colors.red,
                                                            duration: Duration(
                                                                seconds: 2),
                                                            content: Text(
                                                                "an error occurred")))
                                                  }
                                              },
                                            );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: Container(
                                          height: 40.0,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                          child: Center(
                                            child: _isLoading
                                                ? CircularProgressIndicator()
                                                : Text(
                                                    'Confirm Payment', //Next
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18.0),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
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
