import 'package:flutter/material.dart';
import 'package:hello_rectangle/screens/auth/sign_in.dart';
import 'package:hello_rectangle/services/auth.dart';
import 'package:hello_rectangle/shared/constants.dart';
import 'package:hello_rectangle/shared/loading.dart';
import 'package:hello_rectangle/Widgets/RoundedButton.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 250.0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TypewriterAnimatedTextKit(
                          text: ['Boat 2 Me'],
                          textStyle: TextStyle(
                              fontSize: 45.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.blue),
                          speed: Duration(milliseconds: 350),
                          totalRepeatCount: 1,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration:
                              kTextFieldDecoration.copyWith(hintText: 'Email*'),
                          validator: (val) =>
                              val.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Password*'),
                          obscureText: true,
                          validator: (val) => val.length < 6
                              ? 'Enter a password 6+ chars long'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        RoundedButton(
                          colour: Colors.blue,
                          title: 'Register',
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);
                              if (result == null) {
                                setState(() {
                                  error = 'Please supply a valid email';
                                  loading = false;
                                });
                              }
                            }
                          },
                        ),
                        RoundedButton(
                          colour: Colors.red,
                          title: 'Sign in',
                          onPressed: () {
                            widget.toggleView();
                          },
                        ),
                        Text(
                          error,
                          style: kErrorSignInTextStyle,
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
