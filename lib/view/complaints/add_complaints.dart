import 'package:edu_pro/services/all_api.dart';
import 'package:edu_pro/view/complaints/my_complaints.dart';
import 'package:edu_pro/view/complaints/report_complaints.dart';
import 'package:edu_pro/view_models/complain_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddComplaints extends StatefulWidget {
  const AddComplaints({Key? key, this.editTitle, this.editComplaint})
      : super(key: key);
  static const routeName = 'add_complaints';
  final editTitle;
  final editComplaint;

  @override
  State<AddComplaints> createState() => _AddComplaintsState();
}

class _AddComplaintsState extends State<AddComplaints> {
  var _isLoading = false;
  Future? _data;
  late int complaintId;
  TextEditingController title = TextEditingController();
  TextEditingController complain = TextEditingController();

  final _form = GlobalKey<FormState>();

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
  void dispose() {
    super.dispose();
    title.dispose();
    complain.dispose();
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
                ReportComplaints.routeName, (route) => false);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          'My Complaints',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _form,
                      child: Column(
                        children: [
                          TextFormField(
                            textAlign: TextAlign.left,
                            controller: title,
                            // initialValue: widget.editTitle == null
                            //     ? ""
                            //     : "${widget.editTitle}",
                            decoration: InputDecoration(
                                labelText: 'title',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                )
                                //hintText: 'username',
                                ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onFieldSubmitted: (_) {
                              // FocusScope.of(context).requestFocus(_passwordFocus);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the title';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                            textAlign: TextAlign.left,
                            controller: complain,
                            // initialValue: widget.editComplaint == null
                            //     ? ""
                            //     : "${widget.editComplaint}",

                            decoration: InputDecoration(
                                labelText: 'complain',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                )),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the complain';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Theme.of(context).colorScheme.primary),
                        child: TextButton(
                          onPressed: () {
                            setState(
                              () {
                                final isValid = _form.currentState!.validate();
                                if (!isValid) {
                                  return null;
                                }
                                _form.currentState!.save();
                                isLoading = true;

                                AllApi()
                                    .sendData(title.text, complain.text)
                                    .then(
                                      (value) => {
                                        if (value)
                                          {
                                            setState(() {
                                              isLoading = false;

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      backgroundColor:
                                                          Colors.green,
                                                      duration:
                                                          Duration(seconds: 2),
                                                      content: Text(
                                                          "Complaint added successfully")));
                                              title.clear();
                                              complain.clear();

                                              _data = Provider.of<
                                                          ComplainViewModel>(
                                                      context,
                                                      listen: false)
                                                  .fetchComplain()
                                                  .then((_) => setState(() {
                                                        _isLoading = false;
                                                      }));
                                              var list = Provider.of<
                                                          ComplainViewModel>(
                                                      context,
                                                      listen: false)
                                                  .ComplainList;
                                            }),
                                          }
                                        else
                                          {
                                            setState(() {
                                              isLoading = false;
                                              initStates = true;
                                            }),
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title:
                                                    Text("An error occurred!"),
                                                content:
                                                    Text("Something wrong"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("Ok"))
                                                ],
                                              ),
                                            ),
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor: Colors.red,
                                                    duration:
                                                        Duration(seconds: 2),
                                                    content: Text(
                                                        "an error occurred")))
                                          }
                                      },
                                    );
                              },
                            );
                          },
                          child: isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.white))
                              : Text(
                                  "Add",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                ),
                        )),
                  ),
                ],
              ),
            ),
    );
  }
}
