import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CityModel {
  final String id;
  final String city;
  final String district;
  final String state;
  final String pincode;
  final bool isAvailable;

  CityModel({this.id, this.city, this.district, this.state, this.pincode, this.isAvailable});

  @override
  String toString() => city;

  

  
}


class CityService extends ChangeNotifier {

  Firestore _db;
  List<Map<String, dynamic>> _cities = List();
  CityService.instance(): _db = Firestore.instance {
    _db.collection('cities').snapshots().map((querySnapshot){
      querySnapshot.documents.map((documentSnapshot){
        print(documentSnapshot.data);
        _cities.add(documentSnapshot.data);
      }).toList();
    });
  }

  List<Map<String, dynamic>> get cities => _cities;

  CityModel fromFirestore(DocumentSnapshot documentSnapshot) {
    Map data = documentSnapshot.data;
    return CityModel(
        city: data['city'],
        district: data['district'],
        state: data['state'],
        pincode: data['pincode'],
        isAvailable: data['isAvailable'],
        );
  }

  Stream<List<DocumentSnapshot>> streamAllCities(){
    return _db.collection('cities').snapshots().map((querySnapshot){
      return querySnapshot.documents.map((documentSnapshot){
        return documentSnapshot;
      }).toList();
    });
    // return _db.collection('cities').snapshots().map((list) => list.documents.map((doc) => CityModel.fromFirestore(doc)).toList());
  }

  Future<Map<String, dynamic>> getSingleCity(String pincode) async{
    DocumentSnapshot documentSnapshot =  await _db.collection('cities').document(pincode).get();
    if(!documentSnapshot.exists){
      return null;
    }
    return documentSnapshot.data;
  }



List<Map<String, dynamic>> getSuggestions(String query) {
    List<Map<String, dynamic>> matches = List();
    matches.addAll([..._cities]);
    matches.retainWhere((s) => (s['city'].toLowerCase().contains(query.toLowerCase()) || s['pincode'].toLowerCase().contains(query.toLowerCase())));
    return matches;
  }

// class PriceService {
//   final Firestore _db = Firestore.instance;

//   Stream<List<CityModel>> getProductPrices(String cityId) {
//     return _db.collection('cities').snapshots().map(
//         (QuerySnapshot querySnapshot) => querySnapshot.documents.map(
//             (DocumentSnapshot documentSnapshot) =>
//                 CityModel.fromFirestore(documentSnapshot)));
//   }
// }

}
class CitiesService {

  static final List<CityModel> cities = <CityModel>[
  CityModel(
      city: 'Patan',
      district: 'Patan',
      state: 'Gujarat',
      pincode: '384265',
      isAvailable: true),
  CityModel(
      city: 'Mehsana',
      district: 'Mehsana',
      state: 'Gujarat',
      pincode: '384002',
      isAvailable: true),
];

  // static final List<String> cities = [
  //   'Beirut',
  //   'Damascus',
  //   'San Fransisco',
  //   'Rome',
  //   'Los Angeles',
  //   'Madrid',
  //   'Bali',
  //   'Barcelona',
  //   'Paris',
  //   'Bucharest',
  //   'New York City',
  //   'Philadelphia',
  //   'Sydney',
  // ];

  static List<CityModel> getSuggestions(String query) {
    List<CityModel> matches = [];
    matches.addAll([...cities]);

    matches.retainWhere((s) => (s.city.toLowerCase().contains(query.toLowerCase()) || s.pincode.toLowerCase().contains(query.toLowerCase())));
    return matches;
  }

  

  static CityModel getCity(String query){
    CityModel city = cities.firstWhere((CityModel element){
      return ((element.city.toLowerCase() == query.toLowerCase()) || (element.pincode.toLowerCase() == query.toLowerCase()));
    }, orElse:()=> null);
    if(city == null){
      return null;
    }else{
      return city;
    }
    
  }
}