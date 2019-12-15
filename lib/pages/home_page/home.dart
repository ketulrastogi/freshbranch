import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshbranch/pages/profile_page/profile_page.dart';
import 'package:freshbranch/pages/shopping_cart_page/shopping_cart_page.dart';
import 'package:freshbranch/services/cart_service.dart';
import 'package:freshbranch/services/user_service.dart';
import 'package:freshbranch/widgets/bottom_navigation_bar_widget.dart';
import 'package:freshbranch/widgets/product_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final UserModel user;

  const HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    CartService cartService = Provider.of<CartService>(context);

    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          // backgroundColor: Colors.grey.shade900,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0, 
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  // FirebaseAuth.instance.signOut();
                  
                },
                              child: Text(
                  'Fresh Branch',
                  style: GoogleFonts.ubuntu(
                    textStyle: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(fontSize: 30.0,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.all(8.0),
                child: Badge(
                  badgeContent:
                      Text('${cartService.getTotalItemsInCart().toString()}', style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(color: Colors.black),
                      ),
                      ),
                  badgeColor: Theme.of(context).primaryColor,
                  child: Icon(
                    Icons.notifications,
                    // color: Theme.of(context).primaryColor, 
                    size: 32.0,
                  ),
                ),
              ),
              InkWell(
                 onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePage()));
                },
                              child: Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.account_circle,
                    // color: Theme.of(context).primaryColor, 
                    size: 32.0,
                  ),
                ),
              ),
              
            ],
            
            bottom: TabBar(
              unselectedLabelColor: Colors.white54,
              labelColor: Colors.white, 
              indicatorColor: Theme.of(context).primaryColor,
              labelStyle:
                  GoogleFonts.ubuntu(
                    textStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
              tabs: <Widget>[
                Tab(
                  text: 'Vegetables',
                ),
                Tab(
                  text: 'Fruits',
                ),
                Tab(
                  text: 'Flowers',
                )
              ],
            ),
            
          ),
          body: sliverGrid(cartService),
          // backgroundColor: Colors.green.shade50
          // bottomNavigationBar: BottomAppNavBar(),
        ),
      ),
    );
  }

  Widget sliverGrid(CartService cartService) {
    return Stack(
      children: <Widget>[
        // AppBarWidget(),
        // ProductCategoryWidget(),
        ProductListWidget(),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0, 
          // child: (true)
          child: (cartService.getTotalItemsInCart() > 0)
              ? InkWell(
                  child: Container(
                    // width: MediaQuery.of(context).size.width,
                    height: 56.0,
                    // padding: EdgeInsets.all(8.0), 
                    // margin: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        // borderRadius: BorderRadius.circular(32.0),
                        
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                Icons.shopping_cart,
                                size: 32.0,
                                color: Colors.white
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('₹ ${cartService.getTotalAmountOfCart().toString()}', 
                                  style: GoogleFonts.ubuntu(
                                    textStyle: Theme.of(context).textTheme.subhead.copyWith(
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                                  ),
                                  Text('${cartService.getTotalItemsInCart().toString()} ${cartService.getTotalItemsInCart()>1 ? "Items" : "Item"}', style: GoogleFonts.ubuntu(
                                    textStyle: Theme.of(context).textTheme.subhead.copyWith(
                                      fontWeight: FontWeight.bold
                                    )
                                  ),),
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                        Row(
                          children: <Widget>[
                            Text(
                              'CHECKOUT',
                              style: GoogleFonts.ubuntu(
                                    textStyle: Theme.of(context).textTheme.title.copyWith(
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal :8.0),
                              child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShoppingCartPage()));
                  },
                )
              : Container(),
        ),
      ],
    );
  }
}
