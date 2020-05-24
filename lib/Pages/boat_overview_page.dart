import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Models/boat_model_list.dart';

class BoatOverviewScreen extends StatefulWidget {
  static String pageId = 'boatOverviewScreen';
  final int boatIndex;

  BoatOverviewScreen({this.boatIndex});

  @override
  _BoatOverviewScreenState createState() => _BoatOverviewScreenState();
}

class _BoatOverviewScreenState extends State<BoatOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance.collection('boats').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('Loading data.. Please Wait..');
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
                      Positioned(
                        child: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        top: size.height / 5,
                        left: size.width - 40.0,
                      ),
                      Positioned(
                        child: Icon(
                          Icons.comment,
                          color: Colors.white,
                        ),
                        top: size.height / 4,
                        left: size.width - 40.0,
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
                  child: Text(
                    snapshot.data.documents[widget.boatIndex]['title'],
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
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
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(''),
                            ),
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
                                          "Owned by",
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 3.0),
                                          child: Text(
                                            snapshot.data
                                                    .documents[widget.boatIndex]
                                                ['owner'],
                                            style: TextStyle(
                                                color: Color(0xFF1976D2)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: Color(0xFF1976D2),
                                ),
                                Text(
                                  snapshot.data.documents[widget.boatIndex]
                                      ['location'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
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
                      Text(
                        snapshot.data.documents[widget.boatIndex]['price'],
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: new Container(
        color: Colors.blue,
        child: new MaterialButton(
          onPressed: () {
            //  saveMoist();
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
