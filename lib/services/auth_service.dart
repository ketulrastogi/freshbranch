import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freshbranch/services/user_service.dart';

enum Status {
  Uninitialized,
  Authenticated,
  VerifyingPhoneNumber,
  VerifyPhoneFailed,
  SmsCodeSent,
  VerifyingSmsCode,
  VerifySmsCodeFailed,
  Unauthenticated,
}

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  UserService _userService;
  AuthResult _authResult;
  String _verificationId;
  Status _status = Status.Uninitialized;
  UserUpdateInfo userUpdateInfo = UserUpdateInfo();

  Map<String, dynamic> _response = {
    'status': Status.Uninitialized,
    'user': null,
    'verificationId': '',
    'error': null
  };

  AuthService.instance()
      : _auth = FirebaseAuth.instance {
    
    _auth.onAuthStateChanged.listen((FirebaseUser firebaseUser) async {
      if (firebaseUser == null) {
        _response = {
          'status': Status.Unauthenticated,
          'user': null,
          'verificationId': '',
          'error': null
        };
        _status = Status.Unauthenticated;
        notifyListeners();
      } else {
        _user = firebaseUser;
        _response = {
          'status': Status.Authenticated,
          'user': firebaseUser.uid,
          'verificationId': '',
          'error': null
        };
        _status = Status.Authenticated;
        notifyListeners();
      }
    });
  }

  Map<String, dynamic> get response => _response;
  Status get status => _status;
  

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    _response = {
      'status': Status.VerifyingPhoneNumber,
      'user': null,
      'verificationId': '',
      'error': null
    };
    _status = Status.VerifyingPhoneNumber;
    notifyListeners();

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      _authResult = await _auth.signInWithCredential(phoneAuthCredential);
      _user = _authResult.user;
       _response = {
          'status': Status.Authenticated,
          'user': _user.uid,
          'verificationId': '',
          'error': null
        };
        _status = Status.Authenticated;
        notifyListeners();
      print('Authenticated Phone');
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      _response = {
        'status': Status.VerifyPhoneFailed,
        'user': null,
        'verificationId': '',
        'error': 'VERIFY_PHONE_FAILED'
      };
      _status = Status.VerifyPhoneFailed;
      notifyListeners();
      print('Authentication Phone Failed');
      print(authException.message);
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      // Future.delayed(Duration(seconds: 2), () {
        _response = {
          'status': Status.SmsCodeSent,
          'user': null,
          'verificationId': verificationId,
          'error': null
        };
        _status = Status.SmsCodeSent;
        notifyListeners();
      // });

      _verificationId = verificationId;
      print('SMS Code Sent');
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      _response = {
        'status': Status.SmsCodeSent,
        'user': null,
        'verificationId': verificationId,
        'error': null
      };
      _status = Status.SmsCodeSent;
      notifyListeners();
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<void> signInWithPhoneNumber(String smsCode) async {
    _response = {
      'status': Status.VerifyingSmsCode,
      'user': null,
      'verificationId': '',
      'error': null
    };
    _status = Status.VerifyingSmsCode;
    notifyListeners();
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );
      _authResult = await _auth.signInWithCredential(credential);
      final FirebaseUser user = _authResult.user;
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      print('Successfully signed in, uid: ' + user.uid);

      _response = {
        'status': Status.Authenticated,
        'user': user.uid,
        'verificationId': '',
        'error': null
      };
      _status = Status.Authenticated;
      notifyListeners();
    } catch (e) {
      print('Wrong SMS Code');
      print(e);
      _response = {
        'status': Status.VerifySmsCodeFailed,
        'user': null,
        'verificationId': '',
        'error': 'VERIFY_SMSCODE_FAILED'
      };
      _status = Status.VerifySmsCodeFailed;
      notifyListeners();
    }
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    return firebaseUser;
  }

  
  

  Future<void> setDisplayName(String displayName) async {
    userUpdateInfo.displayName = displayName;
    notifyListeners();
  }

  Future signOut() async {
    _auth.signOut();
    _response = {
      'status': Status.Unauthenticated,
      'user': null,
      'verificationId': '',
      'error': null
    };
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
