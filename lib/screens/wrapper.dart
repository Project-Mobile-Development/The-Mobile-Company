import 'package:flutter/material.dart';
import 'package:hello_rectangle/Models/user_model.dart';
import 'package:hello_rectangle/screens/auth/authentication.dart';
import 'package:provider/provider.dart';
import 'package:hello_rectangle/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  //THIS VARIABLE NEEDS TO BE DECLARED IN EVERY PAGE FOR EASY ROUTING (except auth related ones)

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //USER IS NOT LOGGED IN
    if (user == null) {
      return Authenticate();
    }
    //USER IS LOGGED IN
    else {
      return HomePage();
    }
  }
}
