import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
//      clipper: BottomWaveClipper(),
      child: Container(
        height: 125.0,
        decoration: new BoxDecoration(
            gradient: new LinearGradient(colors: [
              const Color(0xFF0D47A1),
              const Color(0xFF1976D2),
            ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.9, 0.0),
                stops: [0.0, 0.9],
                tileMode: TileMode.clamp
            )
        ),
      ),
    );
  }
}