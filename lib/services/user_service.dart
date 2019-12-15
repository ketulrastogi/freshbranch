import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

enum UserStatus { UPDATED, NOTUPDATED }

class UserService with ChangeNotifier {
  String userId;
  Firestore _db = Firestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel user;
  UserStatus userStatus = UserStatus.NOTUPDATED;

  getUser() {
    return _db
        .collection('users')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
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
          if (user.displayName != null &&
              user.city != null &&
              user.pincode != null &&
              user.email != null) {
            userStatus = UserStatus.UPDATED;
            notifyListeners();
          } else {
            userStatus = UserStatus.NOTUPDATED;
            notifyListeners();
          }
        } else {
          userStatus = UserStatus.NOTUPDATED;
          notifyListeners();
        }
      });
    });
  }


  Stream<UserModel> getCurrentUserDetails(String userId) {

    return _db
          .collection('users')
          .document(userId)
          .snapshots()
          .map((DocumentSnapshot documentSnapshot) => UserModel.fromFirestore(documentSnapshot));

      // return _db
      //     .collection('users')
      //     .where('userId', isEqualTo: 'G3B0opA5gcO6KKo61S0uv9DRDNu1')
      //     .snapshots()
      //     .map((QuerySnapshot querySnapshot) {
      //   return querySnapshot.documents.map((documentSnapshot) {
      //     return UserModel.fromFirestore(documentSnapshot);
      //   }).toList()[0];
      // });
  }

  Future<void> updateUserDetails(
      String userId,
      String displayName,
      String phoneNumber,
      String email,
      String city,
      String pincode,
      bool isAvailable) async {
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
