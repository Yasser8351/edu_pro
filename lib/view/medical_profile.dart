// import 'package:edu_pro/widget/app_drawer.dart';
// import 'package:flutter/material.dart';

// class MedicalProfile extends StatelessWidget {
//   const MedicalProfile({Key? key}) : super(key: key);
//   static const routeName = 'medicalProfile';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(
//           'Medical Profile',
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ),
//       drawer: AppDrawer(),
//       body: Container(
//         child: Container(
//           height: 50.0,
//           width: double.infinity,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               // color: Colors.blue,
//               color: Theme.of(context).colorScheme.primary),
//           child: const Text(
//             'Medical Report',
//             style: TextStyle(color: Colors.white, fontSize: 18.0),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:math';

import 'package:edu_pro/widget/app_drawer.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class MedicalProfile extends StatefulWidget {
  static const routeName = 'medicalProfile';
  @override
  _MedicalProfileState createState() => _MedicalProfileState();
}

class _MedicalProfileState extends State<MedicalProfile> {
  var _expand = true;
  var _expand2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Medical Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(Home.routeName);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      drawer: AppDrawer(),
      body: Container(
          child: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _expand ? min(300 * 20.0 + 110, 140) : 105,
            child: Card(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Medical Profile",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                              _expand ? Icons.expand_less : Icons.expand_more,
                              color: _expand
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.black38),
                          onPressed: () {
                            setState(() {
                              _expand = !_expand;
                              //_expand = true;
                            });
                          },
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        height: min(10 * 20.0 + 10, 29),
                        child: Text(
                          _expand ? "No Data to show!" : "",
                          //"No Data to show!",
                          //textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _expand2 ? min(300 * 20.0 + 110, 140) : 105,
            child: Card(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Medical Report",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                              _expand2 ? Icons.expand_less : Icons.expand_more,
                              color: _expand2
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.black38),
                          onPressed: () {
                            setState(() {
                              _expand2 = !_expand2;
                              //_expand = true;
                            });
                          },
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        height: min(10 * 20.0 + 10, 29),
                        child: Text(
                          _expand2 ? "No Data to show!" : "",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
