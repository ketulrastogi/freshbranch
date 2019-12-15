import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freshbranch/services/city_service.dart';

class UserModel {
  String uid;
  String phoneNumber;
  String displayName;
  String email;
  String city;
  String pincode;

  UserModel(
      {this.uid,
      this.phoneNumber,
      this.displayName,
      this.email,
      this.city,
      this.pincode});

  factory UserModel.fromFirestore(DocumentSnapshot documentSnapshot) {
    Map data = documentSnapshot.data;
    String id = documentSnapshot.documentID;

    return UserModel(
      uid: id,
      phoneNumber:
          (data.containsKey('phoneNumber') && data['phoneNumber'] != null)
              ? data['phoneNumber']
              : null,
      displayName:
          (data.containsKey('displayName') && data['displayName'] != null)
              ? data['displayName']
              : null,
      email: (data.containsKey('email') && data['email'] != null)
          ? data['email']
          : null,
      city: (data.containsKey('city') && data['city'] != null)
          ? data['city']
          : null,
      pincode: (data.containsKey('pincode') && data['pincode'] != null)
          ? data['pincode']
          : null,
    );
  }
}

class UserService with ChangeNotifier{
  String userId;
  Firestore _db;
  UserModel user;
  UserService.instance(this.userId) : _db = Firestore.instance {
    _db
        .collection('users')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      querySnapshot.documents.map((DocumentSnapshot documentSnapshot) {
        Map<String, dynamic> data = documentSnapshot.data;
        if (data != null) {
          user.uid = userId;
          user.displayName =
              (data.containsKey('displayName') && data['displayName'] != null)
                  ? data['displayName']
                  : null;
          user.email = (data.containsKey('email') && data['email'] != null)
              ? data['email']
              : null;
          user.city = (data.containsKey('city') && data['city'] != null)
              ? data['city']
              : null;
          user.pincode =
              (data.containsKey('pincode') && data['pincode'] != null)
                  ? data['pincode']
                  : null;
        }
      });
    });
  }

  Stream<UserModel> getCurrentUserDetails(String uid) {
    return _db
        .collection('users')
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.documents.map((documentSnapshot) {
        return UserModel.fromFirestore(documentSnapshot);
      }).toList()[0];
    });
  }

  Future<void> updateUserDetails(String userId, String displayName, String phoneNumber, String email, String city, String pincode, bool isAvailable) async {
    print('User Service - 94 : $userId');
    await _db.collection('users').document(userId).setData({
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'email': email,
      'city': city,
      'pincode': pincode,
      'isAvailable': isAvailable,
    }, merge: true);
  }

  Future<void> updateDisplayName(String uid, String displayName) async {
    await _db
        .collection('users')
        .document(uid)
        .setData({'displayName': displayName}, merge: true);
  }

  Future<void> updateEmail(String uid, String email) async {
    await _db
        .collection('users')
        .document(uid)
        .setData({'email': email}, merge: true);
  }

  Future<void> updateUserCity(String uid, String city, String pincode) async {
    await _db
        .collection('users')
        .document(uid)
        .setData({'city': city, 'pincode': pincode}, merge: true);
  }
}
