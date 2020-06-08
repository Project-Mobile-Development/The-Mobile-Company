import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_rectangle/Pages/MyAdvertisements.dart';
import 'package:hello_rectangle/shared/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart';

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

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      uploadPic();
    });
  }

  Future uploadPic() async {
    //TO MAKE IT MORE READABLE
    String fileName = basename(_image.path) + ".jpg";

    //GETTING THE FILE REFERENCE
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child(fileName);
    //PUT THE FILE INTO FIREBASE
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    //CHECK IF IT IS COMPLETED OR NOT
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    String url = (await firebaseStorageRef.getDownloadURL()).toString();

    image = url;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Boat Editing'),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('boats').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Loading();
            } else {
              var boat = snapshot.data.documents[widget.boatIndex];

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
                              child: GestureDetector(
                                onTap: () {
                                  getImage();
                                },
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundColor: Colors.blue,
                                  child: ClipOval(
                                    child: SizedBox(
                                        width: 200.0,
                                        height: 200.0,
                                        child: (() {
                                          if (_image != null) {
                                            return Image.file(_image,
                                                fit: BoxFit.cover);
                                          } else if (image != null &&
                                              image != "") {
                                            return Image.network(
                                              image,
                                              fit: BoxFit.cover,
                                            );
                                          } else if (_image != null) {
                                            return Image.file(_image,
                                                fit: BoxFit.fill);
                                          } else {
                                            return Image.network(
                                              'https://picsum.photos/250?image=9',
                                              fit: BoxFit.cover,
                                            );
                                          }
                                        }())),
                                  ),
                                ),
                              ),
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
                                      val.isEmpty ? 'Enter a capacity' : null,
                                      onChanged: (val) {
                                        boatCapacity = val;
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
                                      "Price",
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
                                      initialValue: price,
                                      validator: (val) =>
                                      val.isEmpty ? 'Enter a price' : null,
                                      onChanged: (val) {
                                        price = val;
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
                                      "Location",
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
                                      initialValue: location,
                                      validator: (val) =>
                                      val.isEmpty ? 'Enter a location' : null,
                                      onChanged: (val) {
                                        location = val;
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
                                                        .collection("boats").document(boat.documentID.toString()),
                                                    {
                                                      'image': image,
                                                      'userId': uid,
                                                      'title': title,
                                                      'description': description,
                                                      'duration': duration,
                                                      'boatCapacity': boatCapacity,
                                                      'price': price,
                                                      'location': location
                                                    });
                                              });
                                          Navigator.pushNamed(
                                              context, MyAdvertisements.pageId);
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
    );
  }
}
