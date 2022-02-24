// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// //import http package manually

// class ImageUpload extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _ImageUpload();
//   }
// }

// class _ImageUpload extends State<ImageUpload> {
//   File? imageFile;
//   XFile? pickFile;

//   Future<void> getImage() async {
//     pickFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     setState(() {
//       imageFile = File(pickFile!.path);
//     });
//     print('${imageFile}');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Upload Image to Server"),
//         backgroundColor: Colors.deepOrangeAccent,
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: 60),
//           imageFile != null
//               ? Container(
//                   height: 300,
//                   width: double.infinity,
//                   child: Image.file(imageFile!),
//                 )
//               : Container(
//                   width: size.width * .6,
//                   height: 100,
//                   child: Icon(
//                     Icons.image,
//                     size: 50,
//                   ),
//                 ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ElevatedButton(
//                 onPressed: () {
//                   getImage();
//                 },
//                 child: Text('Pick Image')),
//           )
//         ],
//       ),
//     );
//   }
// }
