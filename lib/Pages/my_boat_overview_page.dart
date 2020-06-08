import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_rectangle/services/database.dart';
import 'package:hello_rectangle/shared/loading.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/boat_model_list.dart';

class MyBoatOverviewScreen extends StatefulWidget {
  static String pageId = 'boatOverviewScreen';
  final int boatIndex;

  MyBoatOverviewScreen({this.boatIndex});

  @override
  _MyBoatOverviewScreenState createState() => _MyBoatOverviewScreenState();
}

void customLaunch(command) async {
  if (await canLaunch(command)) {
    await launch(command);
  } else {
    print('Could not launch $command');
  }
}

class _MyBoatOverviewScreenState extends State<MyBoatOverviewScreen> {
  String _ownerName = '';
  String _ownerEmail = '';
  String _ownerPhoneNumber = '';

  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  // text field state
  String title = '';
  String userId = '';
  String boatCapacity = '';
  String description = '';
  String duration;
  String image = '';
  String location = '';
  String price = '';


  String error = '';


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
          stream: Firestore.instance.collection('boats').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Loading();
            } else {
              var boat = snapshot.data.documents[widget.boatIndex];

              final collRef = Firestore.instance.collection('boats');
              var docReference = collRef.document();


              log('test log: ' + docReference.documentID);

              title = boat['title'];
              userId = boat['userId'];
              boatCapacity = boat['boatCapacity'];
              description = boat['description'];
              duration = boat['duration'];
              image = boat['image'];
              location = boat['location'];
              price = boat['price'];

              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 1.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: new Column(
                          children: <Widget>[
                            Divider(
                              height: 60.0,
                              color: Colors.white,
                            ),
                            Align(
                              alignment: Alignment.center,
//                              child: GestureDetector(
//                                onTap: () {
////                                  getImage();
//                                },
//                                child: CircleAvatar(
//                                  radius: 100,
//                                  backgroundColor: Colors.blue,
//                                  child: ClipOval(
////                                    child: SizedBox(
////                                        width: 200.0,
////                                        height: 200.0,
////                                        child: (() {
////                                          if (_image != null) {
////                                            return Image.file(_image,
////                                                fit: BoxFit.cover);
////                                          } else if (tempProfileImage != null &&
////                                              tempProfileImage != "") {
////                                            return Image.network(
////                                              tempProfileImage,
////                                              fit: BoxFit.cover,
////                                            );
////                                          } else if (_image != null) {
////                                            return Image.file(_image,
////                                                fit: BoxFit.fill);
////                                          } else {
////                                            return Image.network(
////                                              'https://picsum.photos/250?image=9',
////                                              fit: BoxFit.cover,
////                                            );
////                                          }
////                                        }())),
//                                  ),
//                                ),
//                              ),
                            ),
                            Divider(height: 60.0, color: Colors.white),
                            new Row(
                              children: <Widget>[
                                new Expanded(
                                  child: new Padding(
                                    padding: const EdgeInsets.only(left: 40.0),
                                    child: new Text(
                                      "Title",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                  left: 40.0, right: 40.0),
                              alignment: Alignment.center,
                              padding:
                              const EdgeInsets.only(left: 0.0, right: 10.0),
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new Expanded(
                                    child: TextFormField(
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                        enabledBorder: new UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 0.8,
                                              style: BorderStyle.solid),
                                        ),
                                      ),
                                      initialValue: title,
                                      validator: (val) => val.isEmpty
                                          ? 'Enter title'
                                          : null,
                                      onChanged: (val) {
                                        title = val;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            new Row(
                              children: <Widget>[
                                new Expanded(
                                  child: new Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40.0, top: 25.0),
                                    child: new Text(
                                      "Description",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                  left: 40.0, right: 40.0),
                              alignment: Alignment.center,
                              padding:
                              const EdgeInsets.only(left: 0.0, right: 10.0),
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new Expanded(
                                    child: TextFormField(
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                        enabledBorder: new UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 0.8,
                                              style: BorderStyle.solid),
                                        ),
                                      ),
                                      initialValue: description,
                                      validator: (val) => val.isEmpty
                                          ? 'Enter description'
                                          : null,
                                      onChanged: (val) {
                                        description = val;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            new Row(
                              children: <Widget>[
                                new Expanded(
                                  child: new Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40.0, top: 25.0),
                                    child: new Text(
                                      "Duration",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                  left: 40.0, right: 40.0),
                              alignment: Alignment.center,
                              padding:
                              const EdgeInsets.only(left: 0.0, right: 10.0),
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new Expanded(
                                    child: TextFormField(
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                        enabledBorder: new UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 0.8,
                                              style: BorderStyle.solid),
                                        ),
                                      ),
                                      initialValue: duration,
                                      validator: (val) => val.isEmpty
                                          ? 'Enter a duration'
                                          : null,
                                      onChanged: (val) {
                                        duration = val;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            new Row(
                              children: <Widget>[
                                new Expanded(
                                  child: new Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40.0, top: 25.0),
                                    child: new Text(
                                      "Capacity",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                  left: 40.0, right: 40.0),
                              alignment: Alignment.center,
                              padding:
                              const EdgeInsets.only(left: 0.0, right: 10.0),
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new Expanded(
                                    child: TextFormField(
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                        enabledBorder: new UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                              width: 0.8,
                                              style: BorderStyle.solid),
                                        ),
                                      ),
                                      initialValue: boatCapacity,
                                      validator: (val) =>
                                      val.isEmpty ? 'Enter an email' : null,
                                      onChanged: (val) {
                                        boatCapacity = val;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(height: 24.0, color: Colors.white),
                            new Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                  left: 30.0, right: 30.0, top: 50.0),
                              alignment: Alignment.center,
                              child: new Row(
                                children: <Widget>[
                                  new Expanded(
                                    child: new FlatButton(
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                        new BorderRadius.circular(30.0),
                                      ),
                                      color: Colors.blueAccent,
                                      onPressed: () async {
                                        final FirebaseUser user =
                                        await _auth.currentUser();
                                        final uid = user.uid;
                                        if (_formKey.currentState.validate()) {
                                          Firestore.instance.runTransaction(
                                                  (transaction) async {
                                                await transaction.set(
                                                    Firestore.instance
                                                        .collection("boats").document(uid),
                                                    {
                                                      'image': 'https://firebasestorage.googleapis.com/v0/b/boatelthemobilecompany.appspot.com/o/image_picker_D8E5D13F-6CB3-41E4-A93D-A02F7C083003-13283-00005F63B17FCA7E.jpg?alt=media&token=3e971881-7803-493e-8c1f-724c264077cb',
                                                      'userId': uid,
                                                      'title': title,
                                                      'description': description,
                                                      'duration': duration,
                                                      'boatCapacity': boatCapacity,
                                                      'price': price,
                                                      'location': location
                                                    });
                                              });
//                                          Navigator.pushNamed(
//                                              context, HomePage.pageId);
                                        }
                                      },
                                      child: new Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20.0,
                                          horizontal: 20.0,
                                        ),
                                        child: new Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Expanded(
                                              child: Text(
                                                "SAVE",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
      bottomNavigationBar: new Container(
        color: Colors.blue,
        child: new MaterialButton(
          onPressed: () {
            showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 200,
                    color: Colors.blue,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Contact ' + _ownerName + ':'),
                          RaisedButton(
                            child: const Text('Email'),
                            onPressed: () => customLaunch(
                                'mailto:$_ownerEmail?subject=Help&body=I%20need%20help!'),
                          ),
                          RaisedButton(
                            child: const Text('SMS'),
                            onPressed: () =>
                                customLaunch('sms:$_ownerPhoneNumber'),
                          ),
                          RaisedButton(
                            child: const Text('Call'),
                            onPressed: () =>
                                customLaunch('tel:$_ownerPhoneNumber'),
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
