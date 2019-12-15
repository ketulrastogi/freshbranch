// import 'package:autocomplete_textfield/autocomplete_textfield.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:freshbranch/pages/home_page/home.dart';
// import 'package:freshbranch/services/auth_service.dart';
// import 'package:freshbranch/services/city_service.dart';
// import 'package:freshbranch/services/user_service.dart';
// import 'package:freshbranch/shared/snackbar_widget.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:intl/intl.dart';
// import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';

// final cities = <CityModel>[
//   CityModel(
//       city: 'Patan',
//       district: 'Patan',
//       state: 'Gujarat',
//       pincode: '384265',
//       isAvailable: true),
//   CityModel(
//       city: 'Mehsana',
//       district: 'Mehsana',
//       state: 'Gujarat',
//       pincode: '384002',
//       isAvailable: true),
// ];

// class UserDetaislPage extends StatefulWidget {
//   final String userId;
//   const UserDetaislPage({Key key, this.userId}) : super(key: key);

//   @override
//   _UserDetaislPageState createState() => _UserDetaislPageState();
// }

// class _UserDetaislPageState extends State<UserDetaislPage> {
//   final TextEditingController _displayeNameController = TextEditingController();
//   final GlobalKey<FormState> _phoneKey =
//       GlobalKey<FormState>(debugLabel: 'PhoneKey');
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//   GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

//   TextEditingController autoCompleteTextEditingController =
//       TextEditingController();

//   CityModel selectedCity;
//   UserModel userModel;
//   String _displayName;

//   @override
//   void initState() {
//     _displayName = 'Ketul Rastogi';

//     super.initState();
//   }

 

//   @override
//   Widget build(BuildContext context) {
//     final UserService userService = UserService();
//     final AuthService authService = Provider.of<AuthService>(context);
    
//     return StreamProvider.value(
//           value: userService.getCurrentUserDetails(widget.userId),
//           child: SafeArea(
//         child: Scaffold(
//           key: _scaffoldKey,
//           body: Padding(
//             padding: const EdgeInsets.all(32.0),
//             child: FutureBuilder<UserModel>(
//                 future: getUserDetails(userService),
//                 builder: (context, AsyncSnapshot<UserModel> snapshot) {
//                   if (snapshot.hasData) {
//                     return Form(
//                       key: _phoneKey,
//                       child: ListView(
//                         children: <Widget>[
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 16.0),
//                             child: InkWell(
//                               onTap: () {
//                                 authService.signOut();
//                               },
//                               child: Text('User Details',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .display1
//                                       .copyWith(
//                                         // fontSize: 32.0,
//                                         fontWeight: FontWeight.bold,
//                                         color: Theme.of(context).primaryColor,
//                                       )),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: TextFormField(
//                               controller: _displayeNameController,
//                               style: Theme.of(context).textTheme.headline,
//                               // keyboardType: TextInputType.number,
//                               decoration: InputDecoration(
//                                 hintText: 'Display Name',
//                                 labelText: 'Name',
//                               ),

//                               validator: (String value) {
//                                 if (value.isEmpty) {
//                                   return 'Display name can not be empty';
//                                 }

//                                 return null;
//                               },
//                               onSaved: (value) {
//                                 setState(() {
//                                   _displayName = value;
//                                 });
//                               },
//                             ),
//                           ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                          //   child: SimpleAutocompleteFormField<CityModel>(
                          //     style: Theme.of(context).textTheme.headline,
                          //     decoration: InputDecoration(
                          //       labelText: 'City',
                          //       hintText: 'City Name',
                          //     ),
                          //     suggestionsHeight: 100.0,
                          //     itemBuilder: (context, CityModel cityModel) =>
                          //         Padding(
                          //       padding: EdgeInsets.all(8.0),
                          //       child: Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Text(cityModel.city,
                          //                 style:
                          //                     Theme.of(context).textTheme.title),
                          //             Text(cityModel.pincode,
                          //                 style: Theme.of(context)
                          //                     .textTheme
                          //                     .subtitle)
                          //           ]),
                          //     ),
                          //     onSearch: (search) async => cities
                          //         .where((CityModel cityModel) =>
                          //             cityModel.city
                          //                 .toLowerCase()
                          //                 .contains(search.toLowerCase()) ||
                          //             cityModel.pincode
                          //                 .toLowerCase()
                          //                 .contains(search.toLowerCase()))
                          //         .toList(),
                          //     itemFromString: (string) => cities.singleWhere(
                          //         (CityModel city) =>
                          //             city.city.toLowerCase() ==
                          //             string.toLowerCase(),
                          //         orElse: () => null),
                          //     onChanged: (CityModel value) =>
                          //         setState(() => selectedCity = value),
                          //     onSaved: (CityModel value) =>
                          //         setState(() => selectedCity = value),
                          //     validator: (CityModel city) =>
                          //         city == null ? 'Invalid city.' : null,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 8.0,
                          // ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 16.0),
//                             child: InkWell(
//                               child: Container(
//                                 padding: EdgeInsets.all(16.0),
//                                 decoration: BoxDecoration(
//                                     color: Theme.of(context).primaryColor,
//                                     borderRadius: BorderRadius.circular(8.0)),
//                                 child: Center(
//                                   child: (authService.response['status'] ==
//                                           Status.VerifyingPhoneNumber)
//                                       ? Container(
//                                           // padding: EdgeInsets.all(8.0),
//                                           child: SpinKitCircle(
//                                             color: Colors.white,
//                                             size: 24.0,
//                                           ),
//                                         )
//                                       : Text(
//                                           'SUBMIT',
//                                           style: TextStyle(
//                                             fontSize: 20.0,
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                 ),
//                               ),
//                               onTap: (authService.response['status'] ==
//                                       Status.VerifyingPhoneNumber)
//                                   ? () {}
//                                   : () async {
//                                       if (_phoneKey.currentState.validate()) {
//                                         _phoneKey.currentState.save();
//                                         try {
//                                           await userService
//                                               .updateUserDetails(UserModel(
//                                             uid: widget.userId,
//                                             displayName: _displayName,
//                                             city: selectedCity,
//                                           ));
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) => HomePage()),
//                                           );
//                                         } on PlatformException {
//                                           print('Error Occured');
//                                         }
//                                       }
//                                     },
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   } else {
//                     return Center(
//                       child: Container(
//                         height: 56.0,
//                         width: 56.0,
//                         child: CircularProgressIndicator(),
//                       ),
//                     );
//                   }
//                 }),
//           ),
//         ),
//       ),
//     );
//   }
// }
