import 'package:flutter/material.dart';
import 'package:hello_rectangle/Pages/login_page.dart';
import 'package:hello_rectangle/screens/wrapper.dart';
import 'package:hello_rectangle/services/auth.dart';
import 'package:provider/provider.dart';

import 'Models/user_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
// This widget is the root of our application
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Boatel',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of our application
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
      ),
    );
  }
}
