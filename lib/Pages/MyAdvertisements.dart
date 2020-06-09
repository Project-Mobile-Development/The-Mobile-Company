import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_rectangle/Pages/boat_listing.dart';
import 'package:hello_rectangle/Pages/boat_overview_page.dart';
import 'package:hello_rectangle/screens/home/home.dart';
import 'package:hello_rectangle/screens/profile/ProfileInfo.dart';
import 'package:hello_rectangle/screens/wrapper.dart';
import 'package:hello_rectangle/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_rectangle/shared/constants.dart';
import 'package:hello_rectangle/shared/loading.dart';

import 'my_boat_overview_page.dart';

class MyAdvertisements extends StatefulWidget {
  //MANDATORY VARIABLE IN EVERY PAGE FOR ROUTING PURPOSES
  static String pageId = 'myAdvertisementsPage';

  @override
  _MyAdvertisements createState() => _MyAdvertisements();
}

class _MyAdvertisements extends State<MyAdvertisements> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _uid = '';

  Stream<DocumentSnapshot> firestoreInstance;

  getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    firestoreInstance =
        Firestore.instance.collection('boats').document(_uid).snapshots();

    _uid = user.uid;

    firestoreInstance =
        Firestore.instance.collection('boats').document(_uid).snapshots();
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Advertisements'),
        elevation: 0.0,
      ),
      drawer: Drawer(
        elevation: 5.0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Boat2Me',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            //THIS IS THE SIDE MENU BAR
            ListTile(
              leading: Icon(
                FontAwesomeIcons.home,
                size: 40.0,
              ),
              title: Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, HomePage.pageId);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.ship,
                size: 35.0,
              ),
              title: Text('My Advertisements'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.userCircle,
                size: 40.0,
              ),
              title: Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, ProfileInfo.pageId);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.signOutAlt,
                size: 40.0,
              ),
              title: Text('Sign out'),
              onTap: () async {
                await _auth.signOut();
                Navigator.pushNamed(context, Wrapper.pageId);
              },
            ),
          ],
        ),
      ),
      //USE STREAMBUILDER TO CREATE THE LIST OF BOATS
      body: StreamBuilder(
        stream: Firestore.instance.collection('boats').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          } else {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                if (snapshot.data.documents[index]['userId'] == _uid) {
                  return _buildBoatList(
                      context, snapshot.data.documents[index], index);
                } else {
                  return SizedBox(height: 0);
                }
              },
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  //WIDGET USED TO DISPLAY THE CARDS
  Widget _buildBoatList(context, DocumentSnapshot document, index) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MyBoatOverviewScreen(boatIndex: index),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 350.0,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
                      child: Material(
                        color: Colors.white,
                        elevation: 14.0,
                        //TODO: PICK A NICER SHADOW COLOR
                        shadowColor: Color(0x802196F3),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 20.0, left: 20.0, right: 20.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200.0,
                                  child: Image.network(
                                    document['image'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      document['title'],
                                      style: kBoatCardImportantTextStyle,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          document['location'],
                                          style: kBoatCardNonImportantTextStyle,
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.mapMarkerAlt,
                                          size: 20.0,
                                          color: Colors.blueGrey,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.euroSign,
                                          size: 20.0,
                                          color: Colors.blueGrey,
                                        ),
                                        Text(
                                          document['price'],
                                          style: kBoatCardImportantTextStyle,
                                        ),
                                        Text(
                                          ' per hour',
                                          style: kBoatCardNonImportantTextStyle,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        //TODO: Replace with boat tour duration
                                        Text(
                                          document['duration'] + ' min',
                                          style: kBoatCardNonImportantTextStyle,
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.stopwatch,
                                          size: 20.0,
                                          color: Colors.blueGrey,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
