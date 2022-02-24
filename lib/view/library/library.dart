import 'package:edu_pro/widget/app_drawer.dart';
import 'package:flutter/material.dart';

import '../home.dart';
import 'borrowed_library.dart';
import 'digital_library.dart';

class Library extends StatelessWidget {
  const Library({Key? key}) : super(key: key);
  static const routeName = 'library';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Library',
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
                      Navigator.of(context).pushNamed(DigitalLibrary.routeName);
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
                              'Digital Library',
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
                      Navigator.of(context)
                          .pushNamed(BorrowedLibrary.routeName);
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
                            Icon(Icons.plagiarism_rounded,
                                size: 60,
                                color: Theme.of(context).colorScheme.primary),
                            const SizedBox(height: 15),
                            Text(
                              'My Borrowed Books',
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
