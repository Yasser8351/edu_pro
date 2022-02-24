import 'package:edu_pro/view/home.dart';
import 'package:edu_pro/widget/app_drawer.dart';
import 'package:flutter/material.dart';

import 'coming.dart';
import 'current.dart';
import 'search.dart';

class News extends StatelessWidget {
  const News({Key? key}) : super(key: key);
  static const routeName = "news";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News & Events',
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
                      Navigator.of(context).pushNamed(CurrentNews.routeName);
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
                      Navigator.of(context).pushNamed(ComingNews.routeName);
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
                      Navigator.of(context).pushNamed(SearchNews.routeName);
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
