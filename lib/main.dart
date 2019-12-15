import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freshbranch/pages/home_page/home.dart';
import 'package:freshbranch/pages/login_page/verify_code_page.dart';
import 'package:freshbranch/pages/login_page/verify_phone_page.dart';
import 'package:freshbranch/pages/user_details_page/user_details_page.dart';
import 'package:freshbranch/pages/user_registration_page.dart';
import 'package:freshbranch/services/auth_service.dart';
import 'package:freshbranch/services/cart_service.dart';
import 'package:freshbranch/services/city_service.dart';
import 'package:freshbranch/services/product_service.dart';
import 'package:freshbranch/services/theme_service.dart';
import 'package:freshbranch/services/user_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(HomeShopApp());

class HomeShopApp extends StatefulWidget {
  @override
  _HomeShopAppState createState() => _HomeShopAppState();
}

class _HomeShopAppState extends State<HomeShopApp> {
  String cityId = 'JM9kFy8LUuZiOAoaTPcz';

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeService>(
            builder: (context) => ThemeService.instance(),
          ),
          ChangeNotifierProvider<AuthService>(
            builder: (context) => AuthService.instance(),
          ),
          ChangeNotifierProvider<CityService>(
            builder: (context) => CityService.instance(),
          ),
          ChangeNotifierProvider<ProductService>(
            builder: (context) => ProductService.instance(),
          ),
          ChangeNotifierProvider<CartService>(
            builder: (context) => CartService.instance(),
          ),
          ChangeNotifierProvider<UserService>(
            builder: (context) => UserService(),
          ),
        ],
        child: MaterialApp(
          title: 'Fresh Branch',
          theme: ThemeData(
            brightness: Brightness.dark,
            // primarySwatch: Colors.deepOrange,
            primaryColor: Colors.green,
            accentColor: Colors.green,
          ),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ));
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InitialRoutePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: Center(
          child: Container(
            height: 112.0,
            width: 112.0,
            padding: EdgeInsets.all(8.0),
            child: Image.asset('assets/sprout.png'),
          ),
        ),
      ),
    );
  }
}

class InitialRoutePage extends StatefulWidget {
  final String title;

  const InitialRoutePage({Key key, this.title}) : super(key: key);
  @override
  _InitialRoutePageState createState() => _InitialRoutePageState();
}

class _InitialRoutePageState extends State<InitialRoutePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, AuthService authService, _) {
        switch (authService.status) {
          case Status.Uninitialized:
            return SplashScreen();
          case Status.Unauthenticated:
            return VerifyPhonePage();
          case Status.VerifyingPhoneNumber:
            return VerifyPhonePage();
          case Status.VerifyPhoneFailed:
            return VerifyPhonePage();
          case Status.SmsCodeSent:
            return VerifyCodePage();
          case Status.VerifyingSmsCode:
            return VerifyCodePage();
          case Status.VerifySmsCodeFailed:
            return VerifyCodePage();
          case Status.Authenticated:
            return ChangeNotifierProvider<UserService>(
              builder: (context) => UserService(),
              child: UserRoutePage(
                userId: authService.response['user'].toString(),
              ),
            );
          default:
            return VerifyPhonePage();
        }
      },
    );
  }
}

class UserRoutePage extends StatefulWidget {
  final String userId;

  const UserRoutePage({Key key, this.userId}) : super(key: key);
  @override
  _UserRoutePageState createState() => _UserRoutePageState();
}

class _UserRoutePageState extends State<UserRoutePage> {
  @override
  Widget build(BuildContext context) {
    final UserService userService = Provider.of<UserService>(context);
    final AuthService authService = Provider.of<AuthService>(context);
    return FutureBuilder<FirebaseUser>(
      future: authService.getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return StreamBuilder<UserModel>(
              stream: userService.getCurrentUserDetails(snapshot.data.uid),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.hasData) {
                  UserModel user = snapshot.data;
                  print(user.displayName);
                  print(user.city);
                  print(user.pincode);
                  print(user.email);
                  print(user.phoneNumber);
                  if (user.displayName != null &&
                      user.city != null &&
                      user.pincode != null &&
                      user.email != null) {
                    return HomePage();
                  } else {
                    return UserRegistrationPage(
                      userId: widget.userId,
                    );
                  }
                } else {
                  return Scaffold(
                    body: Center(
                      child: Container(
                        height: 56.0,
                        width: 56.0,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }
              });
        }
        return Scaffold(
          body: Center(
            child: Container(
              height: 56.0,
              width: 56.0,
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
