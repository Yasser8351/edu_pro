import 'package:edu_pro/widget/app_drawer.dart';
import 'package:flutter/material.dart';

class StaffDirectory extends StatefulWidget {
  const StaffDirectory({Key? key}) : super(key: key);
  static const routeName = 'staffDirectory';

  @override
  State<StaffDirectory> createState() => _StaffDirectoryState();
}

class _StaffDirectoryState extends State<StaffDirectory> {
  bool isSelectedFaculty = false;
  String? _valueFaculty = 'Faculty of Medicine';
  final _itemsFaculty = [
    'Faculty of Medicine',
    'Faculty of Pharmacy',
    'Faculty of Dentistry',
    'Faculty of Medical Laboratory Sciences',
    'Faculty of Radiological Sciences',
    'Faculty of Nursing Sciences',
    'Faculty of Engineering Department of Biomedical',
    'Faculty of Business Administration',
    'School of Dental Technology',
    'Faculty of Anaesthesia',
    'Faculty of Engineering Department of Electronic',
  ];
  bool isSelectedDepartment = false;
  String? _valueDepartment = 'Department 1';
  final _itemsDepartment = [
    'Department 1',
    'Department 2',
    'Department 3',
    'Department 4',
    'Department 5',
  ];
  bool isSelectedName = false;
  String? _valueName = 'Yasser Abubaker';
  final _itemsName = [
    'Yasser Abubaker',
    'Ahmed Ali',
    'Omer Alsir',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Search Staff',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: AppDrawer(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: isSelectedFaculty
                        ? Theme.of(context).colorScheme.primary
                        : Colors.black38,
                    width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text("Select Faculty"),
                    style: TextStyle(
                        color: isSelectedFaculty
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey[700]),
                    value: _valueFaculty,
                    isExpanded: true,
                    iconSize: 28,
                    icon: Icon(Icons.arrow_drop_down,
                        color: isSelectedFaculty
                            ? Theme.of(context).colorScheme.primary
                            : Colors.black38),
                    items: _itemsFaculty
                        .map((String item) => DropdownMenuItem<String>(
                            child: Text(item), value: item))
                        .toList(),
                    onChanged: (value) => setState(() {
                      isSelectedFaculty = true;
                      this._valueFaculty = value.toString();
                    }),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: isSelectedDepartment
                        ? Theme.of(context).colorScheme.primary
                        : Colors.black38,
                    width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text("Select Department"),
                    style: TextStyle(
                        color: isSelectedDepartment
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey[700]),
                    value: _valueDepartment,
                    isExpanded: true,
                    iconSize: 28,
                    icon: Icon(Icons.arrow_drop_down,
                        color: isSelectedDepartment
                            ? Theme.of(context).colorScheme.primary
                            : Colors.black38),
                    items: _itemsDepartment
                        .map((String item) => DropdownMenuItem<String>(
                            child: Text(item), value: item))
                        .toList(),
                    onChanged: (value) => setState(() {
                      isSelectedDepartment = true;
                      this._valueDepartment = value.toString();
                    }),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: isSelectedName
                        ? Theme.of(context).colorScheme.primary
                        : Colors.black38,
                    width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text("Select Name"),
                    style: TextStyle(
                        color: isSelectedName
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey[700]),
                    value: _valueName,
                    isExpanded: true,
                    iconSize: 28,
                    icon: Icon(Icons.arrow_drop_down,
                        color: isSelectedName
                            ? Theme.of(context).colorScheme.primary
                            : Colors.black38),
                    items: _itemsName
                        .map((String item) => DropdownMenuItem<String>(
                            child: Text(item), value: item))
                        .toList(),
                    onChanged: (value) => setState(() {
                      isSelectedName = true;
                      this._valueName = value.toString();
                    }),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: Colors.blue,
                  color: Theme.of(context).colorScheme.primary),
              child: TextButton(
                child: const Text(
                  'Search',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                onPressed: () {
                  //Navigator.of(context).pushNamed(Home.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
