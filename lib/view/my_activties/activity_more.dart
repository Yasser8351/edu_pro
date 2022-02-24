import 'package:edu_pro/view/my_activties/activities.dart';
import 'package:edu_pro/view/my_activties/coming.dart';
import 'package:flutter/material.dart';

class ActivityMore extends StatefulWidget {
  const ActivityMore(
      {Key? key,
      this.facultyName,
      this.specializationName,
      this.programNameEn,
      this.batchName,
      this.newsAndActivityTypeName,
      this.activityTimeFrom,
      this.activityTimeTo,
      this.newsAndActivityDescription})
      : super(key: key);
  static const routeName = "Activity_more";
  final facultyName;
  final specializationName;
  final programNameEn;
  final batchName;
  final newsAndActivityTypeName;
  final activityTimeFrom;
  final activityTimeTo;

  final newsAndActivityDescription;

  @override
  State<ActivityMore> createState() => _ActivityMoreState();
}

class _ActivityMoreState extends State<ActivityMore> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'More Details ',
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
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    trailing: Text(
                      '${widget.facultyName}',
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.secondaryVariant),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Specialization',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    trailing: Text(
                      '${widget.specializationName}',
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.secondaryVariant),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Program',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    trailing: Text(
                      '${widget.programNameEn}',
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.secondaryVariant),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Batch',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    trailing: Text(
                      '${widget.batchName}',
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.secondaryVariant),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Type',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    trailing: Text(
                      '${widget.newsAndActivityTypeName}',
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.secondaryVariant),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'From',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    trailing: Text(
                      '${widget.activityTimeFrom}',
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.secondaryVariant),
                    ),
                  ),

                  ListTile(
                    title: Text(
                      'To',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    trailing: Text(
                      '${widget.activityTimeTo}',
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.secondaryVariant),
                    ),
                  ),

                  ListTile(
                    title: Text(
                      'Description',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    trailing: Text(
                      '${widget.newsAndActivityDescription}',
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.secondaryVariant),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'Faculty',
                  //       style: TextStyle(
                  //           color: Theme.of(context).colorScheme.primary,
                  //           fontSize: 12),
                  //     ),
                  //     Text(
                  //       '  :  ',
                  //       style: TextStyle(
                  //           overflow: TextOverflow.ellipsis,
                  //           color: Theme.of(context).colorScheme.onSurface,
                  //           fontSize: 14),
                  //     ),
                  //     Text(
                  //       '${widget.facultyName}',
                  //       style: TextStyle(
                  //           overflow: TextOverflow.ellipsis,
                  //           color: Theme.of(context).colorScheme.onSurface,
                  //           fontSize: 14),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'Specialiaztion',
                  //       style: TextStyle(
                  //           color: Theme.of(context).colorScheme.primary,
                  //           fontSize: 12),
                  //     ),
                  //     Text(
                  //       '  :  ',
                  //       style: TextStyle(
                  //           overflow: TextOverflow.ellipsis,
                  //           color: Theme.of(context).colorScheme.onSurface,
                  //           fontSize: 14),
                  //     ),
                  //     Text(
                  //       '${widget.specializationName}',
                  //       style: TextStyle(
                  //           overflow: TextOverflow.ellipsis,
                  //           color: Theme.of(context).colorScheme.onSurface,
                  //           fontSize: 14),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'Program ',
                  //       style: TextStyle(
                  //           color: Theme.of(context).colorScheme.primary,
                  //           fontSize: 12),
                  //     ),
                  //     Text(
                  //       '  :  ',
                  //       style: TextStyle(
                  //           overflow: TextOverflow.ellipsis,
                  //           color: Theme.of(context).colorScheme.onSurface,
                  //           fontSize: 14),
                  //     ),
                  //     Text(
                  //       '${widget.programNameEn}',
                  //       style: TextStyle(
                  //           overflow: TextOverflow.ellipsis,
                  //           color: Theme.of(context).colorScheme.onSurface,
                  //           fontSize: 14),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'Batch',
                  //       style: TextStyle(
                  //           color: Theme.of(context).colorScheme.primary,
                  //           fontSize: 12),
                  //     ),
                  //     Text(
                  //       '  :  ',
                  //       style: TextStyle(
                  //           overflow: TextOverflow.ellipsis,
                  //           color: Theme.of(context).colorScheme.onSurface,
                  //           fontSize: 14),
                  //     ),
                  //     Text(
                  //       '${widget.batchName}',
                  //       style: TextStyle(
                  //           overflow: TextOverflow.ellipsis,
                  //           color: Theme.of(context).colorScheme.onSurface,
                  //           fontSize: 14),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'Type',
                  //       style: TextStyle(
                  //           color: Theme.of(context).colorScheme.primary,
                  //           fontSize: 12),
                  //     ),
                  //     Text(
                  //       '  :  ',
                  //       style: TextStyle(
                  //           overflow: TextOverflow.ellipsis,
                  //           color: Theme.of(context).colorScheme.onSurface,
                  //           fontSize: 14),
                  //     ),
                  //     Text(
                  //       '${widget.newsAndActivityTypeName}',
                  //       style: TextStyle(
                  //           overflow: TextOverflow.ellipsis,
                  //           color: Theme.of(context).colorScheme.onSurface,
                  //           fontSize: 14),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'From',
                  //       style: TextStyle(
                  //           color: Theme.of(context).colorScheme.primary,
                  //           fontSize: 12),
                  //     ),
                  //     Text(
                  //       '  :  ',
                  //       style: TextStyle(
                  //           overflow: TextOverflow.ellipsis,
                  //           color: Theme.of(context).colorScheme.onSurface,
                  //           fontSize: 14),
                  //     ),
                  //     Text(
                  //       '${widget.activityTimeFrom}',
                  //       style: TextStyle(
                  //           overflow: TextOverflow.ellipsis,
                  //           color: Theme.of(context).colorScheme.onSurface,
                  //           fontSize: 14),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'To',
                  //       style: TextStyle(
                  //           color: Theme.of(context).colorScheme.primary,
                  //           fontSize: 12),
                  //     ),
                  //     Text(
                  //       '  :  ',
                  //       style: TextStyle(
                  //           overflow: TextOverflow.ellipsis,
                  //           color: Theme.of(context).colorScheme.onSurface,
                  //           fontSize: 14),
                  //     ),
                  //     Text(
                  //       '${widget.activityTimeTo}',
                  //       style: TextStyle(
                  //           overflow: TextOverflow.ellipsis,
                  //           color: Theme.of(context).colorScheme.onSurface,
                  //           fontSize: 14),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'Description',
                  //       style: TextStyle(
                  //           color: Theme.of(context).colorScheme.primary,
                  //           fontSize: 12),
                  //     ),
                  //     Text(
                  //       '  :  ',
                  //       style: TextStyle(
                  //           overflow: TextOverflow.ellipsis,
                  //           color: Theme.of(context).colorScheme.onSurface,
                  //           fontSize: 14),
                  //     ),
                  //     Text(
                  //       '${widget.newsAndActivityDescription}',
                  //       maxLines: 22,
                  //       textScaleFactor: .9,
                  //       overflow: TextOverflow.ellipsis,
                  //       style: TextStyle(
                  //           overflow: TextOverflow.ellipsis,
                  //           color: Theme.of(context).colorScheme.onSurface,
                  //           fontSize: 14),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
