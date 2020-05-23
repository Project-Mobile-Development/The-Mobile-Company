import 'package:flutter/material.dart';
import 'package:hello_rectangle/Models/user_model.dart';

import '../Utilities/globals.dart';
import '../Pages/home_page_OLD.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => new _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  User existingUser = User();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidate: _autoValidate,
      child: signInPage(),
    );
  }

  Widget signInPage() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
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
                    padding: EdgeInsets.only(
                        left: 120.0,
                        top: 95.0,
                        right: 120.0,
                        bottom: (MediaQuery.of(context).size.height / 10) - 15),
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
                              existingUser.email = input;
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
                              existingUser.password = input;
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
                            "Forgot Password?",
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
                        left: 30.0, right: 30.0, top: 20.0),
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
                              // Make an api call to the back end to see if the if the user logs in with an existing account from the database
                              if (formKey.currentState.validate()) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreenOLD()),
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
                                      "LOGIN",
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
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 20.0),
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            margin: EdgeInsets.all(8.0),
                            decoration:
                                BoxDecoration(border: Border.all(width: 0.25)),
                          ),
                        ),
                        Text(
                          "OR CONNECT WITH",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        new Expanded(
                          child: new Container(
                            margin: EdgeInsets.all(8.0),
                            decoration:
                                BoxDecoration(border: Border.all(width: 0.25)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 20.0),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            margin: EdgeInsets.only(right: 8.0),
                            alignment: Alignment.center,
                            child: new Row(
                              children: <Widget>[
                                new Expanded(
                                  child: new FlatButton(
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                    ),
                                    color: Color(0Xff3B5998),
                                    onPressed: () => {},
                                    child: new Container(
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Expanded(
                                            child: new FlatButton(
                                              onPressed: () => {},
                                              padding: EdgeInsets.only(
                                                top: 20.0,
                                                bottom: 20.0,
                                              ),
                                              child: new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Text(
                                                    "FACEBOOK",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
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
                        ),
                        new Expanded(
                          child: new Container(
                            margin: EdgeInsets.only(left: 8.0),
                            alignment: Alignment.center,
                            child: new Row(
                              children: <Widget>[
                                new Expanded(
                                  child: new FlatButton(
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                    ),
                                    color: Color(0Xffdb3236),
                                    onPressed: () => {},
                                    child: new Container(
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Expanded(
                                            child: new FlatButton(
                                              onPressed: () => {},
                                              padding: EdgeInsets.only(
                                                top: 20.0,
                                                bottom: 20.0,
                                              ),
                                              child: new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Text(
                                                    "GOOGLE",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
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
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
