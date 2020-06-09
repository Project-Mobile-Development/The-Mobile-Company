import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_rectangle/shared/loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hello_rectangle/shared/constants.dart';

import 'my_boat_overview_page.dart';

class BoatOverviewScreen extends StatefulWidget {
  static String pageId = 'boatOverviewScreen';
  final int boatIndex;

  BoatOverviewScreen({this.boatIndex});

  @override
  _BoatOverviewScreenState createState() => _BoatOverviewScreenState();
}

getUser(AsyncSnapshot snapshot, BoatOverviewScreen widget) async {
  return new StreamBuilder(
      stream: Firestore.instance
          .collection('users')
          .document(snapshot.data.documents[widget.boatIndex]['userId'])
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }
        var userDocument = snapshot.data;
        print('test: ' + userDocument.toString());
        return new Text(userDocument['firstName']);
      });
}

class _BoatOverviewScreenState extends State<BoatOverviewScreen> {
  String _ownerName = '';
  String _ownerEmail = '';
  String _ownerPhoneNumber = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var _favourites;

  String _uid = '';

  Stream<DocumentSnapshot> firestoreInstance;

  getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();

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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance.collection('boats').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Loading();
          var boat = snapshot.data.documents[widget.boatIndex];
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),

                flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        snapshot.data.documents[widget.boatIndex]['image'],
                        fit: BoxFit.cover,
                        width: 1000.0,
                        height: 500.0,
                      ),
                    ],
                  ),
                )),

                // Extruding edge from the sliver appbar, may need to fix expanded height
                expandedHeight: MediaQuery.of(context).size.height / 2.71,
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.only(left: 10.0, bottom: 10.0, top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        snapshot.data.documents[widget.boatIndex]['title'],
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: <Widget>[
                          StreamBuilder(
                              stream: firestoreInstance,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Loading();
                                }
                                var userDocument = snapshot.data;
                                _favourites = userDocument['favouriteBoatID'];

                                return new IconButton(
                                  onPressed: () async {
                                    final snackBar = SnackBar(content: Text('You have already defined a favourite :('));

                                    if (_favourites != null) {
                                      return Scaffold.of(context).showSnackBar(snackBar);
                                    } else {
                                      return Firestore.instance
                                          .runTransaction((transaction) async {
                                        Firestore.instance
                                            .collection("users")
                                            .document(_uid)
                                            .updateData(
                                          {
                                            'favouriteBoatID': boat.documentID.toString()
                                          },
                                        );
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    FontAwesomeIcons.heart,
                                    color: Colors.grey,
                                  ),
                                  splashColor: Colors.red,
                                  color: Colors.lightBlue,
                                );
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: StreamBuilder(
                                stream: Firestore.instance
                                    .collection('users')
                                    .document(snapshot.data
                                        .documents[widget.boatIndex]['userId'])
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Loading();
                                  }
                                  var userDocument = snapshot.data;
                                  return new CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage: NetworkImage(
                                        userDocument['tempProfileImage']),
                                  );
                                }),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    snapshot.data.documents[widget.boatIndex]
                                        ['location'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Owned by ",
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                        StreamBuilder(
                                            stream: Firestore.instance
                                                .collection('users')
                                                .document(snapshot
                                                        .data.documents[
                                                    widget.boatIndex]['userId'])
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Loading();
                                              }
                                              var userDocument = snapshot.data;
                                              _ownerName =
                                                  userDocument['firstName'] +
                                                      ' ' +
                                                      userDocument['lastName'];
                                              _ownerEmail =
                                                  userDocument['email'];
                                              _ownerPhoneNumber =
                                                  userDocument['phoneNumber'];
                                              return new Text(
                                                  userDocument['firstName'] +
                                                      ' ' +
                                                      userDocument['lastName']);
                                            }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.only(left: 10.0, top: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "About this boat",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        snapshot.data.documents[widget.boatIndex]
                            ['description'],
                        style: TextStyle(color: Colors.grey, fontSize: 15.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
                        child: Text(
                          "Price",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(children: <Widget>[
                        Icon(
                          FontAwesomeIcons.euroSign,
                          size: 13.0,
                          color: Colors.blueGrey,
                        ),
                        Text(
                          snapshot.data.documents[widget.boatIndex]['price'],
                          style: TextStyle(
                              color: Colors.blueAccent, fontSize: 15.0),
                        ),
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
                        child: Text(
                          "Duration",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        snapshot.data.documents[widget.boatIndex]['duration'] +
                            ' minutes',
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 15.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
                        child: Text(
                          "Boat capacity",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        snapshot.data.documents[widget.boatIndex]['boatCapacity'] +
                            ' persons',
                        style:
                        TextStyle(color: Colors.blueAccent, fontSize: 15.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar:
      new Container(
        color: Colors.blueAccent,
        child: new MaterialButton(
          onPressed: () {
            showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 200,
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Contact ' + _ownerName.toUpperCase(),
                            style: kBoatCardImportantTextStyle.copyWith(
                                color: Colors.blue),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ButtonBar(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton.icon(
                                onPressed: () => customLaunch(
                                    'mailto:$_ownerEmail?subject=Help&body=I%20need%20help!'),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                label: Text(
                                  'Email',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                icon: Icon(
                                  FontAwesomeIcons.envelope,
                                  color: Colors.white,
                                ),
                                textColor: Colors.white,
                                splashColor: Colors.red,
                                color: Colors.lightBlue,
                              ),
                              RaisedButton.icon(
                                onPressed: () =>
                                    customLaunch('sms:$_ownerPhoneNumber'),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                label: Text(
                                  'SMS',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                icon: Icon(
                                  FontAwesomeIcons.sms,
                                  color: Colors.white,
                                ),
                                textColor: Colors.white,
                                splashColor: Colors.red,
                                color: Colors.lightBlue,
                              ),
                              RaisedButton.icon(
                                onPressed: () =>
                                    customLaunch('tel:$_ownerPhoneNumber'),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                label: Text(
                                  'Call',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                icon: Icon(
                                  FontAwesomeIcons.phoneAlt,
                                  color: Colors.white,
                                ),
                                textColor: Colors.white,
                                splashColor: Colors.red,
                                color: Colors.lightBlue,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
          child: new Padding(
            padding: const EdgeInsets.all(24.0),
            child: new Text("Contact the boat owner",
                style: new TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}
