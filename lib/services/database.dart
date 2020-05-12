import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String name, String phoneNumber, String profileImage) async {
    print(name);
    print(phoneNumber);
    print(profileImage);
    return await userCollection.document(uid).setData({
      'name': name,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
    });
  }
}