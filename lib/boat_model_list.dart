import 'user_model.dart';
import 'boat_model.dart';

class BoatModelList {
  final List<Boat> boats;

  BoatModelList({this.boats});
}

var user = new User(
    firstName: "Sarah",
    lastName: "Eikenhout",
    email: "sarahEikenhout@hotmail.com",
    phoneNumber: "0634567654",
    profileImage: "assets/images/women1.jpg");

var boat = new Boat(
    owner: user,
    type: "Family Boat",
    image: "assets/images/boat1.jpeg",
    location: "Amsterdam",
    price: "\€ 200 per day",
    description:
        "Enjoy the Amsterdam canals with my family party boat, a 6 meters long and 2 meters wide robust iron boat."
        "There are soft pillows both at the front and back where you can lay down during the trip."
        "There is also a couch upfront where you can chill and lay back with even two people.");

final BoatModelList boatList = new BoatModelList(
  boats: [
    boat,
    boat,
    boat,
    boat,
    boat,
    boat,
    boat,
  ],
);
