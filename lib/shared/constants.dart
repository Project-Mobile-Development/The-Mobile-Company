import 'package:flutter/material.dart';

//NOT USED ANY MORE
const kTextInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueGrey, width: 0.5),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
  ),
);
const sidebarPadding = 20.0;
const kFloatingButtonTextStyle =
    TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold);

const kBoatCardImportantTextStyle =
    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

const kBoatCardNonImportantTextStyle = TextStyle(
    fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.blueAccent);

const kErrorSignInTextStyle =
    TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.red);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

var kLoginBoxDecoration =  BoxDecoration(
  color: Colors.white,
  image: DecorationImage(
    colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.05), BlendMode.dstATop),
    image:
    AssetImage('assets/images/login-signup-background.jpg'),
    fit: BoxFit.cover,
  ),
);

//var appDrawer = Drawer(
//    elevation: 5.0,
//    child: Container(
//      color: Colors.white,
//      child: ListView(
//        padding: EdgeInsets.zero,
//        children: <Widget>[
//          Padding(
//              padding: const EdgeInsets.only(right: 115.0),
//              child: DrawerHeader(
//                decoration: BoxDecoration(
//                  color: Colors.white,
//                ),
//                child: CircleAvatar(
//                  radius: 100,
//                  backgroundColor: Colors.white,
//                  child: ClipOval(
//                    child: SizedBox(
//                        width: 120.0,
//                        height: 120.0,
//                        child: (() {
//                          if (profileImage != null &&
//                              profileImage != "") {
//                            return Image.network(
//                              profileImage,
//                              fit: BoxFit.fill,
//                            );
//                          } else {
//                            return Image.network(
//                              'https://picsum.photos/250?image=9',
//                              fit: BoxFit.fill,
//                            );
//                          }
//                        }())),
//                  ),
//                ),
//              )),
//          Padding(
//              padding: const EdgeInsets.only(left: 38.0),
//              child: Text(
//                firstName + " " + lastName,
//                style: TextStyle(
//                    fontSize: 20.0, fontWeight: FontWeight.bold),
//              )), //TH
//          SizedBox(
//            height: 60.0,
//          ),
//          Padding(
//              padding: const EdgeInsets.only(left: sidebarPadding),
//              child: ListTile(
//                leading: Icon(
//                  FontAwesomeIcons.home,
//                  color: Colors.blueAccent,
//                  size: 30.0,
//                ),
//                title: Text('Home'),
//                onTap: () {
//                  Navigator.pop(context);
//                },
//              )),
//          SizedBox(
//            height: 25.0,
//          ),
//          Padding(
//              padding: const EdgeInsets.only(left: sidebarPadding),
//              child: ListTile(
//                leading: Icon(
//                  FontAwesomeIcons.ship,
//                  color: Colors.blueAccent,
//                  size: 30.0,
//                ),
//                title: Text('My Advertisements'),
//                onTap: () {
//                  Navigator.pushNamed(context, MyAdvertisements.pageId);
//                },
//              )),
//          SizedBox(
//            height: 25.0,
//          ),
//          Padding(
//              padding: const EdgeInsets.only(left: sidebarPadding),
//              child: ListTile(
//                leading: Icon(
//                  FontAwesomeIcons.userCircle,
//                  color: Colors.blueAccent,
//                  size: 30.0,
//                ),
//                title: Text('Profile'),
//                onTap: () {
//                  Navigator.pushNamed(context, ProfileInfo.pageId);
//                },
//              )),
//          SizedBox(
//            height: 25.0,
//          ),
//          Padding(
//              padding: const EdgeInsets.only(left: sidebarPadding),
//              child: ListTile(
//                leading: Icon(
//                  FontAwesomeIcons.signOutAlt,
//                  color: Colors.blueAccent,
//                  size: 30.0,
//                ),
//                title: Text('Sign out'),
//                onTap: () async {
//                  await _auth.signOut();
//                },
//              )),
//        ],
//      ),
//    ));
