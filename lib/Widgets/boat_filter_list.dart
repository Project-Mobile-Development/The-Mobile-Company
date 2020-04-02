import 'package:flutter/material.dart';
import 'package:hello_rectangle/Models/boat_filter_model.dart';


class BoatIconsList {
  final List<BoatIcons> icons;

  BoatIconsList({this.icons});
}

// ---- MOCK DATA (START) ----

var boatIcon1 = new BoatIcons(
    name: "Boat1",
    icon: Icons.directions_boat,
);
var boatIcon2 = new BoatIcons(
  name: "Boat2",
  icon: Icons.directions_boat,
);
var boatIcon3 = new BoatIcons(
  name: "Boat3",
  icon: Icons.directions_boat,
);
var boatIcon4 = new BoatIcons(
  name: "Boat4",
  icon: Icons.directions_boat,
);
var boatIcon5 = new BoatIcons(
  name: "Boat5",
  icon: Icons.directions_boat,
);
var boatIcon6 = new BoatIcons(
  name: "Boat6",
  icon: Icons.directions_boat,
);
var boatIcon7 = new BoatIcons(
  name: "Boat7",
  icon: Icons.directions_boat,
);

// ---- MOCK DATA (END) ----


final BoatIconsList boatIconsList = new BoatIconsList(
  icons: [boatIcon1, boatIcon2, boatIcon3, boatIcon4, boatIcon5, boatIcon6, boatIcon7],
);
