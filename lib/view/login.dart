import 'package:edu_pro/view/home.dart';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const routeName = 'login';

  @override
  _LoginState createState() => _LoginState();
}
//https://madeinsudan2.com/edu_pro/faculty.php

class _LoginState extends State<Login> {
  bool isSelectedFaculty = false;
  bool isSelectedBatch = false;
  bool isSelectedProgramme = false;

  String? _value;

  String? valueFaculty = 'Faculty of Medicine';
  String? valueBatch = 'Batch 1';
  String? valueProgramme = 'Bachelor';
  double? sizeBetweenFeiled = 10.0;
  String? _valueFaculty = 'Faculty of Medicine';
  String _valueBatch = "Batch 1";
  String _valueProgramme = "Bachelor";
  final _itemsFaculty = [
    'Faculty of Medicine',
    'Faculty of Pharmacy',
    'Faculty of Dentistry',
    'Faculty of Medical Laboratory Sciences',
    'Faculty of Radiological Sciences',
    'Faculty of Nursing Sciences',
    'Faculty of Engineering Department of Biomedical',
    'Faculty of Business Administration',
    'School of Dental Technology',
    'Faculty of Anaesthesia',
    'Faculty of Engineering Department of Electronic',
  ];
  final _itemsBatch = [
    'Batch 1',
    'Batch 2',
    'Batch 3',
    'Batch 4',
    'Batch 5',
  ];
  final _itemsProgramme = [
    'Bachelor',
    'Master',
    'Diploma',
  ];

  final _form = GlobalKey<FormState>();
  final _passwordFocus = FocusNode();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Container(
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: FutureBuilder<List<PostViewModel>>(
      //       future: data,
      //       builder: (context, snapshot) {
      //         if (snapshot.connectionState == ConnectionState.waiting) {
      //           return const CircularProgressIndicator();
      //         } else {
      //           var posts = snapshot.data;
      //           return ListView.builder(
      //             itemCount: 1,
      //             itemBuilder: (context, index) => Container(
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(4),
      //                 border: Border.all(
      //                     color: isSelectedFaculty
      //                         ? Theme.of(context).colorScheme.primary
      //                         : Colors.black38,
      //                     width: 1),
      //               ),
      //               child: Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: DropdownButtonHideUnderline(
      //                   child: DropdownButton<PostViewModel>(
      //                     hint: const Text("Select Faculty"),
      //                     style: TextStyle(
      //                         color: isSelectedFaculty
      //                             ? Theme.of(context).colorScheme.primary
      //                             : Colors.grey[700]),
      //                     value: posts!.first,
      //                     isExpanded: true,
      //                     iconSize: 28,
      //                     icon: Icon(Icons.arrow_drop_down,
      //                         color: isSelectedFaculty
      //                             ? Theme.of(context).colorScheme.primary
      //                             : Colors.black38),
      //                     items: posts
      //                         .map(
      //                           (PostViewModel item) =>
      //                               DropdownMenuItem<PostViewModel>(
      //                                   child: Text(item.id.toString()),
      //                                   value: item),
      //                         )
      //                         .toList(),
      //                     onChanged: (value) => setState(() {
      //                       //isSelectedFaculty = true;
      //                       this._value = value.toString();
      //                       print('print value = ${value.toString()}');
      //                     }),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           );
      //         }
      //       },
      //     ),
      //   ),
      // ),

      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.png', height: 160),
                  ///////////////////////////////////////////////////////////////
                  SizedBox(height: sizeBetweenFeiled),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: isSelectedFaculty
                              ? Theme.of(context).colorScheme.primary
                              : Colors.black38,
                          width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          focusColor: Colors.green,
                          hint: const Text("Select Faculty"),
                          style: TextStyle(
                              color: isSelectedFaculty
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey[700]),
                          value: _valueFaculty,
                          isExpanded: true,
                          iconSize: 28,
                          icon: Icon(Icons.arrow_drop_down,
                              color: isSelectedFaculty
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.black38),
                          items: _itemsFaculty
                              .map((String item) => DropdownMenuItem<String>(
                                  child: Text(item), value: item))
                              .toList(),
                          onChanged: (value) => setState(() {
                            isSelectedFaculty = true;
                            this._valueFaculty = value.toString();
                          }),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: sizeBetweenFeiled),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: isSelectedBatch
                              ? Theme.of(context).colorScheme.primary
                              : Colors.black38,
                          width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          focusColor: Colors.green,
                          hint: const Text("Select Batch"),
                          style: TextStyle(
                              color: isSelectedBatch
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey[700]),
                          value: _valueBatch,
                          isExpanded: true,
                          iconSize: 28,
                          icon: Icon(Icons.arrow_drop_down,
                              color: isSelectedBatch
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.black38),
                          items: _itemsBatch
                              .map((String item) => DropdownMenuItem<String>(
                                  child: Text(item), value: item))
                              .toList(),
                          onChanged: (value) => setState(() {
                            isSelectedBatch = true;
                            this._valueBatch = value.toString();
                          }),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: sizeBetweenFeiled),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: isSelectedProgramme
                                ? Theme.of(context).colorScheme.primary
                                : Colors.black38,
                            width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            focusColor: Theme.of(context).colorScheme.primary,
                            hint: const Text("Select Programme"),
                            value: _valueProgramme,
                            isExpanded: true,
                            iconSize: 28,
                            style: TextStyle(
                                color: isSelectedProgramme
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey[700]),
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Colors.black38),
                            items: _itemsProgramme
                                .map((String item) => DropdownMenuItem<String>(
                                    child: Text(item), value: item))
                                .toList(),
                            onChanged: (value) => setState(() {
                              isSelectedProgramme = true;
                              this._valueProgramme = value.toString();
                            }),
                          ),
                        ),
                      )),
                  SizedBox(height: sizeBetweenFeiled),
                  // Form(
                  //   key: _form,
                  //   child: ListView(
                  //     children: [
                  TextFormField(
                    textAlign: TextAlign.left,
                    controller: _userNameController,
                    decoration: InputDecoration(
                        labelText: 'username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        )
                        //hintText: 'username',
                        ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocus);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'يجب ادخال اسم المستخدم';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                  SizedBox(height: sizeBetweenFeiled),
                  TextFormField(
                    textAlign: TextAlign.left,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: 'password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        )
                        //hintText: 'password',
                        ),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'يجب ادخال كلمة المرور';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 30),
                  Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.primary),
                    child: TextButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(Home.routeName);
                      },
                    ),
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
