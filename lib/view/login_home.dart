import 'package:edu_pro/services/api.dart';
import 'package:edu_pro/sharepref/user_share_pref.dart';
import 'package:edu_pro/view/home.dart';
import 'package:edu_pro/view/universities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginHome extends StatefulWidget {
  const LoginHome(
      {Key? key,
      this.UniversitiesName,
      this.UniversitiesId,
      this.UniversityURL})
      : super(key: key);
  static const routeName = 'LoginHome';
  final UniversitiesName;
  final UniversitiesId;
  final UniversityURL;

  @override
  _LoginHomeState createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  var api = Api();

  final _form = GlobalKey<FormState>();
  final _passwordFocus = FocusNode();

  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isLoadingLogin = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    print("UniversityURL ${widget.UniversityURL}");
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    api.data;

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                height: size.height,
                color: Colors.white,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 23, bottom: 0),
                        child: Card(
                          elevation: 10,
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(Universities.routeName);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.black54,
                              )),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 4),
                            child: Column(
                              children: [
                                Image.network(
                                  '${widget.UniversitiesName}',
                                  height: 120,
                                ),
                                //SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'EDU.',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontFamily: '',
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'PRO',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 30),
                                    Form(
                                      key: _form,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            textAlign: TextAlign.left,
                                            controller: _userNameController,
                                            decoration: InputDecoration(
                                                prefixIcon: Icon(Icons.email),
                                                labelText: 'Email',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                )),
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            onFieldSubmitted: (_) {
                                              FocusScope.of(context)
                                                  .requestFocus(_passwordFocus);
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter the email';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {},
                                          ),
                                          const SizedBox(height: 20.0),
                                          TextFormField(
                                            textAlign: TextAlign.left,
                                            controller: _passwordController,
                                            obscureText: _obscureText,
                                            focusNode: _passwordFocus,
                                            decoration: InputDecoration(
                                                labelText: 'Password',
                                                suffixIcon: InkWell(
                                                    onTap: _toggle,
                                                    child: _obscureText
                                                        ? Container(
                                                            width: 1,
                                                            height: 1,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/eye_visible.svg',
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary,
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            width: 1,
                                                            height: 1,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/eye_hide.svg',
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )),
                                                prefixIcon: Icon(
                                                    Icons.lock_clock_rounded),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                )),
                                            textInputAction:
                                                TextInputAction.done,
                                            keyboardType: TextInputType.text,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter the password';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {},
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    Container(
                                      height: 50.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      child: TextButton(
                                        child: _isLoadingLogin
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: Colors.white))
                                            : Text(
                                                'Login',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.0),
                                              ),
                                        onPressed: () {
                                          final isValid =
                                              _form.currentState!.validate();
                                          if (!isValid) {
                                            return null;
                                          }
                                          _form.currentState!.save();
                                          setState(() {
                                            _isLoadingLogin = true;
                                          });

                                          var responseData = api.responseData;

                                          api
                                              .login(
                                            widget.UniversityURL,
                                            _userNameController.text.toString(),
                                            _passwordController.text.toString(),
                                          )
                                              .then((value) {
                                            api.data;
                                            setState(
                                              () {
                                                _isLoadingLogin = false;
                                              },
                                            );

                                            if (value) {
                                              SharedPrefUser().login();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                duration: Duration(seconds: 1),
                                                content:
                                                    Text("login successfully"),
                                                backgroundColor: Colors.green,
                                              ));

                                              SharedPrefUser()
                                                  .saveUniversityURL(
                                                      widget.UniversityURL);
                                              api.getCurriculum();
                                              SharedPrefUser()
                                                  .saveUser(api.data)
                                                  .then((value) => {});

                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              Home(
                                                                userName:
                                                                    "${api.data['token']}",
                                                                //"${api.data['userInfo'][firstName]}",
                                                              )));
                                            } else {
                                              print(
                                                  "api.isServerError ${api.isServerError}");
                                              if (api.isServerError) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        "server error ,please try again later"),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        "incorrect username or password"),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              }
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
