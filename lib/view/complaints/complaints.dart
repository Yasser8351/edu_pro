import 'package:edu_pro/view/complaints/report_complaints.dart';
import 'package:edu_pro/widget/app_drawer.dart';
import 'package:flutter/material.dart';

import '../home.dart';
import 'my_complaints.dart';

class Complaints extends StatelessWidget {
  const Complaints({Key? key}) : super(key: key);
  static const routeName = 'complaints';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Complaints',
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
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add),
            label: Text("Add Complaints"),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ReportComplaints.routeName);
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        shadowColor: Colors.grey,
                        elevation: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.grading,
                                size: 60,
                                color: Theme.of(context).colorScheme.primary),
                            const SizedBox(height: 15),
                            Text(
                              'Report Complaints',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(MyComplaints.routeName);
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        shadowColor: Colors.grey,
                        elevation: 10,
                        //color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.my_library_books_outlined,
                                size: 60,
                                color: Theme.of(context).colorScheme.primary),
                            const SizedBox(height: 15),
                            Text(
                              'My Complaints',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
