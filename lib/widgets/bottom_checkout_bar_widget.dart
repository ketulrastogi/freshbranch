import 'package:flutter/material.dart';
import 'package:freshbranch/pages/shopping_cart_page/shopping_cart_page.dart';
import 'package:freshbranch/services/cart_service.dart';
import 'package:provider/provider.dart';

class BottomCheckoutBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final CartService cartService = Provider.of<CartService>(context);
    return (cartService.getTotalAmountOfCart() > 1)
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(Icons.shopping_cart,
                                  size: 32.0, color: Colors.white),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Rs.208',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '10 ITEMS',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'CHECKOUT',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(Icons.arrow_forward_ios,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShoppingCartPage()));
                  },
                )
              : Container();
  }
}