import 'package:flutter/material.dart';

class BoatOverviewScreen extends StatefulWidget {
  @override
  _BoatOverviewScreenState createState() => _BoatOverviewScreenState();
}

class _BoatOverviewScreenState extends State<BoatOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: CustomScrollView(
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
                    Image.asset(
                      'assets/images/boat1.jpeg',
                      fit: BoxFit.cover,
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
                padding: EdgeInsets.only(left: 10.0, bottom: 10.0, top: 40.0),
                child: Text(
                  "Family Boat",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
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
                            backgroundImage:
                                AssetImage('assets/images/women1.jpg'),
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
                                  "\€ 200 per day",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Owned by",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
                                        child: Text(
                                          "Sarah",
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
                                "Amsterdam",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "Enjoy the Amsterdam canals with my family party boat, a 6 meters long and 2 meters wide robust iron boat."
                              "There are soft pillows both at the front and back where you can lay down during the trip."
                              "There is also a couch upfront where you can chill and lay back with even two people.",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: new Container(
          decoration: new BoxDecoration(
              //   shape: BoxShape.circle,
              gradient: new LinearGradient(
                  colors: [
                    const Color(0xFF1976D2),
                    const Color(0xFF1976D2),
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
              padding: const EdgeInsets.all(24.0),
              child: new Text("Rent Now",
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ));
  }
}
