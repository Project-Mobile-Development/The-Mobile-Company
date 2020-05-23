import 'dart:ffi';

import 'user_model.dart';

class Boat {
  User owner;
  String title;
  String type;
  String imageURL;
  String location;
  String price;
  String description;

  Boat(
      {this.owner,
      this.title,
      this.type,
      this.imageURL,
      this.location,
      this.price,
      this.description});
}
