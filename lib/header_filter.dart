import 'package:flutter/material.dart';

class HeaderFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
//      clipper: BottomWaveClipper(),
      child: Container(
        height: 75.0,
        decoration: new BoxDecoration(
            gradient: new LinearGradient(colors: [
              const Color(0xFFB0BEC5),
              const Color(0xFFECEFF1),
            ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 0.9),
                stops: [0.0, 0.9],
                tileMode: TileMode.clamp

            )
        ),
      ),
    );
  }
}