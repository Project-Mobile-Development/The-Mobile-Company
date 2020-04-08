import 'boat_model.dart';
import 'user_model.dart';

class BoatModelList {
  final List<Boat> boats;

  BoatModelList({this.boats});
}

// ---- MOCK DATA (START) ----

var user1 = new User(
    firstName: "Sarah",
    lastName: "Eikenhout",
    email: "sarahEikenhout@hotmail.com",
    phoneNumber: "0634567654",
    tempProfileImage: "assets/images/woman1.jpg");

var user2 = new User(
    firstName: "Lewis",
    lastName: "Stone",
    email: "lewisStone@hotmail.com",
    phoneNumber: "0665594632",
    tempProfileImage: "assets/images/man2.jpeg");

var user3 = new User(
    firstName: "Linda",
    lastName: "Ford",
    email: "lindaFord@hotmail.com",
    phoneNumber: "0653458986",
    tempProfileImage: "assets/images/woman2.jpeg");

var user4 = new User(
    firstName: "Bas",
    lastName: "Beek",
    email: "basBeek@hotmail.com",
    phoneNumber: "0665594632",
    tempProfileImage: "assets/images/man1.jpeg");

var user5 = new User(
    firstName: "Kara",
    lastName: "Awiwi",
    email: "karaAwiwi@hotmail.com",
    phoneNumber: "0635674871",
    tempProfileImage: "assets/images/woman3.jpg");

var boat1 = new Boat(
    owner: user1,
    title: "Affordable party yacht",
    type: "Yacht",
    image: "assets/images/boat1.jpg",
    location: "Amsterdam",
    price: "\€ 500 per hour",
    description:
        "Enjoy the open seas with a yacht that is made for partying, it has state of the art sound systems."
        "There are soft pillows both at the front and back where you can lay down during the trip."
        "There is also a couch upfront where you can chill and lay back with even two people.");

var boat2 = new Boat(
    owner: user2,
    title: "Sail like days of ye olde",
    type: "Sail Boat",
    image: "assets/images/boat2.jpg",
    location: "Brabant",
    price: "\€ 100 per day",
    description:
        "This sailing boat is for those who are not afraid to sail the seven seas in the classic way");

var boat3 = new Boat(
    owner: user3,
    title: "Top of the line speed boat",
    type: "Speed Boat",
    image: "assets/images/boat3.jpg",
    location: "Den Haag",
    price: "\€ 50 per hour",
    description: "Become a dare devil with this speed boat that is powered by a top of the line motor!");

var boat4 = new Boat(
    owner: user4,
    title: "Romantic rowing boat",
    type: "Rowing Boat",
    image: "assets/images/boat4.jpg",
    location: "Friesland",
    price: "\€ 100 per day",
    description:
        "Embrace your adventorous spirit with this beautiful rowing boat.");

var boat5 = new Boat(
    owner: user5,
    title: "High security cargo boat",
    type: "Cargo Boat",
    image: "assets/images/boat5.jpg",
    location: "Rotterdam",
    price: "\€ 4000 per week",
    description:
        "Rent this well kept private cargo boat to transport your valuable goods.");

// ---- MOCK DATA (END) ----

final BoatModelList boatList = new BoatModelList(
  boats: [boat1, boat2, boat3, boat4, boat5],
);
