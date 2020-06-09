import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_rectangle/Pages/MyAdvertisements.dart';
import 'package:hello_rectangle/Pages/boat_listing.dart';
import 'package:hello_rectangle/Pages/boat_overview_page.dart';
import 'package:hello_rectangle/screens/profile/ProfileInfo.dart';
import 'package:hello_rectangle/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_rectangle/shared/constants.dart';
import 'package:hello_rectangle/shared/loading.dart';

class HomePage extends StatefulWidget {
  //MANDATORY VARIABLE IN EVERY PAGE FOR ROUTING PURPOSES
  static String pageId = 'homePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  final FirebaseAuth _authUser = FirebaseAuth.instance;
  final AuthService __auth = AuthService();

  String _uid = '';
  String profileImage;
  String firstName = '';
  String lastName = '';

  Stream<DocumentSnapshot> firestoreInstance;

  getCurrentUser() async {
    final FirebaseUser user = await _authUser.currentUser();

    setState(() {
      _uid = user.uid;
    });

    firestoreInstance =
        Firestore.instance.collection('users').document(_uid).snapshots();
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Boat2Me'),
        elevation: 0.0,
      ),
      drawer: Drawer(
          elevation: 5.0,
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(right: 115.0),
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: SizedBox(
                              width: 120.0,
                              height: 120.0,
                              child: (() {
                                if (profileImage != null &&
                                    profileImage != "") {
                                  return Image.network(
                                    profileImage,
                                    fit: BoxFit.fill,
                                  );
                                } else {
                                  return Image.network(
                                    'https://picsum.photos/250?image=9',
                                    fit: BoxFit.fill,
                                  );
                                }
                              }())),
                        ),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.only(left: 38.0),
                    child: Text(
                      firstName + " " + lastName,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    )), //TH
                SizedBox(
                  height: 60.0,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: sidebarPadding),
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.home,
                        color: Colors.blueAccent,
                        size: 30.0,
                      ),
                      title: Text('Home'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )),
                SizedBox(
                  height: 25.0,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: sidebarPadding),
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.ship,
                        color: Colors.blueAccent,
                        size: 30.0,
                      ),
                      title: Text('My Advertisements'),
                      onTap: () {
                        Navigator.pushNamed(context, MyAdvertisements.pageId);
                      },
                    )),
                SizedBox(
                  height: 25.0,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: sidebarPadding),
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.userCircle,
                        color: Colors.blueAccent,
                        size: 30.0,
                      ),
                      title: Text('Profile'),
                      onTap: () {
                        Navigator.pushNamed(context, ProfileInfo.pageId);
                      },
                    )),
                SizedBox(
                  height: 25.0,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: sidebarPadding),
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.signOutAlt,
                        color: Colors.blueAccent,
                        size: 30.0,
                      ),
                      title: Text('Sign out'),
                      onTap: () async {
                        await _auth.signOut();
                      },
                    )),
              ],
            ),
          )),
      //USE STREAMBUILDER TO CREATE THE LIST OF BOATS
      body: StreamBuilder(
        stream: Firestore.instance.collection('boats').snapshots(),
        builder: (context, snapshot) {
          return StreamBuilder(
            stream: firestoreInstance,
            builder: (context, snapshot2) {
              if (!snapshot.hasData) {
                return Loading();
              } else {
                var user = snapshot2.data;
                if (user == null) {
                  profileImage = "";
                } else {
                  profileImage = user['tempProfileImage'];
                  firstName = user['firstName'];
                  lastName = user['lastName'];
                }
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
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, BoatListing.pageId);
          },
          label: Text(
            ' List Boat',
            style: kFloatingButtonTextStyle,
          ),
          icon: Icon(
            FontAwesomeIcons.ship,
            size: 20.0,
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
                                      " " + document['title'],
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
                                          color: Colors.blueAccent,
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
                                          color: Colors.blueAccent,
                                        ),
                                        Text(
                                          document['price'],
                                          style: kBoatCardNonImportantTextStyle,
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
                                          color: Colors.blueAccent,
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
