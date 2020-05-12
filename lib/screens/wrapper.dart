import 'package:flutter/material.dart';
import 'package:hello_rectangle/Models/user_model.dart';
import 'package:hello_rectangle/Pages/home_page.dart';
import 'package:hello_rectangle/screens/home/home.dart';
import 'package:hello_rectangle/Pages/login_page.dart';
import 'package:hello_rectangle/screens/auth/authentication.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if (user == null){
      return Authenticate();
    } else {
      return HomeScreen();
    }
  }
}
