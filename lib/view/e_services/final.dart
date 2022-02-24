import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:edu_pro/widget/http.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class Final extends StatefulWidget {
  const Final({Key? key}) : super(key: key);

  @override
  State<Final> createState() => _UploadState();
}

class _UploadState extends State<Final> {
  initState() {
    super.initState();
  }

  File? imageFile;
  var pickFile;
  var bytes;
  var byt;
  String? base64string;
  String? bs4str;

  Future<void> getImage() async {
    pickFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(pickFile!.path);
      base64string = base64Encode(imageFile!.readAsBytesSync());
    });
  }

  Future<String> uploadImage(String filePath) async {
    HttpOverrides.global = MyHttpOverrides();

    try {
      http.MultipartRequest request = new http.MultipartRequest(
          "POST", Uri.parse("https://192.168.1.13:3000/api/Upload"));
      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath("file", filePath);
      request.files.add(multipartFile);
      var headers = {"Content-Type": "multipart/form-data"};
      request.headers.addAll(headers);

      var response = await request.send();
      if (response.statusCode == 200) {
        final responseString = response.stream.bytesToString();

        print('Image uploaded! $response');
        return responseString;
      } else {
        print('Image not uploaded');
        print('Image uploaded! $response');

        print('${response.statusCode}');
        return '  ';
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
        title: Text('Image Final'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 60),
                  imageFile != null
                      ? Container(
                          height: 300,
                          width: double.infinity,
                          child: Image.file(imageFile!),
                        )
                      : Container(
                          width: size.width * .6,
                          height: 100,
                          child: Icon(
                            Icons.image,
                            size: 50,
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          getImage();
                        },
                        child: Text('Pick Image')),
                  )
                ],
              ),
              Container(
                child: TextButton(
                  onPressed: () {
                    print('base64string : ${base64string.toString()}');
                    uploadImage(pickFile!.path);
                  },
                  child: Column(
                    children: [
                      Text('Upload'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
