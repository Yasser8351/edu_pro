import 'dart:convert';

import 'package:edu_pro/services/all_api.dart';
import 'package:edu_pro/sharepref/user_share_pref.dart';
import 'package:edu_pro/view_models/profile_view_model.dart';
import 'package:edu_pro/widget/full_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../my_profile/my_profile.dart';
import '../universities.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({Key? key, this.image, this.address, this.phone})
      : super(key: key);
  static const routeName = 'update';
  final String? image;
  String? address;
  String? phone;

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  var _isLoading = false;
  Future? _data;
  final _form = GlobalKey<FormState>();
  var _addressController = TextEditingController();
  var _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addressController.text = widget.address!;
    _phoneController.text = widget.phone!;
  }

  bool isSelectedFaculty = false;

  @override
  void dispose() {
    super.dispose();
    _addressController.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var list =
        Provider.of<ProfileViewModel>(context, listen: false).ProfileList;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              SharedPrefUser().logout();
              Navigator.of(context).pushNamed(Universities.routeName);
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => FullImage(image: "${widget.image}")));
              },
              child: CircleAvatar(
                maxRadius: 20,
                backgroundImage: MemoryImage(
                  base64Decode("${widget.image}"),
                ),
              ),
            ),
            SizedBox(width: 20),
            Text(
              'Update Profile',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          height: 700,
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.only(top: 10),
            height: 450,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 600,
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
                                    return list == null
                                        ? Text('data')
                                        : Container(
                                            padding: EdgeInsets.all(22),
                                            height: size.height / 4,
                                            child: ListView.builder(
                                              itemCount: list.length,
                                              itemBuilder: (ctx, index) =>
                                                  Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                ),
                                                child: Form(
                                                  key: _form,
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                        textAlign:
                                                            TextAlign.left,
                                                        controller:
                                                            _phoneController,
                                                        decoration:
                                                            InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        )),
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        onFieldSubmitted: (_) {
                                                          //FocusScope.of(context).requestFocus(_passwordFocus);
                                                        },
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Please Enter the phone';
                                                          }
                                                          return null;
                                                        },
                                                        onSaved: (value) {},
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      TextFormField(
                                                        textAlign:
                                                            TextAlign.left,
                                                        controller:
                                                            _addressController,
                                                        decoration:
                                                            InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        )),
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        onFieldSubmitted: (_) {
                                                          //FocusScope.of(context).requestFocus(_passwordFocus);
                                                        },
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Please Enter the address';
                                                          }
                                                          return null;
                                                        },
                                                        onSaved: (value) {},
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      Container(
                                                        height: 50.0,
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                // color: Colors.blue,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary),
                                                        child: TextButton(
                                                          child: const Text(
                                                            'Update',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18.0),
                                                          ),
                                                          onPressed: () {
                                                            final isValid = _form
                                                                .currentState!
                                                                .validate();
                                                            if (!isValid) {
                                                              return null;
                                                            }
                                                            _form.currentState!
                                                                .save();
                                                            // if(_phoneController.text >10|| _phoneController.text< 10)

                                                            AllApi()
                                                                .updateProfile(
                                                                    _addressController
                                                                        .text,
                                                                    _phoneController
                                                                        .text)
                                                                .then(
                                                                  (value) => {
                                                                    if (value)
                                                                      {
                                                                        setState(
                                                                            () {
                                                                          _isLoading =
                                                                              true;

                                                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                              backgroundColor: Colors.green,
                                                                              duration: Duration(seconds: 2),
                                                                              content: Text("Profile updated successfully")));
                                                                          Navigator.of(context)
                                                                              .pushNamed(MyProfile.routeName);
                                                                        }),
                                                                      }
                                                                    else
                                                                      {
                                                                        setState(
                                                                            () {
                                                                          _isLoading =
                                                                              false;
                                                                        }),
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder: (context) =>
                                                                              AlertDialog(
                                                                            title:
                                                                                Text("An error occurred!"),
                                                                            content:
                                                                                Text("Something wrong"),
                                                                            actions: [
                                                                              TextButton(
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                  child: Text("Ok"))
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                            backgroundColor:
                                                                                Colors.red,
                                                                            duration: Duration(seconds: 2),
                                                                            content: Text("an error occurred")))
                                                                      }
                                                                  },
                                                                );
                                                          },
                                                        ),
                                                      ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
