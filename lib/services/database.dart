import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:hello_rectangle/Models/user_model.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  final CollectionReference boatCollection = Firestore.instance.collection('boats');


  Future updateUserData(String firstName, String lastName, String email, String password, String phoneNumber, String tempProfileImage) async {
    return await userCollection.document(uid).setData({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'tempProfileImage': tempProfileImage,
//      'profileImage': profileImage,
    });
  }

  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }

  Stream<QuerySnapshot> get boats {
    return boatCollection.snapshots();
  }
}