import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshbranch/services/auth_service.dart';
import 'package:freshbranch/shared/snackbar_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyPhonePage extends StatefulWidget {
  @override
  _VerifyPhonePageState createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _phoneKey =
      GlobalKey<FormState>(debugLabel: 'PhoneKey');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _phoneNumber;

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context);
    if (authService.response['error'] == 'VERIFY_PHONE_FAILED') {
      showSnackBar(context, 'Sending sms code is failed. Please try again.',
          _scaffoldKey);
    }
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _phoneKey,
            child: ListView(
              children: <Widget>[
                SizedBox(
                          height: 32.0,
                        ),
                Text(
                  'Verify phone',
                  style: GoogleFonts.ubuntu(
                    textStyle: Theme.of(context)
                      .textTheme
                      .display1
                      .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 56.0,
                ),
                TextFormField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.ubuntu(
                    
                  ),
                            
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Phone",
                    filled: true,
                    labelText: "Phone",
                    // fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.call,
                    ),
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Phone number can not be empty';
                    } else if (value.length != 10) {
                      return 'Phone number must be of 10 digits';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _phoneNumber = '+91' + value;
                    });
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'A 6-digit otp will be sent to this number, by clicking on CONTINUE button you accept Terms & Conditions and Privacy Policy of FreshBranch.',
                  style: GoogleFonts.ubuntu(
                    textStyle: Theme.of(context).textTheme.caption,
                  ),
                  
                ),
                SizedBox(
                  height: 16.0,
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: (authService.response['status'] ==
                            Status.VerifyingPhoneNumber)
                        ? Container(
                            // padding: EdgeInsets.all(8.0),
                            child: SpinKitCircle(
                              color: Colors.white,
                              size: 24.0,
                            ),
                          )
                        : Text(
                            'CONTINUE',
                            style: GoogleFonts.ubuntu(
                              textStyle: Theme.of(context).textTheme.button.copyWith(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ),
                  ),
                  onPressed: (authService.response['status'] ==
                          Status.VerifyingPhoneNumber)
                      ? () {}
                      : () {
                          if (_phoneKey.currentState.validate()) {
                            _phoneKey.currentState.save();
                            try {
                              authService.verifyPhoneNumber(_phoneNumber);
                            } on PlatformException {
                              print('Error Occured');
                            }
                          }
                        },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
