
// import 'package:cloud_firestore/cloud_firestore.dart';

// class PriceModel {
//   final String cityId;
//   // final String cityId;
//   final Map prices;
//   final DateTime lastUpdatedDate;

//   PriceModel({this.cityId, this.prices, this.lastUpdatedDate}); 

//   factory PriceModel.fromFirestore(DocumentSnapshot documentSnapshot){
//     Map data = documentSnapshot.data;
//     String id = documentSnapshot.documentID;

//     return PriceModel(
//       cityId: id,
//       prices: data['prices'],
//       lastUpdatedDate: data['last_updated_date']
//     );
//   }
// }

// class PriceService {

//   final Firestore _db = Firestore.instance;

//   Stream<PriceModel> getProductPrices(String cityId){
//     return _db
//         .collection('prices')
//         .document(cityId)
//         .snapshots()
//         .map((snapshot) => PriceModel.fromFirestore(snapshot)
//         );
        
//   }

// }