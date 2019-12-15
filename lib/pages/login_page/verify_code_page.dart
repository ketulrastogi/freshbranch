import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:freshbranch/services/auth_service.dart';
import 'package:freshbranch/shared/snackbar_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class VerifyCodePage extends StatefulWidget {
  @override
  _VerifyCodePageState createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {

  final TextEditingController _smsController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _smsCodeKey =
      GlobalKey<FormState>(debugLabel: 'PhoneKey');

  String _smsCode;

  @override
  Widget build(BuildContext context) {

    final AuthService authService = Provider.of<AuthService>(context);
    if (authService.response['error'] == 'VERIFY_SMSCODE_FAILED') {
      showSnackBar(context, 'Wrong sms code entered. Please try again.', _scaffoldKey);
    }

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _smsCodeKey,
            child: ListView(
              children: <Widget>[
                SizedBox(
                          height: 32.0,
                        ),
                Text(
                  'Verify SMS Code',
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
                  controller: _smsController,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.ubuntu(
                    
                  ),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "SMS Code",
                    filled: true,
                    labelText: "SMS Code",
                    // fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.message,
                    ),
                  ),
                  validator: (String value) {
                        if (value.isEmpty) {
                          return 'SMS Code can not be empty';
                        } else if (value.length != 6) {
                          return 'SMS Code must be of 6 digits';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _smsCode = value;
                        });
                      },
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'We have sent you a 6 digit verification code on your phone number.',
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
                                              Status.VerifyingSmsCode)
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
                              Status.VerifyingSmsCode)
                          ? () {}
                          : () {
                              if (_smsCodeKey.currentState.validate()) {
                                _smsCodeKey.currentState.save();
                                try {
                                  authService.signInWithPhoneNumber(_smsCode);
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
