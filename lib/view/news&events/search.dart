import 'package:edu_pro/view/news&events/news_search.dart';
import 'package:flutter/material.dart';

class SearchNews extends StatefulWidget {
  const SearchNews({Key? key}) : super(key: key);
  static const routeName = 'search_event';

  @override
  State<SearchNews> createState() => _SearchNewsState();
}

class _SearchNewsState extends State<SearchNews> {
  double? sizeBetweenFeiled = 10.0;

  DateTime date = DateTime.now();
  Future<Null> selectTimePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (picked == null) {
      return;
    }
    setState(() {
      date = picked;
    });
    // ignore: unnecessary_null_comparison
    if (picked == null && picked == date) {
      setState(() {
        date = picked;
      });
    }
  }

  DateTime date2 = DateTime.now();
  Future<Null> selectTimePicker2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date2,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (picked == null) {
      return;
    }
    setState(() {
      date2 = picked;
    });
    // ignore: unnecessary_null_comparison
    if (picked == null && picked == date2) {
      setState(() {
        date2 = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          'Search News & Events',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: sizeBetweenFeiled),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Date From :',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(width: size.height / 10),
                      TextButton(
                        onPressed: () {
                          selectTimePicker(context);
                        },
                        child: Text(
                          "${date.day.toString()}-" +
                              "${date.month.toString()}-" +
                              "${date.year.toString()}",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      TextButton.icon(
                          onPressed: () {
                            selectTimePicker(context);
                          },
                          icon: Icon(Icons.date_range, size: 25),
                          label: Text('')),
                    ],
                  ),
                  SizedBox(height: sizeBetweenFeiled),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Date To :     ',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: size.height / 10),
                      TextButton(
                        onPressed: () {
                          selectTimePicker2(context);
                        },
                        child: Text(
                            "${date2.day.toString()}-" +
                                "${date2.month.toString()}-" +
                                "${date2.year.toString()}",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary)),
                      ),
                      TextButton.icon(
                          onPressed: () {
                            selectTimePicker2(context);
                          },
                          icon: Icon(Icons.date_range, size: 25),
                          label: Text('')),
                    ],
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (ctx) => NewsSearch(
                                  dateFrom: date.toIso8601String(),
                                  dateTo: date2.toIso8601String(),
                                )),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.primary),
                      child: const Text(
                        'Search',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
