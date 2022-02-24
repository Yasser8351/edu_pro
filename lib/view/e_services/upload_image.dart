import 'package:flutter/material.dart';
import 'dart:io';
import 'package:edu_pro/widget/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? imageFile;
  var pickFile;

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
        title: Text('Upload Image'),
      ),
      body: Center(
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
      ),
    );
  }
}
