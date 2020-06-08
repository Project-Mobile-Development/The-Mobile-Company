import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello_rectangle/Pages/MyAdvertisements.dart';
import 'package:hello_rectangle/services/auth.dart';
import 'package:hello_rectangle/shared/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hello_rectangle/screens/home/home.dart';
import 'dart:io';
import 'package:path/path.dart';

class ProfileInfo extends StatefulWidget {
  //MANDATORY VARIABLE IN EVERY PAGE FOR ROUTING PURPOSES
  static String pageId = 'profileInfoPage';

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService __auth = AuthService();

  File _image;
  Future<File> imageFile;

  String _uid = '';

  // text field state
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  String email = '';
  String tempProfileImage;
  String password = '';

  String error = '';

  Stream<DocumentSnapshot> firestoreInstance;

  getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();

    setState(() {
      _uid = user.uid;
    });

    firestoreInstance = Firestore.instance.collection('users').document(_uid).snapshots();
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

    tempProfileImage = url;
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile info'),
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
                FontAwesomeIcons.home,
                size: 40.0,
              ),
              title: Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, HomePage.pageId);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.ship,
                size: 35.0,
              ),
              title: Text('My Advertisements'),
              onTap: () {
                Navigator.pushNamed(context, MyAdvertisements.pageId);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.userCircle,
                size: 40.0,
              ),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
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
      body: StreamBuilder(
          stream: firestoreInstance,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Loading();
            } else {
              var user = snapshot.data;
              if (user['firstName'] == "" || user['firstname'] == '') {
                firstName = " ";
                lastName = " ";
                phoneNumber = " ";
                email = " ";
                tempProfileImage = " ";
                password = " ";
              } else {
                firstName = user['firstName'];
                lastName = user['lastName'];
                phoneNumber = user['phoneNumber'];
                email = user['email'];
                tempProfileImage = user['tempProfileImage'];
                password = user['password'];
              }

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
                                          } else if (tempProfileImage != null &&
                                              tempProfileImage != "") {
                                            return Image.network(
                                              tempProfileImage,
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
                                      "FIRST NAME",
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
                                      initialValue: firstName,
                                      validator: (val) => val.isEmpty
                                          ? 'Enter first Name'
                                          : null,
                                      onChanged: (val) {
                                        firstName = val;
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
                                      "LAST NAME",
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
                                      initialValue: lastName,
                                      validator: (val) => val.isEmpty
                                          ? 'Enter last Name'
                                          : null,
                                      onChanged: (val) {
                                        lastName = val;
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
                                      "PHONE NUMBER",
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
                                      initialValue: phoneNumber,
                                      validator: (val) => val.isEmpty
                                          ? 'Enter phone Number'
                                          : null,
                                      onChanged: (val) {
                                        phoneNumber = val;
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
                                      "EMAIL",
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
                                      initialValue: email,
                                      validator: (val) =>
                                          val.isEmpty ? 'Enter an email' : null,
                                      onChanged: (val) {
                                        email = val;
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
                                                    .collection("users")
                                                    .document(uid),
                                                {
                                                  'tempProfileImage':
                                                      tempProfileImage,
                                                  'firstName': firstName,
                                                  'lastName': lastName,
                                                  'email': email,
                                                  'phoneNumber': phoneNumber,
                                                  'password': password
                                                });
                                          });
                                          Navigator.pushNamed(
                                              context, HomePage.pageId);
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
