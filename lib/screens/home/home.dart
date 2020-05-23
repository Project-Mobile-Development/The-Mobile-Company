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
//            return ListView.builder(
//              itemCount: snapshot.data.documents.length,
//              itemBuilder: (context, index) {
//                DocumentSnapshot myBoat = snapshot.data.documents[index];
//                return Column(
//                  children: <Widget>[
//                    Stack(
//                      children: <Widget>[
//                        Column(
//                          children: <Widget>[
//                            GestureDetector(
//                              onTap: () {
//                                //TODO: FORWARD BOATVIEW PAGE
//                                //Remember to add the route to the map in main.dart
//                                Navigator.pushNamed(
//                                    context, BoatOverviewScreen.pageId());
//                              },
//                              child: Container(
//                                width: MediaQuery.of(context).size.width,
//                                height: 350.0,
//                                child: Padding(
//                                  padding:
//                                      EdgeInsets.only(top: 8.0, bottom: 8.0),
//                                  child: Material(
//                                    color: Colors.white,
//                                    elevation: 14.0,
//                                    shadowColor: Color(0x802196F3),
//                                    child: Center(
//                                      child: Padding(
//                                        padding: EdgeInsets.all(8.0),
//                                        child: Column(
//                                          children: <Widget>[
//                                            Container(
//                                              width: MediaQuery.of(context)
//                                                  .size
//                                                  .width,
//                                              height: 200.0,
//                                              child: Image.network(
//                                                '${myBoat['image']}',
//                                                fit: BoxFit.fill,
//                                              ),
//                                            ),
//                                            SizedBox(
//                                              height: 10.0,
//                                            ),
//                                            Text(
//                                              '${myBoat['price']}',
//                                              style: TextStyle(
//                                                  fontSize: 20.0,
//                                                  fontWeight: FontWeight.bold),
//                                            ),
//                                            SizedBox(
//                                              height: 10.0,
//                                            ),
//                                            Text(
//                                              '${myBoat['title']}',
//                                              style: TextStyle(
//                                                  fontSize: 16.0,
//                                                  fontWeight: FontWeight.w600,
//                                                  color: Colors.blueGrey),
//                                            ),
//                                            SizedBox(
//                                              height: 10.0,
//                                            ),
//                                            Expanded(
//                                              child: Text(
//                                                '${myBoat['description']}',
//                                                style: TextStyle(
//                                                    fontSize: 16.0,
//                                                    fontWeight: FontWeight.w600,
//                                                    color: Colors.blueGrey),
//                                              ),
//                                            ),
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ],
//                    ),
//                  ],
//                );
//              },
//            );
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

  Widget _buildBoatList(context, DocumentSnapshot document, index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BoatOverviewScreen(boatIndex: index)),
        );
      },
      child: Container(
        width: 200.0,
        //padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(3.0),
                child: Image.asset(
                  document['image'],
                  width: 350.0,
                  height: 180.0,
                  fit: BoxFit.cover,
                )),
            Divider(
              color: Colors.white,
              height: 10.0,
            ),
            Text(
              document['title'],
              style: TextStyle(fontSize: 20.0),
            ),
            Divider(
              color: Colors.white,
              height: 5.0,
            ),
            Text(
              document['type'],
              style: TextStyle(color: Colors.blueAccent, fontSize: 15.0),
            ),
            Divider(
              color: Colors.white,
              height: 2.5,
            ),
            Text(
              document['location'],
              style: TextStyle(color: Colors.grey, fontSize: 15.0),
            ),
            Divider(
              color: Colors.white,
              height: 2.5,
            ),
            Text(
              document['price'],
              style: TextStyle(color: Colors.grey, fontSize: 15.0),
            ),
          ],
        ),
      ),
    );
  }
}
