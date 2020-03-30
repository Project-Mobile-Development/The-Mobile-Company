
import 'package:flutter/material.dart';

import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
// This widget is the root of our application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boatel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of our application
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
