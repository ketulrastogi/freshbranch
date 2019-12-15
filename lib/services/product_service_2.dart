
// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tathastu/services/data_update_service.dart';

// class ProductModel{

//   String id;
//   String englishName;
//   String gujaratiName;
//   String photoUrl;
//   bool isOrganic;
//   String minimumQuantityUnit;
//   num minimumQuantity;

//   ProductModel({ this.id, this.englishName, this.gujaratiName, this.photoUrl, this.isOrganic, this.minimumQuantityUnit, this.minimumQuantity, });

//   factory ProductModel.fromFirestore(DocumentSnapshot documentSnapshot){
//     Map data = documentSnapshot.data;
//     String id = documentSnapshot.documentID;
//     // print('ProductId : $id');
//     return ProductModel(
//       id: id,
//       englishName: data['english_name'],
//       gujaratiName: data['gujarati_name'],
//       photoUrl: data['photo_url'],
//       isOrganic: data['is_organic'],
//       minimumQuantityUnit: data['min_quantity_unit'],
//       minimumQuantity: data['min_quantity'],
//     );
//   }

// }



// class ProductService extends ChangeNotifier {
//   final Firestore _db = Firestore.instance;
//   final DataUpdateService dataUpdateService = DataUpdateService.instance();
//   ProductService.instance();

//   /// Get a stream of a single document
//   Stream<ProductModel> streamProduct(String id) {
//     return _db
//         .collection('products')
//         .document(id)
//         .snapshots()
//         .map((snapshot) => ProductModel.fromFirestore(snapshot));
//   }

//   saveProductsLocally() async{
//     SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
//     _db
//         .collection('products')
//         .snapshots()
//         .map((QuerySnapshot querySnapshot) => 
//               querySnapshot.documents.map((DocumentSnapshot documentSnapshot) => 
//                   ProductModel.fromFirestore(documentSnapshot)).toList())
//                     .listen((data){
//                         sharedPrefs.setString('products', jsonEncode(data).toString() );
//                     });
        
//   }
//   Future<List<ProductModel>> getProductsFromLocally(String cityId) async{
//     SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
//     dataUpdateService.saveDataUpdatedLocally(cityId).listen((data){
//       data.products.difference(DateTime.now());
//     });
//     return jsonDecode(sharedPrefs.get('products'));
//   }
// }
