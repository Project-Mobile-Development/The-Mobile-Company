import 'package:flutter/material.dart';
import 'package:hello_rectangle/header.dart';
import 'package:hello_rectangle/header_filter.dart';

import 'boat_model.dart';
import 'boat_model_list.dart';
import 'boat_overview_page.dart';
import 'boat_listing.dart';
import 'fab_bottom_app_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _lastSelected = 'TAB: 0';

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';
    });
  }

  void _selectedFab(int index) {
    setState(() {
      _lastSelected = 'FAB: $index';
    });
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

  Widget _buildBoatList(context, index, List<Boat> listImages) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BoatOverviewScreen()),
        );
      },
      child: Container(
        width: 200.0,
        padding: const EdgeInsets.only(left: 20.0, top: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  listImages[index].image,
                  width: 350.0,
                  height: 150.0,
                  fit: BoxFit.cover,
                )),
            Text(
              listImages[index].location,
              style: TextStyle(color: Colors.grey, fontSize: 15.0),
            ),
            Text(
              listImages[index].price,
              style: TextStyle(color: Colors.grey, fontSize: 15.0),
            ),
            Text(
              listImages[index].type,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
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
            Stack(
              children: <Widget>[
                HeaderFilter(),
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
              height: 510.0,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: boatList.boats.length,
                  itemBuilder: (context, index) {
                    return _buildBoatList(context, index, boatList.boats);
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

//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final title = 'Horizontal List';
//
//    return MaterialApp(
//      title: title,
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text(title),
//        ),
//        body: Container(
//          margin: EdgeInsets.symmetric(vertical: 20.0),
//          height: 200.0,
//          child: ListView(
//            scrollDirection: Axis.horizontal,
//            children: <Widget>[
//              Container(
//                width: 160.0,
//                color: Colors.red,
//              ),
//              Container(
//                width: 160.0,
//                color: Colors.blue,
//              ),
//              Container(
//                width: 160.0,
//                color: Colors.green,
//              ),
//              Container(
//                width: 160.0,
//                color: Colors.yellow,
//              ),
//              Container(
//                width: 160.0,
//                color: Colors.orange,
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
