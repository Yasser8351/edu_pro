import 'package:edu_pro/services/all_api.dart';
import 'package:edu_pro/view/complaints/report_complaints.dart';
import 'package:edu_pro/view_models/complain_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateComplaints extends StatefulWidget {
  const UpdateComplaints(
      {Key? key,
      this.complaintId,
      this.isChecked = true,
      this.editTitle = "",
      this.editComplaint = ""})
      : super(key: key);
  static const routeName = 'Update_complaints';
  final String editTitle;
  final String editComplaint;
  final complaintId;
  final bool isChecked;

  @override
  State<UpdateComplaints> createState() => _UpdateComplaintsState();
}

class _UpdateComplaintsState extends State<UpdateComplaints> {
  var _isLoading = false;
  Future? _data;

  TextEditingController title = TextEditingController();
  TextEditingController complain = TextEditingController();

  final _form = GlobalKey<FormState>();

  bool isLoading = false;
  bool initStates = false;

  @override
  initState() {
    super.initState();
    title.text = widget.editTitle;
    complain.text = widget.editComplaint;

    Provider.of<ComplainViewModel>(context, listen: false)
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
          'Update Complaints',
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
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onFieldSubmitted: (_) {},
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
                            decoration: InputDecoration(
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
                                    .updateData(
                                      int.parse(widget.complaintId),
                                      title.text,
                                      complain.text,
                                      widget.isChecked,
                                    )
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
                                                          "Complaint updated successfully")));
                                              title.clear();
                                              complain.clear();
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
                                  "Update",
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
