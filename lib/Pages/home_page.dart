import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello_rectangle/Widgets/header.dart';
import 'package:hello_rectangle/services/auth.dart';

import '../Widgets/boat_filter_list.dart';
import '../Models/boat_model_list.dart';
import 'boat_overview_page.dart';
import 'profile_page.dart';
import '../Widgets/header_filter.dart';
import 'boat_listing.dart';
import '../Widgets/fab_bottom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _selectedTab(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    }
  }

  Widget _buildFab(BuildContext context) {
    final icon = Icons.add;
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(_animateBottomToTop());
      },
      tooltip: 'Boatel',
      backgroundColor: Colors.blueAccent,
      child: Icon(icon),
      elevation: 2.0,
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
        padding: const EdgeInsets.only(left: 20.0, top: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget _buildBoatIconsList(context, index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HeaderFilter(iconIndex: index)),
        );
      },
      child: RaisedButton(
        color: Color(0xFFECEFF1),
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                boatIconsList.icons[index].icon,
                color: Colors.black,
                size: 35.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                boatIconsList.icons[index].name,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
              ),
            ),
          ],
        ),
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

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
              padding: EdgeInsets.only(left: 0.0),
              height: 75.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: boatIconsList.icons.length,
                  itemBuilder: (context, index) {
                    return _buildBoatIconsList(context, index);
                  }),
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
                    return _buildBoatList(context, snapshot.data.documents[index], index);
                  });
                },
              )
            ),
          ],
        ),
      ),
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'List your boat',
        color: Colors.grey,
        selectedColor: Colors.grey,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(iconData: Icons.home, text: 'Catalogue'),
          FABBottomAppBarItem(iconData: Icons.account_circle, text: 'Profile'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(
        context,
      ),
      appBar: AppBar(
        title: Text('Boatel'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('logout'))
        ],
      ),
    );
  }
}

Route _animateBottomToTop() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => BoatListing(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
