import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello_rectangle/Pages/profile_page.dart';
import 'package:hello_rectangle/Widgets/header.dart';

import '../Widgets/boat_filter_list.dart';
import 'boat_overview_page.dart';
import '../Widgets/header_filter.dart';
import 'boat_listing.dart';
import '../Widgets/fab_bottom_app_bar.dart';

class HomeScreenOLD extends StatefulWidget {
  static String pageId = 'homeScreenOLD';
  @override
  _HomeScreenOLDState createState() => _HomeScreenOLDState();
}

class _HomeScreenOLDState extends State<HomeScreenOLD> {
  Widget _buildBoatList(context, DocumentSnapshot document, index) {
    return GestureDetector(
      onTap: () {
        //TODO: FORWARD TO THE BOAT OVERVIEW PAGE
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Header(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Container(
                      height: 50.0,
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      decoration: new BoxDecoration(
                        color: Color(0xFFFCFCFC).withOpacity(0.3),
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                            'Search',
                            style: TextStyle(color: Color(0xFFFCFCFC)),
                          )),
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {},
                            color: Color(0xFFFCFCFC),
                            iconSize: 30.0,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                    left: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                  ),
                )
              ],
            ),
            Container(
                padding: EdgeInsets.only(left: 10.0),
                height: MediaQuery.of(context).size.height - 300.0,
                child: StreamBuilder(
                  stream: Firestore.instance.collection('boats').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Text('Loading...');
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return _buildBoatList(
                            context, snapshot.data.documents[index], index);
                      },
                    );
                  },
                )),
          ],
        ),
      ),
      //
      //
      //
      //
      //
      //
      //
      //NO LONGER NEEDED
//      bottomNavigationBar: FABBottomAppBar(
//        centerItemText: 'List your boat',
//        color: Colors.grey,
//        selectedColor: Colors.grey,
//        notchedShape: CircularNotchedRectangle(),
//        onTabSelected: _selectedTab,
//        items: [
//          FABBottomAppBarItem(iconData: Icons.home, text: 'Catalogue'),
//          FABBottomAppBarItem(iconData: Icons.account_circle, text: 'Profile'),
//        ],
//      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//      floatingActionButton: _buildFab(
//        context,
//      ),
    );
  }
}

//Route _animateBottomToTop() {
//  return PageRouteBuilder(
//    pageBuilder: (context, animation, secondaryAnimation) => BoatListing(),
//    transitionsBuilder: (context, animation, secondaryAnimation, child) {
//      var begin = Offset(0.0, 1.0);
//      var end = Offset.zero;
//      var curve = Curves.ease;
//
//      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//      return SlideTransition(
//        position: animation.drive(tween),
//        child: child,
//      );
//    },
//  );
//}
