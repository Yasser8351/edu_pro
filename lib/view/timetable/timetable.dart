import 'package:edu_pro/view/timetable/exame_timetable.dart';
import 'package:edu_pro/view/timetable/lecture_timetable.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class Timetable extends StatelessWidget {
  const Timetable({Key? key}) : super(key: key);
  static const routeName = 'timetable';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Timetable',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Home.routeName, (route) => false);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
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
                      Navigator.of(context)
                          .pushNamed(LectureTimetable.routeName);
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
                                color: Theme.of(context).colorScheme.secondary),
                            const SizedBox(height: 15),
                            Text(
                              'Lecture Timetable',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(ExameTimetable.routeName);
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
                            Icon(Icons.paste_rounded,
                                size: 60,
                                color: Theme.of(context).colorScheme.secondary),
                            const SizedBox(height: 15),
                            Text(
                              'Exame Timetable',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
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
