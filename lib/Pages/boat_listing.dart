import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  //THINK THEY SHOULD BE ALL PRIVATE VARIABLES (add _ at the start)
  String title = '';
  String description = '';

  //POST MINUTES
  String startingTime = '';
  String duration = '';

  //PROBABLY BETTER TO SAVE IT AS A STRING
  String boatCapacity = '';

  //PROBABLY BETTER TO SAVE IT AS A FLOAT WITH ONE DECIMAL NUMBER
  String price = '';

  //MAYBE CHANGE IT IN THE FUTURE TO USE GEODATA (NOT YET THO) - Google API
  String location = '';

  String _url = '';

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      //print('Image Path $_image');
    });
  }

  Future uploadPic() async {
    //TO MAKE IT MORE READABLE
    String fileName = basename(_image.path);
    //GETTING THE FILE REFERENCE
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child(fileName);
    //PUT THE FILE INTO FIREBASE
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    //CHECK IF IT IS COMPLETED OR NOT
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    String url = (await firebaseStorageRef.getDownloadURL()).toString();

    setState(() {
      _url = url;
      //print('Image Path $_image');
    });
  }

  Widget showImage() {
    uploadPic();
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        return (_image != null)
            ? Image.file(_image, fit: BoxFit.fill)
            : Center(child: Text(
            'Pick image'
        ));
      },
    );
  }

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
        title: Text('Profile Info'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//            Stack(
//              children: <Widget>[
//                Header(),
//                GestureDetector(
//                  onTap: () {
//                    Navigator.pop(context);
//                  },
//                  child: Align(
//                    alignment: Alignment.bottomLeft,
//                    child: Padding(
//                      padding: const EdgeInsets.only(top: 60.0),
//                      child: IconButton(
//                        icon: Icon(Icons.arrow_downward),
//                        onPressed: () {
//                          Navigator.pop(context);
//                        },
//                        color: Color(0xFFFCFCFC),
//                        iconSize: 30.0,
//                      ),
//                    ),
//                  ),
//                ),
//                Align(
//                  alignment: Alignment.bottomCenter,
//                  child: Padding(
//                    padding: EdgeInsets.only(top: 70.0),
//                    child: Text(
//                      "List your boat",
//                      style: TextStyle(
//                          fontSize: 20.0,
//                          fontWeight: FontWeight.bold,
//                          color: Color(0xFFFCFCFC)),
//                    ),
//                  ),
//                ),
//                Padding(
//                  padding: EdgeInsets.only(
//                    top: 40.0,
//                    left: 10.0,
//                  ),
//                  child: Align(
//                    alignment: Alignment.topLeft,
//                  ),
//                )
//              ],
//            ),
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: GestureDetector(
                            onTap: () {
                              getImage();
                            },
                            child: Container(
                                width: 140.0,
                                height: 140.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: new Border.all(
                                      color: Colors.blue,
                                      width: 2.0,
                                      style: BorderStyle.solid),
                                ),
                                child: showImage()),
                          ),
                        )),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                      kTextInputDecoration.copyWith(hintText: 'Title*'),
                      validator: (val) => val.isEmpty ? 'Enter a title' : null,
                      onChanged: (val) {
                        setState(() => title = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: kTextInputDecoration.copyWith(
                          hintText: 'Description*'),
                      validator: (val) =>
                      val.isEmpty ? 'Enter a description' : null,
                      onChanged: (val) {
                        setState(() => description = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: kTextInputDecoration.copyWith(
                          hintText: 'Duration in minutes*'),
                      validator: (val) =>
                      val.isEmpty
                          ? 'Enter a duration of the boat tour'
                          : null,
                      onChanged: (val) {
                        setState(() => description = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: kTextInputDecoration.copyWith(
                          hintText: 'Boat Capacity*'),
                      validator: (val) =>
                      val.isEmpty
                          ? 'Enter a maximum capacity for the boat tour'
                          : null,
                      onChanged: (val) {
                        setState(() => description = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration:
                      kTextInputDecoration.copyWith(hintText: 'Price*'),
                      validator: (val) =>
                      val.isEmpty
                          ? 'Enter a price for the boat tour'
                          : null,
                      onChanged: (val) {
                        setState(() => price = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                      kTextInputDecoration.copyWith(hintText: 'Location*'),
                      validator: (val) =>
                      val.isEmpty
                          ? 'Enter a starting location for your boat tour'
                          : null,
                      onChanged: (val) {
                        setState(() => location = val);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton.extended(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  if (_url != '') {
                    Firestore.instance.runTransaction((transaction) async {
                      await transaction.set(
                          Firestore.instance.collection("boats").document(), {
                        'owner': 'test owner',
                        'title': title,
                        'type': 'test type',
                        'image': _url,
                        'location': location,
                        'price': price,
                        'description': description,
                      });
                    });
                  }

                  Navigator.pushNamed(context, HomePage.pageId);
                }
              },
              label: Text(
                'List Boat',
                style: kFloatingButtonTextStyle,
              ),
              icon: Icon(
                FontAwesomeIcons.plusCircle,
                size: 25.0,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//      bottomNavigationBar: Container(
//        decoration: BoxDecoration(
//            gradient: LinearGradient(
//                colors: [
//                  const Color(0xFF81C784),
//                  const Color(0xFFA5D6A7),
//                ],
//                begin: const FractionalOffset(0.0, 0.0),
//                end: const FractionalOffset(0.9, 0.0),
//                stops: [0.0, 0.9],
//                tileMode: TileMode.clamp)),
//        child: MaterialButton(
//          onPressed: () async {
//            if (_formKey.currentState.validate()) {
//              Firestore.instance.runTransaction((transaction) async {
//                await transaction
//                    .set(Firestore.instance.collection("boats").document(), {
//                  'owner': 'test owner',
//                  'title': title,
//                  'type': 'test type',
//                  'image': uploadPic(context),
//                  'location': location,
//                  'price': price,
//                  'description': description,
//                });
//              });
//              Navigator.pushNamed(context, HomePage.pageId);
//            }
//          },
//          child: Padding(
//            padding: const EdgeInsets.all(30.0),
//            child: Text("List boat",
//                style: TextStyle(
//                    color: Colors.white,
//                    fontSize: 22.0,
//                    fontWeight: FontWeight.w600)),
//          ),
//        ),
//      ),
    );
  }
}
