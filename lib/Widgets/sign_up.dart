import 'package:flutter/material.dart';
import 'package:hello_rectangle/Models/user_model.dart';

import '../Utilities/globals.dart';
import '../Pages/home_page.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => new _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  User newUser = User();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidate: _autoValidate,
      child: signUpPage(),
    );
  }

  Widget signUpPage() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 1.6,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.05), BlendMode.dstATop),
                  image:
                      AssetImage('assets/images/login-signup-background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: new Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(100.0),
                    child: Center(
                      child: Icon(
                        Icons.directions_boat,
                        color: Colors.blueAccent,
                        size: 50.0,
                      ),
                    ),
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: new Text(
                            "FIRST NAME",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              enabledBorder: new UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 0.8,
                                    style: BorderStyle.solid),
                              ),
                            ),
                            validator: (input) {
                              _autoValidate = false;
                              if (input.isEmpty) {
                                _autoValidate = true;
                                return 'First name is not filled in';
                              }
                              newUser.firstName = input;
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.only(left: 40.0, top: 25.0),
                          child: new Text(
                            "LAST NAME",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              enabledBorder: new UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 0.8,
                                    style: BorderStyle.solid),
                              ),
                            ),
                            validator: (input) {
                              _autoValidate = false;
                              if (input.isEmpty) {
                                _autoValidate = true;
                                return 'Last name is not filled in';
                              }
                              newUser.lastName = input;
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.only(left: 40.0, top: 25.0),
                          child: new Text(
                            "PHONE NUMBER",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              enabledBorder: new UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 0.8,
                                    style: BorderStyle.solid),
                              ),
                            ),
                            validator: (input) {
                              _autoValidate = false;
                              if (input.isEmpty) {
                                _autoValidate = true;
                                return 'Phone number is not filled in';
                              } else if (!RegExp(r"(^\+[0-9]{2}|^\+[0-9]{2}\(0\)|^\(\+[0-9]{2}\)\(0\)|^00[0-9]{2}|^0)([0-9]{9}$|[0-9\-\s]{9}$)")
                                  .hasMatch(input)) {
                                _autoValidate = true;
                                return 'Phone number is not valid';
                              }
                              newUser.phoneNumber = input;
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.only(left: 40.0, top: 25.0),
                          child: new Text(
                            "EMAIL",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              enabledBorder: new UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 0.8,
                                    style: BorderStyle.solid),
                              ),
                            ),
                            validator: (input) {
                              _autoValidate = false;
                              if (input.isEmpty) {
                                _autoValidate = true;
                                return 'Email is not filled in';
                              } else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(input)) {
                                _autoValidate = true;
                                return 'Email is not valid';
                              }
                              newUser.email = input;
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 24.0,
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: new Text(
                            "PASSWORD",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              enabledBorder: new UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 0.8,
                                    style: BorderStyle.solid),
                              ),
                            ),
                            obscureText: true,
                            validator: (input) {
                              _autoValidate = false;
                              if (input.isEmpty) {
                                _autoValidate = true;
                                return 'Password is not filled in';
                              }
                              newUser.password = input;
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 24.0,
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: new Text(
                            "CONFIRM PASSWORD",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              enabledBorder: new UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 0.8,
                                    style: BorderStyle.solid),
                              ),
                            ),
                            obscureText: true,
                            validator: (input) {
                              _autoValidate = false;
                              if (input.isEmpty || input != newUser.password) {
                                _autoValidate = true;
                                return 'Password does not match';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 24.0,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: new FlatButton(
                          child: new Text(
                            "Already have an account?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                              fontSize: 15.0,
                            ),
                            textAlign: TextAlign.end,
                          ),
                          onPressed: () => {},
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 50.0),
                    alignment: Alignment.center,
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new FlatButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: Colors.blueAccent,
                            onPressed: () {
                              // Make an api call to the back end to store the new account in the database
                              if (formKey.currentState.validate()) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                );
                              }
                            },
                            child: new Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 20.0,
                              ),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Expanded(
                                    child: Text(
                                      "SIGN UP",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
