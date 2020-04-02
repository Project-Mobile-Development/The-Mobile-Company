import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hello_rectangle/boat_model.dart';
import 'package:image_picker/image_picker.dart';

import 'header.dart';

class BoatListing extends StatefulWidget {
  @override
  _BoatListingState createState() => _BoatListingState();
}

class _BoatListingState extends State<BoatListing> {
  var newBoat = new Boat();
  final _formKey = GlobalKey<FormState>();
  Future<File> imageFile;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: IconButton(
                          icon: Icon(Icons.arrow_downward),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Color(0xFFFCFCFC),
                          iconSize: 30.0,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 70.0),
                      child: Text(
                        "List your boat",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFCFCFC)),
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
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              pickImageFromGallery(ImageSource.gallery);
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
                              child: showImage(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Enter a title',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Enter a price'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Enter a location'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Enter a Description'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: new Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    const Color(0xFF81C784),
                    const Color(0xFFA5D6A7),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.9, 0.0),
                  stops: [0.0, 0.9],
                  tileMode: TileMode.clamp)),
          child: new MaterialButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                // If the form is valid, display a Snackbar.
//                Scaffold.of(context)
//                    .showSnackBar(SnackBar(content: Text('Processing Data')));
              }
            },
            child: new Padding(
              padding: const EdgeInsets.all(30.0),
              child: new Text("List boat",
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ));
  }
}
