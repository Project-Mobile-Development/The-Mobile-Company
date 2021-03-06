import 'package:flutter/material.dart';
import 'package:hello_rectangle/screens/auth/register.dart';
import 'package:hello_rectangle/screens/auth/sign_in.dart';

class Authenticate extends StatefulWidget {
  static String pageId = 'authenticate';
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
