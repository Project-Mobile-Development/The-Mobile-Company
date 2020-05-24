import 'dart:io';

class User {
  String uid;
  String firstName;
  String lastName;
  String email;
  String password;
  String phoneNumber;
  //TODO: SAVE IMAGE URL IN FIREBASE AND IMAGE IN FIRESTORAGE
  String
      profileImageURL; // => will be replaced with the one below once the database is working, right now very useful for mock data
  File profileImage;

  User(
      {this.uid,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.phoneNumber,
      this.profileImageURL,
      this.profileImage});

  User.fromData(Map<String, dynamic> data)
      : uid = data['id'],
        firstName = data['fullName'],
        email = data['email'];

  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'fullName': firstName,
      'email': email,
    };
  }
}
