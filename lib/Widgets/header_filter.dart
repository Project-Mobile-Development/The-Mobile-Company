import 'package:flutter/material.dart';
import 'package:hello_rectangle/Widgets/boat_filter_list.dart';

class HeaderFilter extends StatefulWidget {
  final int iconIndex;

  HeaderFilter({this.iconIndex});

  @override
  _HeaderFilter createState() => _HeaderFilter();
}

class _HeaderFilter extends State<HeaderFilter> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
//      clipper: BottomWaveClipper(),
      child: Container(
        height: 75.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            RaisedButton(
              color: Color(0xFFECEFF1),
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      boatIconsList.icons[widget.iconIndex].icon,
                      color: Colors.black,
                      size: 35.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      boatIconsList.icons[widget.iconIndex].name,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ],
        ),
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFFB0BEC5),
                  const Color(0xFFECEFF1),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 0.9),
                stops: [0.0, 0.9],
                tileMode: TileMode.clamp)),
      ),
    );
  }
}