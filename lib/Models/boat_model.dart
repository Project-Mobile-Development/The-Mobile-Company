import 'user_model.dart';

class Boat {
  User owner;
  String title;
  String type;
  String image;
  String location;
  String price;
  String description;

  Boat(
      {this.owner,
        this.title,
        this.type,
        this.image,
        this.location,
        this.price,
        this.description});
}
