import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
//      clipper: BottomWaveClipper(),
      child: Container(
        height: 125.0,
        decoration: new BoxDecoration(
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}