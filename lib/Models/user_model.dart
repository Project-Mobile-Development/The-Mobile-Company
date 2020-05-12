import 'dart:io';

class User {
  String uid;
  String firstName;
  String lastName;
  String email;
  String password;
  String phoneNumber;
  String
      tempProfileImage; // => will be replaced with the one below once the database is working, right now very useful for mock data
  File profileImage;

  User(
      {this.uid,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.phoneNumber,
      this.tempProfileImage,
      this.profileImage});
}
