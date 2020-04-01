import 'user_model.dart';

class Boat {
  User owner;
  String type;
  String image;
  String location;
  String price;
  String description;

  Boat(
      {this.owner,
      this.type,
      this.image,
      this.location,
      this.price,
      this.description});
}
