import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freshbranch/pages/home_page.dart';
import 'package:freshbranch/pages/login_page.dart';
import 'package:freshbranch/pages/user_registration_page.dart';
import 'package:freshbranch/services/auth.dart';
// import 'package:freshbranch/pages/home_page/home.dart';
// import 'package:freshbranch/pages/login_page/verify_code_page.dart';
// import 'package:freshbranch/pages/login_page/verify_phone_page.dart';
// import 'package:freshbranch/pages/user_details_page/user_details_page.dart';
// import 'package:freshbranch/services/auth_service.dart';
// import 'package:freshbranch/services/cart_service.dart';
// import 'package:freshbranch/services/city_service.dart';
// import 'package:freshbranch/services/product_service.dart';
// import 'package:freshbranch/services/theme_service.dart';
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
          // ChangeNotifierProvider<ThemeService>(
          //   builder: (context) => ThemeService.instance(),
          // ),
          ChangeNotifierProvider<AuthProvider>(
            builder: (context) => AuthProvider.initialize(),
          ),
          // ChangeNotifierProvider<CityService>(
          //   builder: (context) => CityService(),
          // ),
          // ChangeNotifierProvider<ProductService>(
          //   builder: (context) => ProductService.instance(),
          // ),
          // ChangeNotifierProvider<CartService>(
          //   builder: (context) => CartService.instance(),
          // ),
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
          home: InitialPage(),
        ));
  }
}

class SplashScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: Center(
          child: InkWell(
            onTap: (){
              auth.signOut();
            },
                      child: Container(
              height: 112.0,
              width: 112.0,
              padding: EdgeInsets.all(8.0),
              child:
                  Image.asset('assets/sprout.png'),
            ),
          ),
        ),
      ),
    );
  }
}

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    switch(auth.status){
      case Status.Uninitialized:
        return SplashScreen();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginPage();
      case Status.Authenticated:
        return UserRegistrationPage();
      default: return LoginPage();
    }
  }
}
