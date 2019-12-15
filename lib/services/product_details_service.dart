// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:tathastu/services/is_available_service.dart';
// import 'package:tathastu/services/price_service.dart';
// import 'package:tathastu/services/product_service_2.dart';

// class ProductDetailModel {
//   String id;
//   String englishName;
//   String gujaratiName;
//   String photoUrl;
//   bool isOrganic;
//   String minimumQuantityUnit;
//   num minimumQuantity;
//   num pricePerKg;
//   String isAvailable;

//   ProductDetailModel(
//       {this.id,
//       this.englishName,
//       this.gujaratiName,
//       this.photoUrl,
//       this.isOrganic,
//       this.minimumQuantityUnit,
//       this.minimumQuantity,
//       this.pricePerKg,
//       this.isAvailable});

//   factory ProductDetailModel.fromOtherModels(
//       DocumentSnapshot productDocumentSnapshot,
//       DocumentSnapshot priceDocumentSnapshot,
//       DocumentSnapshot isAvailableDocumentSnapshot) {
//     ProductDetailModel productDetailModel = ProductDetailModel();

//     // productDocumentSnapshots.map((DocumentSnapshot productDocumentSnapshot) {
      
//         ProductModel productModel = ProductModel.fromFirestore(productDocumentSnapshot);
//         PriceModel priceModel = PriceModel.fromFirestore(priceDocumentSnapshot);
//         IsAvailableModel isAvailableModel = IsAvailableModel.fromFirestore(isAvailableDocumentSnapshot);


//         productDetailModel.id = productModel.id;
//         productDetailModel.englishName = productModel.englishName;
//         productDetailModel.gujaratiName = productModel.gujaratiName;
//         productDetailModel.photoUrl = productModel.photoUrl;
//         productDetailModel.isOrganic = productModel.isOrganic;
//         productDetailModel.minimumQuantity = productModel.minimumQuantity;
//         productDetailModel.minimumQuantityUnit =
//             productModel.minimumQuantityUnit;

//         PriceModel.fromFirestore(priceDocumentSnapshot);
//           productDetailModel.pricePerKg = priceModel.prices[productModel.id];
//         productDetailModel.isAvailable =
//               isAvailableModel.isAvailable[productModel.id];

        
//     // });

//     return productDetailModel;
//   }
// }

// class ProductDetailService extends ChangeNotifier {
//   final Firestore _db = Firestore.instance;

//   ProductDetailService.instance() {}

//   /// Get a stream of a single document
//   Stream<ProductModel> streamProduct(String id) {
//     return _db
//         .collection('products')
//         .document(id)
//         .snapshots()
//         .map((snapshot) => ProductModel.fromFirestore(snapshot));
//   }

//   Stream<List<ProductDetailModel>> streamProductList(String cityId) {


//     return _db
//         .collection('products')
//         .snapshots()
//         .map((QuerySnapshot querySnapshot) {
//       return querySnapshot.documents
//           .map((DocumentSnapshot productDocumentSnapshot) {

//         DocumentSnapshot priceDocumentSnapshot = _db
//         .collection('prices')
//         .document(cityId)
//         .snapshots()
//         .map((DocumentSnapshot priceDocumentSnapshot) {
//             return priceDocumentSnapshot;
//             });
//          return _db
//         .collection('is_available')
//         .document(cityId)
//         .snapshots()
//         .map((DocumentSnapshot priceDocumentSnapshot) {

//           return ProductDetailModel.fromOtherModels(productDocumentSnapshot, priceDocumentSnapshot, isAvailableDocumentSnapshot)

//       // return priceDocumentSnapshot;
//     });

//       // return priceDocumentSnapshot;
    

//         // return productDocumentSnapshot;
//       }).toList();
//     });


//     // Stream<List<DocumentSnapshot>> productDocumentSnapshots = _db
//     //     .collection('products')
//     //     .snapshots()
//     //     .map((QuerySnapshot querySnapshot) {
//     //   return querySnapshot.documents
//     //       .map((DocumentSnapshot productDocumentSnapshot) {
//     //     return productDocumentSnapshot;
//     //   }).toList();
//     // });

//     // Stream<DocumentSnapshot> priceDocumentSnapshot = _db
//     //     .collection('prices')
//     //     .document(cityId)
//     //     .snapshots()
//     //     .map((DocumentSnapshot priceDocumentSnapshot) {
//     //   return priceDocumentSnapshot;
//     // });

//     // Stream<DocumentSnapshot> isAvailableDocumentSnapshot = _db
//     //     .collection('is_available')
//     //     .document(cityId)
//     //     .snapshots()
//     //     .map((DocumentSnapshot priceDocumentSnapshot) {
//     //   return priceDocumentSnapshot;
//     // });

//     // return ProductDetailModel.fromOtherModels(productDocumentSnapshots,
//     //     priceDocumentSnapshot, isAvailableDocumentSnapshot);
//   }
// }
