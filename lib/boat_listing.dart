import 'package:flutter/material.dart';

import 'form_listing.dart';
import 'header.dart';

class BoatListing extends StatefulWidget {
  @override
  _BoatListingState createState() => _BoatListingState();
}

class _BoatListingState extends State<BoatListing> {
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
              ), Stack(
                children: <Widget>[
                  FormListing(),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: new Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    const Color(0xFFFB7592),
                    const Color(0xFFF8A19B),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.9, 0.0),
                  stops: [0.0, 0.9],
                  tileMode: TileMode.clamp)),
          child: new MaterialButton(
            onPressed: () {
              //  saveMoist();
            },
            child: new Padding(
              padding: const EdgeInsets.all(30.0),
                child: new Text("Not filled in correctly",
                    style: new TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600)),
            ),
          ),
        ));
  }
}
