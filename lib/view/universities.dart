import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/view/login_home.dart';
import 'package:flutter/material.dart';

class Universities extends StatefulWidget {
  const Universities({Key? key}) : super(key: key);
  static const routeName = "Universities";

  @override
  State<Universities> createState() => _UniversitiesState();
}

class _UniversitiesState extends State<Universities> {
  var api = Api();

  @override
  void initState() {
    super.initState();
    print('object');
    api.getUniversities();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //umst = 1
                //national  = 2
                //neelain = 3
                //bannaga = 4
                //safwa = 5
                //ibnsina = 6
                //uofk = 7
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      'Select The University',
                      style: TextStyle(color: Colors.black45, fontSize: 18),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 10,
                      child: Container(
                        height: size.height / 7,
                        width: size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Ink(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => LoginHome(
                                        UniversitiesName: 'umst',
                                        UniversitiesId: 1,
                                      )));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Image.asset(
                                'assets/umst.png',
                                height: 100,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: Container(
                        height: size.height / 7,
                        width: size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Ink(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => LoginHome(
                                      UniversitiesName: 'national',
                                      UniversitiesId: 2)));
                            },
                            child: Image.asset(
                              'assets/national.png',
                              height: 100,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 10,
                      child: Container(
                        height: size.height / 7,
                        width: size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Ink(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => LoginHome(
                                        UniversitiesName: 'neelain',
                                        UniversitiesId: 3,
                                      )));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Image.asset(
                                'assets/neelain.png',
                                height: 100,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: Container(
                        height: size.height / 7,
                        width: size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Ink(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => LoginHome(
                                      UniversitiesName: 'bannaga',
                                      UniversitiesId: 4)));
                            },
                            child: Image.asset(
                              'assets/bannaga.png',
                              height: 100,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 10,
                      child: Container(
                        height: size.height / 7,
                        width: size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Ink(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => LoginHome(
                                      UniversitiesName: 'safwa',
                                      UniversitiesId: 5)));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Image.asset(
                                'assets/safwa.png',
                                height: 100,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: Container(
                        height: size.height / 7,
                        width: size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Ink(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => LoginHome(
                                      UniversitiesName: 'ibnsina',
                                      UniversitiesId: 6)));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Image.asset(
                                'assets/ibnsina.png',
                                height: 100,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 10,
                      child: Container(
                        height: size.height / 7,
                        width: size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Ink(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => LoginHome(
                                      UniversitiesName: 'uofk',
                                      UniversitiesId: 7)));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Image.asset(
                                'assets/uofk.png',
                                height: 100,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: size.height / 7,
                      width: size.width / 3,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
