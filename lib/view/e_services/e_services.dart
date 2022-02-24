import 'package:edu_pro/view/e_services/show_e_services.dart';
import 'package:edu_pro/widget/app_drawer.dart';
import 'package:flutter/material.dart';

import 'final.dart';
import 'image.dart';
import 'steper.dart';
import 'upload_image.dart';

class EServices extends StatefulWidget {
  const EServices({Key? key}) : super(key: key);
  static const routeName = "EServices";

  @override
  _EServicesState createState() => _EServicesState();
}

class _EServicesState extends State<EServices> {
  @override
  Widget build(BuildContext context) {    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'E-Services',
          style: TextStyle(color: Colors.white),
        ),
        // leading: IconButton(
        //   onPressed: () {
        //     // Navigator.of(context).pushReplacement(EServices.routeName);
        //   },
        //   icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        // ),
      ),
      drawer: AppDrawer(),
      body: Container(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(ShowEServices.routeName);
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
                            Icon(Icons.view_agenda_outlined,
                                size: 60,
                                color: Theme.of(context).colorScheme.primary),
                            const SizedBox(height: 15),
                            Text(
                              'Show E-Services',
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => Steper())); //UploadImage
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
                            Icon(Icons.add_task_sharp,
                                size: 60,
                                color: Theme.of(context).colorScheme.primary),
                            const SizedBox(height: 15),
                            Text(
                              'Add Request',
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
