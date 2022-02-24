//EventsMore
import 'package:edu_pro/view/news&events/news&events.dart';
import 'package:flutter/material.dart';

class EventsMore extends StatefulWidget {
  const EventsMore(
      {Key? key,
      this.facultyName,
      this.specializationName,
      this.programNameEn,
      this.batchName,
      this.newsAndEventsTypeName,
      this.activityTimeFrom,
      this.activityTimeTo,
      this.newsAndEventsDescription,
      this.newsAndEventsType})
      : super(key: key);
  static const routeName = "events_more";
  final facultyName;
  final specializationName;
  final programNameEn;
  final batchName;
  final newsAndEventsTypeName;
  final activityTimeFrom;
  final activityTimeTo;
  final newsAndEventsDescription;
  final newsAndEventsType;

  @override
  State<EventsMore> createState() => _EventsMoreState();
}

class _EventsMoreState extends State<EventsMore> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'More Details',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        width: double.infinity,
        height: size.height / 1.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            shadowColor: Colors.grey,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    title: Text(
                      'Faculty',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    trailing: Text(
                      '${widget.facultyName}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Specialization',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    trailing: Text(
                      '${widget.specializationName}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Program',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    trailing: Text(
                      '${widget.programNameEn}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Batch',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    trailing: Text(
                      '${widget.batchName}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Type',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    trailing: Text(
                      '${widget.newsAndEventsTypeName}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'From',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    trailing: Text(
                      '${widget.activityTimeFrom}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'To',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    trailing: Text(
                      '${widget.activityTimeTo}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Description',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    trailing: Text(
                      '${widget.newsAndEventsDescription}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
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
