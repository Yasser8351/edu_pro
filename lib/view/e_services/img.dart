// import 'dart:convert';
// import 'dart:io';
// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

// import 'uploadFile.dart';

// class Upload extends StatefulWidget {
//   const Upload({Key? key}) : super(key: key);

//   @override
//   State<Upload> createState() => _UploadState();
// }

// class _UploadState extends State<Upload> {
//   initState() {
//     super.initState();
//     //getImage();
//   }

//   File? imageFile;
//   XFile? pickFile;

//   Future<void> getImage() async {
//     // var bytes = await ImagePicker().pickImage(source: ImageSource.gallery).readAsBytes();
//     pickFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     setState(() {
//       imageFile = File(pickFile!.path);
//     });
//     print('${imageFile}');
//   }

//   Upload(File img) async {
//     HttpOverrides.global = MyHttpOverrides();

//     var uri = Uri.parse("https://192.168.1.13:3000/api/Image");

//     var request = new http.MultipartRequest("POST", uri);
//     request.files.add(new http.MultipartFile.fromBytes(
//       "file",
//       img.readAsBytesSync(),
//       filename: "logo.png",
//     ));

//     var response = await request.send();
//     print(response.statusCode);
//     response.stream.transform(utf8.decoder).listen((value) {
//       print(value);
//     });
//   }

//   // Upload camera photo to server
//   Future uploadImage1() async {
//     HttpOverrides.global = MyHttpOverrides();
//     try {
//       final uri = Uri.parse("https://192.168.1.13:3000/api/Image");
//       //http.post(uri);
//       var request = http.MultipartRequest('POST', uri);
//       var takenPicture =
//           await http.MultipartFile.fromPath("image", pickFile!.path);
//       request.files.add(takenPicture);

//       var response = await request.send();
//       if (response.statusCode == 200) {
//         print('Image uploaded!');
//       } else {
//         print('Image not uploaded');
//         print('${response.statusCode}');
//         //print('${response.statusCode}');

//         //response.statusCode == 200
//       }
//     } catch (e) {
//       print('Image uploaded! $e');
//     }
//   }

// //String title,
//   Future<void> uploadImage(File file) async {
//     HttpOverrides.global = MyHttpOverrides();
//     try {
//       var request = http.MultipartRequest(
//         "POST",
//         Uri.parse("https://192.168.1.13:3000/api/Image"),
//       );

//       //request.fields['title'] = "dummyImage";
//       request.headers['contentTypeHeader'] = "application/json";
//       //  HttpHeaders.contentTypeHeader: 'application/json',

//       var picture = http.MultipartFile.fromBytes('image',
//           (await rootBundle.load('assets/logo.png')).buffer.asUint8List(),
//           filename: 'logo.png');

//       request.files.add(picture);

//       var response = await request.send();

//       if (response.statusCode == 200) {
//         var responseData = await response.stream.toBytes();

//         var result = String.fromCharCodes(responseData);
//       } else {
//         print(response.statusCode);
//         print(response);
//       }

//       //print(result);
//     } catch (error) {
//       print(error);
//     }
//   }

//   Future<void> asyncFileUpload(String text, File file) async {
//     try {
//       //create multipart request for POST or PATCH method
//       var request = http.MultipartRequest(
//           "POST", Uri.parse("https://192.168.1.13:3000/api/Image"));
//       //add text fields
//       request.fields["text_field"] = text;
//       //create multipart using filepath, string or bytes
//       var pic = await http.MultipartFile.fromPath("file_field", file.path);
//       //add multipart to request
//       request.files.add(pic);
//       var response = await request.send();
//       if (response.statusCode == 200) {
//         //Get the response from the server
//         var responseData = await response.stream.toBytes();
//         var responseString = String.fromCharCodes(responseData);
//         print(responseString);
//         print('Image uploaded!');
//       } else {
//         print('Image not uploaded');
//         print('${response.statusCode}');
//       }
//     } catch (error) {
//       print(error);
//     }
//   }

//   Future<String> up(String filePath) async {
//     HttpOverrides.global = MyHttpOverrides();

//     try {
//       //create multipart request for POST or PATCH method
//       var request = http.MultipartRequest(
//           "POST", Uri.parse("https://192.168.1.13:3000/api/Upload"));
//       //add text fields
//       //create multipart using filepath, string or bytes
//       var pic = await http.MultipartFile.fromPath("file_field", filePath);
//       request.files.add(pic);
//       var headers = {"content-type": "multipart/from-data"};
//       request.headers.addAll(headers);

//       var response = await request.send();
//       if (response.statusCode == 200) {
//         final resp = response.stream.bytesToString();

//         print('Image uploaded!');
//         return resp;
//       } else {
//         print('Image not uploaded');
//         print('${response.statusCode}');
//         return '  ';
//       }
//     } catch (error) {
//       print(error);
//       return '';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Image Upload'),
//         ),
//         body: Center(
//           child: Column(
//             children: [
//               Column(
//                 children: [
//                   SizedBox(height: 60),
//                   imageFile != null
//                       ? Container(
//                           height: 300,
//                           width: double.infinity,
//                           child: Image.file(imageFile!),
//                         )
//                       : Container(
//                           width: size.width * .6,
//                           height: 100,
//                           child: Icon(
//                             Icons.image,
//                             size: 50,
//                           ),
//                         ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: ElevatedButton(
//                         onPressed: () {
//                           getImage();
//                         },
//                         child: Text('Pick Image')),
//                   )
//                 ],
//               ),
//               Container(
//                 child: TextButton(
//                   onPressed: () {
//                     print('imageFile :$imageFile');
//                     //asyncFileUpload("text", imageFile!);
//                     up(imageFile!.path);
//                     // uploadImage1();
//                     // Upload(File('assets/logo.png'));
//                   },
//                   child: Text('Upload'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
