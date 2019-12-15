// import 'package:cloud_firestore/cloud_firestore.dart';

// class IsAvailableModel {
//   String cityId;
//   Map isAvailable;

//   IsAvailableModel({this.cityId, this.isAvailable});

//   factory IsAvailableModel.fromFirestore(DocumentSnapshot documentSnapshot){
//     Map data = documentSnapshot.data;
//     String cityId = documentSnapshot.documentID;
//     return IsAvailableModel(
//       cityId: cityId,
//       isAvailable: data['is_available'],
//     );
//   }
// }

// class IsAvailableService {
//   final Firestore _db = Firestore.instance;

//   Stream<IsAvailableModel> getAvailableData(String cityId){
//     return _db
//         .collection('data_updated')
//         .document(cityId)
//         .snapshots()
//         .map((snapshot) => IsAvailableModel.fromFirestore(snapshot)
//         );
//   }

// }