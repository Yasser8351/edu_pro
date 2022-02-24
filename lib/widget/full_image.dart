import 'dart:convert';

import 'package:flutter/material.dart';

class FullImage extends StatelessWidget {
  const FullImage({Key? key, this.image}) : super(key: key);

  final image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        width: double.infinity,
        height: double.infinity,
        child: Image.memory(
          base64Decode(image),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
