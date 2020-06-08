import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hello_rectangle/services/auth.dart';
import 'package:hello_rectangle/shared/loading.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 1.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.05),
                              BlendMode.dstATop),
                          image: NetworkImage(
                              'https://firebasestorage.googleapis.com/v0/b/boatelthemobilecompany.appspot.com/o/personal-user-illustration-%402x.png?alt=media&token=70a70e8d-1f47-403a-924d-dffa9a246f5b'),
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
                            margin:
                                const EdgeInsets.only(left: 40.0, right: 40.0),
                            alignment: Alignment.center,
                            padding:
                                const EdgeInsets.only(left: 0.0, right: 10.0),
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
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter first Name' : null,
                                    onChanged: (val) {
                                      setState(() => firstName = val);
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
                                  padding: const EdgeInsets.only(
                                      left: 40.0, top: 25.0),
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
                            margin:
                                const EdgeInsets.only(left: 40.0, right: 40.0),
                            alignment: Alignment.center,
                            padding:
                                const EdgeInsets.only(left: 0.0, right: 10.0),
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
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter last Name' : null,
                                    onChanged: (val) {
                                      setState(() => lastName = val);
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
                                  padding: const EdgeInsets.only(
                                      left: 40.0, top: 25.0),
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
                            margin:
                                const EdgeInsets.only(left: 40.0, right: 40.0),
                            alignment: Alignment.center,
                            padding:
                                const EdgeInsets.only(left: 0.0, right: 10.0),
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
                                    validator: (val) => val.isEmpty
                                        ? 'Enter phone Number'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => phoneNumber = val);
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
                                  padding: const EdgeInsets.only(
                                      left: 40.0, top: 25.0),
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
                            margin:
                                const EdgeInsets.only(left: 40.0, right: 40.0),
                            alignment: Alignment.center,
                            padding:
                                const EdgeInsets.only(left: 0.0, right: 10.0),
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
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter an email' : null,
                                    onChanged: (val) {
                                      setState(() => email = val);
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
                            margin:
                                const EdgeInsets.only(left: 40.0, right: 40.0),
                            alignment: Alignment.center,
                            padding:
                                const EdgeInsets.only(left: 0.0, right: 10.0),
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
                                    validator: (val) => val.length < 6
                                        ? 'Enter a password 6+ chars long'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => password = val);
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
                            margin:
                                const EdgeInsets.only(left: 40.0, right: 40.0),
                            alignment: Alignment.center,
                            padding:
                                const EdgeInsets.only(left: 0.0, right: 10.0),
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
                                    validator: (val) => val != password
                                        ? 'Passwords do not match'
                                        : null,
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
                                  onPressed: () => {widget.toggleView()},
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
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.blueAccent,
                                    onPressed: () async {
                                      print("CURRENT STATE" +
                                          _formKey.currentState
                                              .validate()
                                              .toString());
                                      if (_formKey.currentState.validate()) {
                                        setState(() => loading = true);
                                        dynamic result = await _auth
                                            .registerWithEmailAndPassword(
                                                email,
                                                password,
                                                firstName,
                                                lastName,
                                                phoneNumber);
                                        if (result == null) {
                                          setState(() {
                                            error =
                                                'Please supply a valid email';
                                            loading = false;
                                          });
                                        }
                                      }
                                    },
                                    child: new Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 20.0,
                                        horizontal: 20.0,
                                      ),
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
            ),
          );
  }
}
