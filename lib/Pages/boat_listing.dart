import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hello_rectangle/Models/user_model.dart';
import 'package:hello_rectangle/screens/home/home.dart';
import 'package:hello_rectangle/shared/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Models/boat_model.dart';
import 'package:path/path.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BoatListing extends StatefulWidget {
  static String pageId = 'boatListingPage';

  @override
  _BoatListingState createState() => _BoatListingState();
}

class _BoatListingState extends State<BoatListing> {
  var newBoat = new Boat();
  final _formKey = GlobalKey<FormState>();

  Future<File> imageFile;
  File _image;

  String title = '';
  String description = '';
  String startingTime = '';
  String duration = '';
  String boatCapacity = '';
  String boatImage = '';
  String price = '';
  String location = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Boat Listing'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Divider(
                      height: 60.0,
                      color: Colors.white,
                    ),
                    Center(
                        child: Padding(
                      padding: EdgeInsets.only(top: 15.0),
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
                                  return Image.file(_image, fit: BoxFit.cover);
                                } else if (boatImage != null &&
                                    boatImage != "") {
                                  return Image.network(
                                    boatImage,
                                    fit: BoxFit.cover,
                                  );
                                } else if (_image != null) {
                                  return Image.file(_image, fit: BoxFit.fill);
                                } else {
                                  return Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Select Image',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  );
                                }
                              }()),
                            ),
                          ),
                        ),
                      ),
                    )),
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
                      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
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
                              validator: (val) =>
                                  val.isEmpty ? 'Enter title' : null,
                              onChanged: (val) {
                                title = val;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 60.0, color: Colors.white),
                    new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 40.0),
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
                      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
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
                              validator: (val) =>
                                  val.isEmpty ? 'Enter description' : null,
                              onChanged: (val) {
                                description = val;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 60.0, color: Colors.white),
                    new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: new Text(
                              "Duration in minutes",
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
                      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                enabledBorder: new UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent,
                                      width: 0.8,
                                      style: BorderStyle.solid),
                                ),
                              ),
                              validator: (val) => val.isEmpty
                                  ? 'Enter duration of the boat tour'
                                  : null,
                              onChanged: (val) {
                                duration = val;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 60.0, color: Colors.white),
                    new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: new Text(
                              "Boat Capacity",
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
                      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                enabledBorder: new UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent,
                                      width: 0.8,
                                      style: BorderStyle.solid),
                                ),
                              ),
                              validator: (val) => val.isEmpty
                                  ? 'Enter a maximum capacity for the boat tour'
                                  : null,
                              onChanged: (val) {
                                boatCapacity = val;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 60.0, color: Colors.white),
                    new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: new Text(
                              "Price per hour",
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
                      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                enabledBorder: new UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent,
                                      width: 0.8,
                                      style: BorderStyle.solid),
                                ),
                              ),
                              validator: (val) => val.isEmpty
                                  ? 'Enter a price for the boat tour'
                                  : null,
                              onChanged: (val) {
                                price = val;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 60.0, color: Colors.white),
                    new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 40.0),
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
                      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
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
                              validator: (val) => val.isEmpty
                                  ? 'Enter a starting location for your boat tour'
                                  : null,
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
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              color: Colors.blueAccent,
                              onPressed: () async {
                                final FirebaseUser user =
                                    await _auth.currentUser();
                                final uid = user.uid;
                                if (_formKey.currentState.validate()) {
                                  if (boatImage != '') {
                                    Firestore.instance
                                        .runTransaction((transaction) async {
                                      await transaction.set(
                                          Firestore.instance
                                              .collection("boats")
                                              .document(),
                                          {
                                            'userId': uid,
                                            'image': boatImage,
                                            'title': title,
                                            'description': description,
                                            'duration': duration,
                                            'boatCapacity': boatCapacity,
                                            'price': price,
                                            'location': location
                                          });
                                    });
                                  }
                                  Navigator.pushNamed(context, HomePage.pageId);
                                }
                              },
                              child: new Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 20.0,
                                ),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Expanded(
                                      child: Text(
                                        "List Boat",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
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
                    Divider(height: 60.0, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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

    boatImage = url;
  }

  Widget showImage() {
    uploadPic();
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        return (_image != null)
            ? Image.file(_image, fit: BoxFit.fill)
            : Center(child: Text('Pick image'));
      },
    );
  }
}
