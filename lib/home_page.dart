import 'package:flutter/material.dart';
import 'package:hello_rectangle/header.dart';

import 'boat_filter_list.dart';
import 'boat_model_list.dart';
import 'boat_overview_page.dart';
import 'ProfilePage.dart';
import 'header_filter.dart';
import 'boat_listing.dart';
import 'fab_bottom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _selectedTab(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
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
      backgroundColor: Colors.blue,
      child: Icon(icon),
      elevation: 2.0,
    );
  }

  Widget _buildBoatList(context, index) {
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
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  boatList.boats[index].image,
                  width: 350.0,
                  height: 150.0,
                  fit: BoxFit.cover,
                )),
            Text(
              boatList.boats[index].location,
              style: TextStyle(color: Colors.grey, fontSize: 15.0),
            ),
            Text(
              boatList.boats[index].price,
              style: TextStyle(color: Colors.grey, fontSize: 15.0),
            ),
            Text(
              boatList.boats[index].type,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
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
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: boatList.boats.length,
                  itemBuilder: (context, index) {
                    return _buildBoatList(context, index);
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'List your boat',
        color: Colors.grey,
        selectedColor: Color(0xFF1976D2),
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
