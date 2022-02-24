//AddRequest
import 'package:flutter/material.dart';

import 'e_services.dart';

class AddRequest extends StatefulWidget {
  const AddRequest({Key? key}) : super(key: key);
  static const routeName = "AddRequest";

  @override
  _AddRequestState createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(
        'New Request',
        style: TextStyle(color: Colors.white),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(EServices.routeName);
        },
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
      ),
    ));
  }
}
