import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello_rectangle/Models/user_model.dart';
import 'package:hello_rectangle/services/database.dart';
import 'package:hello_rectangle/shared/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Models/boat_model.dart';
import '../Widgets/boat_filter_list.dart';
import '../Widgets/header.dart';
import '../Widgets/header_filter.dart';
import 'home_page.dart';

class BoatListing extends StatefulWidget {
  @override
  _BoatListingState createState() => _BoatListingState();
}

class _BoatListingState extends State<BoatListing> {
  var newBoat = new Boat();
  final _formKey = GlobalKey<FormState>();
  Future<File> imageFile;

  String title = '';
  String price = '';
  String location = '';
  String description = '';

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
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

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return new Container(
              width: 140.0,
              height: 140.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  image: Image.file(
                    snapshot.data,
                    width: 300,
                    height: 300,
                  ).image,
                  fit: BoxFit.cover,
                ),
              ));
        } else if (snapshot.error != null) {
          return const Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Text(
                'Error picking an image',
                textAlign: TextAlign.center,
              ));
        } else {
          return const Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Text(
                'Add an image',
                textAlign: TextAlign.center,
              ));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);


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
                      )),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Title'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter a title' : null,
                        onChanged: (val) {
                          setState(() => title = val);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Container(
                          padding: EdgeInsets.only(left: 0.0),
                          height: 75.0,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: boatIconsList.icons.length,
                              itemBuilder: (context, index) {
                                return _buildBoatIconsList(context, index);
                              }),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                        textInputDecoration.copyWith(hintText: 'Price'),
                        validator: (val) =>
                        val.isEmpty ? 'Enter a price' : null,
                        onChanged: (val) {
                          setState(() => price = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                        textInputDecoration.copyWith(hintText: 'Location'),
                        validator: (val) =>
                        val.isEmpty ? 'Enter a location' : null,
                        onChanged: (val) {
                          setState(() => location = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                        textInputDecoration.copyWith(hintText: 'Description'),
                        validator: (val) =>
                        val.isEmpty ? 'Enter a description' : null,
                        onChanged: (val) {
                          setState(() => description = val);
                        },
                      ),
                    ],
                  ),
                ),
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
            onPressed: () async {
              if (_formKey.currentState.validate()) {
               Firestore.instance.runTransaction((transaction) async {
                  await transaction.set(Firestore.instance.collection("boats").document(), {
                    'owner': 'test owner',
                    'title': title,
                    'type': 'test type',
                    'image': 'assets/images/boat3.jpg',
                    'location': location,
                    'price': price,
                    'description': description,
                  });
                });
              }

              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
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
