import 'package:flutter/material.dart';
import 'package:hello_rectangle/Pages/MyAdvertisements.dart';
import 'package:hello_rectangle/Pages/boat_listing.dart';
import 'package:hello_rectangle/Pages/boat_overview_page.dart';
import 'package:hello_rectangle/screens/home/home.dart';
import 'package:hello_rectangle/screens/profile/ProfileInfo.dart';
import 'package:hello_rectangle/screens/wrapper.dart';
import 'package:hello_rectangle/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:hello_rectangle/Models/user_model.dart';

import 'Models/user_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
// This widget is the root of our application
  @override
  Widget build(BuildContext context) {
    //CHECK IF THE USER IS ALREADY LOGGEDIN
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Boat2Me',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of our application
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
        routes: {
          HomePage.pageId: (context) => HomePage(),
          ProfileInfo.pageId: (context) => ProfileInfo(),
          BoatListing.pageId: (context) => BoatListing(),
          BoatOverviewScreen.pageId: (context) => BoatOverviewScreen(),
          MyAdvertisements.pageId: (context) => MyAdvertisements()
          //HomeScreenOLD.pageId: (context) => HomeScreenOLD(),
        },
      ),
    );
  }
}
