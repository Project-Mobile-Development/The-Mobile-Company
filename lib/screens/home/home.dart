import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_rectangle/Pages/boat_listing.dart';
import 'package:hello_rectangle/Pages/boat_overview_page.dart';
import 'package:hello_rectangle/screens/profile/ProfileInfo.dart';
import 'package:hello_rectangle/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_rectangle/shared/constants.dart';
import 'package:hello_rectangle/shared/loading.dart';

class HomePage extends StatelessWidget {
  static String pageId = 'homePage';
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context,) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Boat2Me'),
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
            //TODO: ADD BETTER STYLE TO THE SPINNER (SEE DOCUMENTATION ON THE DART PACKAGE)
            return Loading();
          } else {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return _buildBoatList(
                    context, snapshot.data.documents[index], index);
              },
            );
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, BoatListing.pageId);
          },
          label: Text(
            'List Boat',
            style: kFloatingButtonTextStyle,
          ),
          icon: Icon(
            FontAwesomeIcons.plusCircle,
            size: 25.0,
          ),
        ),
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
                            BoatOverviewScreen(boatIndex: index),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
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
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  height: 200.0,
                                  //TODO: Replace with boat image
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
