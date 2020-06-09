import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_rectangle/screens/auth/register.dart';
import 'package:hello_rectangle/services/auth.dart';
import 'package:hello_rectangle/shared/constants.dart';
import 'package:hello_rectangle/shared/loading.dart';
import 'package:hello_rectangle/Pages/reset_password_page.dart';
import 'package:hello_rectangle/Widgets/RoundedButton.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

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
                      height: MediaQuery.of(context).size.height,
                      decoration: kLoginBoxDecoration,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: 120.0,
                                top: 95.0,
                                right: 120.0,
                                bottom:
                                    (MediaQuery.of(context).size.height / 7) -
                                        15),
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
                                    keyboardType: TextInputType.emailAddress,
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
                                  onPressed: () => {
                                    Navigator.pushNamed(
                                        context, ResetPassword.pageId)
                                  },
                                ),
                              ),
                            ],
                          ),
                          new Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 35.0),
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
                                      if (_formKey.currentState.validate()) {
                                        setState(() => loading = true);
                                        dynamic result = await _auth
                                            .signInWitEmailAndPassword(
                                                email, password);

                                        if (result == null) {
                                          setState(() {
                                            error =
                                                'Could not sign in with those credentials';
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
                          Divider(height: 15.0, color: Colors.white),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 0.0),
                                child: new FlatButton(
                                  child: new Text(
                                    "Don't have an account? Sign up now",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                      fontSize: 15.0,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  onPressed: () => {widget.toggleView()},
                                ),
                              ),
                            ],
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
