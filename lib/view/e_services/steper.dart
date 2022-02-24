import 'dart:convert';

import 'package:edu_pro/models/e-services_name.dart';
import 'package:edu_pro/models/e-services_type.dart';
import 'package:edu_pro/view/e_services/e_services.dart';
import 'package:edu_pro/view_models/e_services_type_view_model.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:edu_pro/widget/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Steper extends StatefulWidget {
  const Steper({Key? key}) : super(key: key);

  @override
  _steperState createState() => _steperState();
}

class _steperState extends State<Steper> {
  int currentStep = 0;
  bool isCompleted = false;
  bool _isLoading = false;

  Future? _dataType, _dataName;

  String? imagePathResponse;
  final _form = GlobalKey<FormState>();
  final checkBoxList = [
    CheckBoxModel(title: 'Email', value: true),
    CheckBoxModel(title: 'on Hand', value: true),
    CheckBoxModel(title: 'Delivered', value: false),
  ];
  //var checkBoxList;
  final checkBoxServicesList = [
    CheckBoxServices(title: 'Test', value: false),
    CheckBoxServices(title: 'efada', value: false),
    CheckBoxServices(title: 'estegala', value: false),
  ];
  final allChecked = CheckBoxModel(title: 'All Checked');
  final _fileName = TextEditingController();
  File? imageFile;
  var pickFile;
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    setState(() {
      _dataType = Provider.of<EServicesTypeViewModel>(context, listen: false)
          .fetchEServices()
          .then((_) => setState(() {
                //  _isLoading = false;
              }));
      _dataName = Provider.of<EServicesTypeViewModel>(context, listen: false)
          .fetchEServicesName()
          .then((_) => setState(() {
                _isLoading = false;
              }));
    });
  }

  Future<void> getImage() async {
    pickFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(pickFile!.path);
    });
    print('${imageFile}');
  }

  Future<String> uploadImage(String filePath) async {
    HttpOverrides.global = MyHttpOverrides();

    try {
      http.MultipartRequest request = new http.MultipartRequest(
          "POST", Uri.parse("https://192.168.1.12:3000/api/Upload"));
      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath("file", filePath);
      request.files.add(multipartFile);
      var headers = {"Content-Type": "multipart/form-data"};
      request.headers.addAll(headers);

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseString = response.stream.bytesToString();
        responseString.then((value) => setState(() {
              imagePathResponse = value;
            }));
        print('image Path  $imagePathResponse');

        return responseString;
      } else {
        print('Image  not uploaded! ${response.statusCode}');
        return '';
      }
    } catch (error) {
      print(error);
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Request',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(EServices.routeName, (route) => false);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : isCompleted
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add Services Successfully',
                        style: TextStyle(color: Colors.black54, fontSize: 20),
                      ),
                      const SizedBox(height: 40),
                      Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.primary,
                        size: 100,
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          isCompleted = false;
                          currentStep = 0;
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              EServices.routeName, (route) => false);
                        },
                        child: Container(
                          width: 80,
                          child: Center(
                            child: Text(
                              'Back',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Stepper(
                  steps: getSteps(),
                  //type: StepperType.horizontal,
                  onStepContinue: () {
                    final isLasteStepp = currentStep == getSteps().length - 1;

                    if (isLasteStepp) {
                      setState(() => isCompleted = true);
                      //send Data to serever
                    } else {}

                    setState(() => currentStep += 1);
                  },
                  onStepTapped: (step) => setState(() => currentStep == step),
                  currentStep: currentStep,
                  onStepCancel: currentStep == 0
                      ? null
                      : () {
                          setState(() => currentStep -= 1);
                        },
                  controlsBuilder: (context, {onStepCancel, onStepContinue}) {
                    final isLasteStepp = currentStep == getSteps().length - 1;

                    return Container(
                      height: 50,
                      child: Row(
                        children: [
                          if (currentStep != 0)
                            Expanded(
                              child: ElevatedButton(
                                onPressed: onStepCancel,
                                child: Text(
                                  'Back',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                onStepContinue!();
                                // final isValid =
                                //           _form.currentState!.validate();
                                //       if (!isValid) {
                                //         return null;
                                //       }
                                //       _form.currentState!.save();
                              },
                              child: Text(
                                isLasteStepp ? 'Confirm' : 'Next',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
    );
  }

  List<Step> getSteps() {
    var listType =
        Provider.of<EServicesTypeViewModel>(context, listen: false).listType;
    var listName =
        Provider.of<EServicesTypeViewModel>(context, listen: false).listName;
    return [
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: Text('Delivery Method'),
        content: Container(
          child: Column(
            children: [
              ...listType!.map(buildSingle).toList(),
            ],
          ),
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: Text('Available Services'),
        content: Container(
          child: Column(
            children: [
              ...listName!.map(buildAvailableServices).toList(),
            ],
          ),
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: Text('Request Requirements'),
        content: Container(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 60),
                  imageFile != null
                      ? Container(
                          height: 200,
                          width: double.infinity,
                          child: Image.file(imageFile!),
                        )
                      : GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        getImage();
                      },
                      child: Text(
                        'Pick Image',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                child: TextButton(
                  onPressed: () {
                    print('imageFile :${pickFile.path.toString()}');
                    uploadImage(pickFile!.path);
                  },
                  child: Text('Upload'),
                ),
              ),
            ],
          ),
          // child: Column(
          //   children: [
          //     Form(
          //       key: _form,
          //       child: TextFormField(
          //         textAlign: TextAlign.left,
          //         controller: _fileName,
          //         decoration: InputDecoration(
          //             labelText: 'File Name',
          //             border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(4),
          //             )),
          //         textInputAction: TextInputAction.next,
          //         keyboardType: TextInputType.text,
          //         validator: (value) {
          //           if (value!.isEmpty) {
          //             return 'Please enter the Name';
          //           }
          //           return null;
          //         },
          //         onSaved: (value) {},
          //       ),
          //     ),
          //     const SizedBox(height: 20),
          //     GestureDetector(
          //       onTap: () {},
          //       child: Container(
          //         height: 40,
          //         width: 100,
          //         decoration: BoxDecoration(
          //           color: Colors.grey[400],
          //           borderRadius: BorderRadius.all(
          //             Radius.circular(10.0),
          //           ),
          //         ),
          //         child: Center(
          //             child: Row(
          //           children: [Text('Choose Files'), Icon(Icons.upload_file)],
          //         )),
          //       ),
          //     ),
          //     const SizedBox(height: 30),
          //   ],
          // ),
        ),
      ),
    ];
  }

  Widget buildSingle(EServicesTypeModel checkBoxModel) => FutureBuilder(
        future: _dataType,
        builder: (context, snapshot) => CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(checkBoxModel.deliveryTypeName.toString()),
          value: checkBoxModel.isAlwaysAvailable,
          onChanged: (value) {
            setState(() {
              checkBoxModel.isAlwaysAvailable = value!;
            });
          },
        ),
      );

  Widget buildAvailableServices(EServicesNameModel checkBoxModel) =>
      FutureBuilder(
        future: _dataName,
        builder: (context, snapshot) => AbsorbPointer(
          absorbing: checkBoxModel.isAlwaysAvailable! ? false : true,
          child: CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(checkBoxModel.servicesTypeName.toString()),
            value: checkBoxModel.isAlwaysAvailable,
            onChanged: (value) {
              setState(() {
                checkBoxModel.isAlwaysAvailable = value!;
              });
            },
          ),
        ),
      );
}

class CheckBoxModel {
  String? title;
  bool? value;
  CheckBoxModel({this.title, this.value});
}

class CheckBoxServices {
  String? title;
  bool? value;
  CheckBoxServices({this.title, this.value});
}
/*   
  Widget buildSingle(CheckBoxModel checkBoxModel) => FutureBuilder(
        future: _data,
        builder: (context, snapshot) => CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(checkBoxModel.title.toString()),
          value: checkBoxModel.value,
          onChanged: (value) {
            setState(() {
              checkBoxModel.value = value!;
            });
          },
        ),
      );


  Widget buildAvailableServices(CheckBoxServices checkBoxServices) =>
      CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(checkBoxServices.title.toString()),
        value: checkBoxServices.value,
        onChanged: (value) {
          setState(() {
            checkBoxServices.value = value!;
          });
        },
      );
*/