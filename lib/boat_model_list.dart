import 'dart:ui';

class Boat {
  final String type;
  final String image;
  final String location;
  final String price;

  Boat({this.type, this.image, this.location, this.price});
}

class BoatModelList {
  final List<Boat> boat;

  BoatModelList({this.boat});
}

final BoatModelList boatList = new BoatModelList(
  boat: [
    Boat(
      type: "Family Boat",
      image: "assets/images/boat1.jpeg",
      location: "Amsterdam",
      price: "\€ 200 per day",
    ),
    Boat(
      type: "Family Boat",
      image: "assets/images/boat1.jpeg",
      location: "Amsterdam",
      price: "\€ 200 per day",
    ),
    Boat(
      type: "Family Boat",
      image: "assets/images/boat1.jpeg",
      location: "Amsterdam",
      price: "\€ 200 per day",
    ),
    Boat(
      type: "Family Boat",
      image: "assets/images/boat1.jpeg",
      location: "Amsterdam",
      price: "\€ 200 per day",
    ),
    Boat(
      type: "Family Boat",
      image: "assets/images/boat1.jpeg",
      location: "Amsterdam",
      price: "\€ 200 per day",
    ),
    Boat(
      type: "Family Boat",
      image: "assets/images/boat1.jpeg",
      location: "Amsterdam",
      price: "\€ 200 per day",
    ),
    Boat(
      type: "Family Boat",
      image: "assets/images/boat1.jpeg",
      location: "Amsterdam",
      price: "\€ 200 per day",
    ),
    Boat(
      type: "Family Boat",
      image: "assets/images/boat1.jpeg",
      location: "Amsterdam",
      price: "\€ 200 per day",
    ),
    Boat(
      type: "Family Boat",
      image: "assets/images/boat1.jpeg",
      location: "Amsterdam",
      price: "\€ 200 per day",
    ),
  ],
);
