import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freshbranch/services/auth.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isNewUser = true;

  void toggleScreen(){
    setState(() {
      _isNewUser = !_isNewUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isNewUser ? SignInPage(toggleScreen: toggleScreen,) : SignUpPage(toggleScreen: toggleScreen,);
  }
}



class SignUpPage extends StatefulWidget {
  final VoidCallback toggleScreen;

  const SignUpPage({Key key, this.toggleScreen}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String _name;
  String _email;
  String _phone;
  String _password;
  String _confirmPassword;

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthProvider>(context);

    return SafeArea(
      child: Scaffold(
        key: _key,
        body: Form(
                    key: _formKey,
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      children: <Widget>[
                        SizedBox(height: 40,),
                        Column(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.topCenter,
                                height: 80.0,
                                width: 80.0,
                                padding: EdgeInsets.all(8.0),
                                child: Image.asset('assets/sprout.png'),
                                
                                ),
                                // SizedBox(
                                //   height:4.0,
                                // ),
                                Center(
                                  child: Text('Fresh Branch',
                                  style: Theme.of(context).textTheme.display1.copyWith(
                                    fontWeight: FontWeight.bold,
                                    ),
                                  
                                  ),
                                )
                          ],
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        // Container(
                          
                        //   child: TextFormField(
                        //     controller: _nameController,
                        //     decoration: InputDecoration(
                        //       border: UnderlineInputBorder(),
                        //       hintText: "Name",
                        //       filled: true,
                        //       labelText: "Name",
                        //       // fillColor: Colors.white,
                        //       prefixIcon: Icon(Icons.account_circle,),
                        //     ),
                        //     validator: (value) {
                        //       if (value.isEmpty) {
                        //         return "The name field cannot be empty";
                        //       } else if (value.length < 6) {
                        //         return "the name has to be at least 6 characters long";
                        //       }
                        //       return null;
                        //     },
                        //     onSaved: (value){
                        //       setState(() {
                        //        _name = value; 
                        //       });
                        //     },
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 12.0,
                        // ),
                        Container(
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: "Email",
                              labelText: "Email",
                              filled: true,
                              // fillColor: Colors.white,
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(value))
                                  return 'Please make sure your email address is valid';
                                else
                                  return null;
                              }
                            },
                            onSaved: (value){
                              setState(() {
                               _email = value; 
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        // Container(
                          
                        //   child: TextFormField(
                        //     controller: _phoneController,
                        //     decoration: InputDecoration(
                        //       border: UnderlineInputBorder(),
                        //       hintText: "Phone",
                        //       filled: true,
                        //       labelText: "Phone",
                        //       // fillColor: Colors.white,
                        //       prefixIcon: Icon(Icons.call,),
                        //     ),
                        //     validator: (value) {
                        //       if (value.isEmpty) {
                        //         return "The phone field cannot be empty";
                        //       } else if (value.length < 10) {
                        //         return "the phone number has to be at least 10 characters long";
                        //       }
                        //       return null;
                        //     },
                        //     onSaved: (value){
                        //       setState(() {
                        //         _phone = "+91" + value;
                        //       });
                        //     },
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 12.0,
                        // ),
                        Container(
                          
                          child: TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: "Password",
                              filled: true,
                              labelText: "Password",
                              // fillColor: Colors.white,
                              prefixIcon: Icon(Icons.lock,),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "The password field cannot be empty";
                              } else if (value.length < 8) {
                                return "the password has to be at least 8 characters long";
                              }
                              if(_passwordController.text != _confirmPasswordController.text){
                                return "Password and confirm password does not match.";
                              }
                              return null;
                            },
                            onSaved: (value){
                              setState(() {
                               _password = value; 
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Container(
                          
                          child: TextFormField(
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: "Confirm Password",
                              filled: true,
                              labelText: "Confirm Password",
                              // fillColor: Colors.white,
                              prefixIcon: Icon(Icons.lock,),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "The confirm password field cannot be empty";
                              } else if (value.length < 8) {
                                return "the confirm password has to be at least 8 characters long";
                              }
                              if(_passwordController.text != _confirmPasswordController.text){
                                return "Password and confirm password does not match.";
                              }
                              return null;
                            },
                            onSaved: (value){
                              setState(() {
                               _confirmPassword = value; 
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),

                        RaisedButton(
                          onPressed: () async{
                            if(_formKey.currentState.validate()){
                              _formKey.currentState.save();
                              if(!await auth.signUp('Ketul', _email, _password))
                                _key.currentState.showSnackBar(SnackBar(content: Text("Sign in failed")));
                            }
                          },
                          color: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(8.0)
                          // ),
                          // minWidth: MediaQuery.of(context).size.width,
                          child: (auth.status == Status.Authenticating) ? SpinKitCircle(
                            color: Colors.white,
                            size: 20.0,
                          ) : Text(
                            "SIGN UP",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.button.copyWith(
                              fontSize: 18.0
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        InkWell(
                          onTap: widget.toggleScreen,
                                                  child: Container(
                            padding:
                                const EdgeInsets.fromLTRB(14.0, 8.0, 16.0, 8.0),
                                alignment: Alignment.center,
                            child: Text('Already registered? Sign In.',
                              style: Theme.of(context).textTheme.subhead,
                            ),
                          ),
                        ),
                      ],
                    ),
         
                        ),
      ),
      );
  }
}


class SignInPage extends StatefulWidget {

  final VoidCallback toggleScreen;

  const SignInPage({Key key, this.toggleScreen}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _email;
  String _password;


  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthProvider>(context);

    return SafeArea(
      child: Scaffold(
        key: _key,
        body: Form(
                    key: _formKey,
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      children: <Widget>[
                        SizedBox(height: 40,),
                        Column(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.topCenter,
                                height: 80.0,
                                width: 80.0,
                                padding: EdgeInsets.all(8.0),
                                child: Image.asset('assets/sprout.png'),
                                
                                ),
                                // SizedBox(
                                //   height:4.0,
                                // ),
                                Center(
                                  child: Text('Fresh Branch',
                                  style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.bold)
                                  ),
                                )
                          ],
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        
                        
                        Container(
                          
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: "Email",
                              labelText: "Email",
                              filled: true,
                          // fillColor: Colors.white,
                          prefixIcon: Icon(Icons.email,),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(value))
                                  return 'Please make sure your email address is valid';
                                else
                                  return null;
                              }
                            },
                            onSaved: (value){
                              setState(() {
                               _email = value; 
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Container(
                          
                          child: TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: "Password",
                              labelText: "Password",
                              filled: true,
                              // fillColor: Colors.white,
                              prefixIcon: Icon(Icons.lock,),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "The password field cannot be empty";
                              } else if (value.length < 8) {
                                return "the password has to be at least 8 characters long";
                              }
                              return null;
                            },
                            onSaved: (value){
                              setState(() {
                               _password = value; 
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        InkWell(
                          onTap: widget.toggleScreen,
                                                  child: Container(
                            
                                alignment: Alignment.centerRight,
                            child: Text('Forgot password?',
                              style: Theme.of(context).textTheme.subhead,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        RaisedButton(
                          onPressed: () async{
                            if(_formKey.currentState.validate()){
                              _formKey.currentState.save();
                              if(!await auth.signIn(_email, _password))
                                _key.currentState.showSnackBar(
                                  SnackBar(content: Text("Sign in failed"),
                                  ),
                                  );
                            }
                          },
                          color: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(8.0)
                          // ),
                          // minWidth: MediaQuery.of(context).size.width,
                          child: (auth.status == Status.Authenticating) ? SpinKitCircle(
                            color: Colors.white,
                            size: 20.0,
                          ) : Text(
                            "SIGN IN",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.button.copyWith(
                              fontSize: 18.0
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        InkWell(
                          onTap: widget.toggleScreen,
                                                  child: Container(
                            padding:
                                const EdgeInsets.fromLTRB(14.0, 8.0, 16.0, 8.0),
                                alignment: Alignment.center,
                            child: Text('Don\'t have an account? Sign Up.',
                              style: Theme.of(context).textTheme.subhead,
                            ),
                          ),
                        ),
                      ],
                    ),
         
                        ),
      ),
      );
  }
}