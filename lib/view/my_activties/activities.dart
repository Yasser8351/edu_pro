import 'package:edu_pro/view/my_activties/search.dart';
import 'package:edu_pro/widget/app_drawer.dart';
import 'package:flutter/material.dart';

import '../home.dart';
import 'coming.dart';
import 'current.dart';

class Activities extends StatelessWidget {
  const Activities({Key? key}) : super(key: key);
  static const routeName = "Activities";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Activities',
          style: TextStyle(color: Colors.white),
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
                          .pushNamed(CurrentActivities.routeName);
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
                            Icon(Icons.calendar_today_outlined,
                                size: 60,
                                color: Theme.of(context).colorScheme.primary),
                            const SizedBox(height: 15),
                            Text(
                              'Current',
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
                          .pushNamed(ComingActivities.routeName);
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
                            Icon(Icons.calendar_today,
                                size: 60,
                                color: Theme.of(context).colorScheme.primary),
                            const SizedBox(height: 15),
                            Text(
                              'Coming',
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(SearchActivities.routeName);
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
                            Icon(Icons.search_sharp,
                                size: 60,
                                color: Theme.of(context).colorScheme.primary),
                            const SizedBox(height: 15),
                            Text(
                              'Search',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 150,
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
