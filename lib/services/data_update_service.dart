
// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DataUpdateModel{

//   String id;
//   DateTime isAvailable;
//   DateTime price;
//   DateTime products;

//   DataUpdateModel({ this.id, this.isAvailable, this.price, this.products });

//   factory DataUpdateModel.fromFirestore(DocumentSnapshot documentSnapshot){
//     Map data = documentSnapshot.data;
//     String id = documentSnapshot.documentID;
//     // print('ProductId : $id');
//     return DataUpdateModel(
//       id: id,
//       isAvailable: data['is_available'],
//       price: data['price'],
//       products: data['products']
//     );
//   }

// }



// class DataUpdateService extends ChangeNotifier {
//   final Firestore _db = Firestore.instance;

//   DataUpdateService.instance();

//   /// Get a stream of a single document
//   saveDataUpdatedLocally(String id) async{
//     SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
//     _db
//         .collection('products')
//         .document(id)
//         .snapshots()
//         .map((snapshot) => DataUpdateModel.fromFirestore(snapshot))
//         .listen((data) async{

//           DataUpdateModel localData = await jsonDecode(sharedPrefs.getString('dataUpdated'));

//           if(data.products.difference(localData.products).inMinutes > 2){
//             await sharedPrefs.setString('dataUpdated', jsonEncode(data).toString() );
//           }
//         });
//   }

//   getDataUpdatedLocally(String id) async{
//     SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

//     DataUpdateModel dataUpdateModel = await jsonDecode(sharedPrefs.getString('dataUpdated'));

//   }

//   Stream<List<DataUpdateModel>> streamProductList(){
//     return _db
//         .collection('products')
//         .snapshots()
//         .map((QuerySnapshot querySnapshot) => querySnapshot.documents.map((DocumentSnapshot documentSnapshot) => DataUpdateModel.fromFirestore(documentSnapshot)).toList());
        
//   }
// }
