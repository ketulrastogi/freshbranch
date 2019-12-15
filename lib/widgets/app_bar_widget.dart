import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:freshbranch/pages/shopping_cart_page/shopping_cart_page.dart';
import 'package:freshbranch/services/cart_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppBarWidget extends StatefulWidget {
  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    CartService cartService = Provider.of<CartService>(context); 
    // ThemeService themeService = Provider.of<ThemeService>(context);

    return Container(
      padding: EdgeInsets.only(
        top: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            child: Text(
              'Tathastu',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                // color: Colors.grey[800],
              ),
            ),
            // onTap: themeService.changeTheme(),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(32.0),
            child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: RadialGradient(colors: [
                  Colors.redAccent,
                  Colors.pinkAccent,
                ], center: Alignment.center),
                borderRadius: BorderRadius.circular(32.0),
              ),
              child: Badge(
                badgeContent: Text('5',
                    style: TextStyle(color: Colors.black)),
                badgeColor: Colors.yellow,
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 32.0,
                ),
              ),
            ),
            onTap: () {
              // firebaseAuth.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShoppingCartPage()));
            },
          ),
        ],
      ),
    );
  }
}
