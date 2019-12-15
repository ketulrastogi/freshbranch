import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:freshbranch/pages/home_page/home.dart';
import 'package:freshbranch/services/auth.dart';
import 'package:freshbranch/services/auth_service.dart';
import 'package:freshbranch/services/city_service.dart';
import 'package:freshbranch/services/user_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';


class UserRegistrationPage extends StatefulWidget {
  final String userId;

  const UserRegistrationPage({Key key, this.userId}) : super(key: key);
  @override
  _UserRegistrationPageState createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserService>(
      builder: (context) => UserService.instance(widget.userId),
      child: Consumer<UserService>(
        builder: (context, userService, child) {
          return UserCityWidget(
            userId: widget.userId,
          );
        },
      ),
    );
  }
}

class UserCityWidget extends StatefulWidget {
  final String userId;

  const UserCityWidget({Key key, this.userId}) : super(key: key);

  @override
  _UserCityWidgetState createState() => _UserCityWidgetState();
}

class _UserCityWidgetState extends State<UserCityWidget> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  Map<String, dynamic> _selectedCity;

  String _pincode;

  @override
  Widget build(BuildContext context) {
    // final auth = Provider.of<AuthProvider>(context);
    final userService = Provider.of<UserService>(context);
    final cityService = Provider.of<CityService>(context);
    final authService = Provider.of<AuthService>(context);

    print('User Registration Page - 99 : ${widget.userId}');
    return SafeArea(
      child: Scaffold(
        key: _key,
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                authService.signOut();
              },
              child: Text(
                'Where do you live?',
                style: GoogleFonts.ubuntu(
                  textStyle: Theme.of(context)
                      .textTheme
                      .display1
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            Container(
              height: 150.0,
              child: StreamBuilder<List<DocumentSnapshot>>(
                stream: cityService.streamAllCities(),
                builder: (context, snapshot) {
                  print(snapshot.connectionState);
                  print(snapshot.hasData);
                  print(snapshot.data);
                  if (snapshot.hasData) {

                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedCity = snapshot.data[index].data;
                            });
                          },
                          child: Card(
                            color: (_selectedCity != null)
                                ? ((_selectedCity['pincode'] ==
                                        snapshot.data[index]['pincode'])
                                    ? Colors.green
                                    : Colors.white10)
                                : Colors.white10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 80.0,
                                  width: 130.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        topRight: Radius.circular(8.0)),
                                    child: Image.network(
                                      snapshot.data[index]['photoUrl'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 8.0, 2.0),
                                  child: Text(
                                    snapshot.data[index]['city'],
                                    style: GoogleFonts.ubuntu(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .subhead,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 2.0, 8.0, 8.0),
                                  child: Text(
                                    snapshot.data[index]['pincode'],
                                    style: GoogleFonts.ubuntu(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .caption,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // child: Text('Hello'),
                          ),
                        );
                      },
                    );

                    // return GridView.count(
                    //   crossAxisCount: 3,
                    //   mainAxisSpacing: 4.0,
                    //   crossAxisSpacing: 4.0,
                    //   childAspectRatio: 0.88,
                    //   children: snapshot.data.map((document) {
                        
                    //   }).toList(),
                    // );
                    
                  } else {
                    return Center(
                      child: SpinKitCircle(
                        color: Theme.of(context).primaryColor,
                        size: 32.0,
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            RaisedButton(
            onPressed: () async {
              if (_selectedCity != null) {
                print('User Registration Page - 218 : ${widget.userId}');
                try {
                  // userService.updateUserCity("widget.userId", _selectedCity['city'], _selectedCity['pincode']);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UserNameWidget(userId: widget.userId),
                      ));
                } catch (e) {
                  print(e.toString());
                }

                _selectedCity = null;
              }
            },
            color: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              "CONTINUE",
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                          textStyle: Theme.of(context).textTheme.button.copyWith(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                          ),
                        )
            ),
          ),
          ],
        ),
      ),
    );
  }
}

class UserNameWidget extends StatefulWidget {
  final String userId;

  const UserNameWidget({Key key, this.userId}) : super(key: key);

  @override
  _UserNameWidgetState createState() => _UserNameWidgetState();
}

class _UserNameWidgetState extends State<UserNameWidget> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  final TextEditingController _typeAheadController = TextEditingController();
  Map<String, dynamic> _selectedCity;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  CityModel selectedCity;
  String _name;
  String _pincode;
  List<CityModel> cities;

  @override
  Widget build(BuildContext context) {
    // final auth = Provider.of<AuthProvider>(context);
    // final userService = Provider.of<UserService>(context);
    final cityService = Provider.of<CityService>(context);

    print(cities);
    return SafeArea(
      child: Scaffold(
          key: _key,
          body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Tell us your name.',
                  style: GoogleFonts.ubuntu(
                  textStyle: Theme.of(context)
                      .textTheme
                      .display1
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                ),
                SizedBox(
                  height: 32.0,
                ),
                Container(
                  child: TextFormField(
                    controller: _nameController,
                    style: GoogleFonts.ubuntu(
                    
                  ),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Name",
                      filled: true,
                      labelText: "Name",
                      // fillColor: Colors.white,
                      prefixIcon: Icon(
                        Icons.account_circle,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "The name field cannot be empty";
                      } else if (value.length < 6) {
                        return "the name has to be at least 6 characters long";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _name = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      // print(this._selectedCity['city']);
                      // widget.updateIndex();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserEmailWidget(),
                          ));
                    }
                  },
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "CONTINUE",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                              textStyle: Theme.of(context).textTheme.button.copyWith(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          )),
    );
  }
}

class UserEmailWidget extends StatefulWidget {
  final String userId;

  const UserEmailWidget({Key key, this.userId}) : super(key: key);

  @override
  _UserEmailWidgetState createState() => _UserEmailWidgetState();
}

class _UserEmailWidgetState extends State<UserEmailWidget> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  final TextEditingController _typeAheadController = TextEditingController();
  Map<String, dynamic> _selectedCity;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  CityModel selectedCity;
  String _name;
  String _pincode;
  List<CityModel> cities;

  @override
  Widget build(BuildContext context) {
    // final auth = Provider.of<AuthProvider>(context);
    // final userService = Provider.of<UserService>(context);
    final cityService = Provider.of<CityService>(context);

    print(cities);
    return SafeArea(
      child: Scaffold(
          key: _key,
          body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Enter your email.',
                  style: GoogleFonts.ubuntu(
                    textStyle: Theme.of(context)
                      .textTheme
                      .display1
                      .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 32.0,
                ),
                Container(
                  child: TextFormField(
                    controller: _emailController,
                    style: GoogleFonts.ubuntu(
                    
                  ),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Email",
                      filled: true,
                      labelText: "Email",
                      // fillColor: Colors.white,
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "The name field cannot be empty";
                      } else if (value.length < 6) {
                        return "the name has to be at least 6 characters long";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _name = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      Navigator.push(context, 
                      MaterialPageRoute(
                        builder: (context) => HomePage()
                      ),);
                    }
                  },
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "LET'S START",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                              textStyle: Theme.of(context).textTheme.button.copyWith(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                              ),
                            )
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          )),
    );
  }
}
