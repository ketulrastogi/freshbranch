import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:freshbranch/pages/payment_page/payment_page.dart';
import 'package:freshbranch/services/cart_service.dart';
import 'package:freshbranch/services/product_service.dart';
import 'package:freshbranch/shared/colors.dart';
import 'package:freshbranch/shared/unit_converter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    CartService cartService = Provider.of<CartService>(context);

    return WillPopScope(
      onWillPop: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => HomePage(),
        //   ),
        // );

        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          // backgroundColor: Colors.blueGrey[50],
          // appBar: AppBar(
          //     automaticallyImplyLeading: false,
          //     title: Text(
          //       'Shopping Cart',
          //       style: TextStyle(
          //         // fontSize: 24.0,
          //         //  color: Colors.black,
          //       ),
          //     ),
          //     elevation: 0.0,
          //     // backgroundColor: Colors.transparent,
          //     ),
          // backgroundColor: Theme.of(context).primaryColor,
          body: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                shoppingCartTitle(),
                cartProductList(cartService),
                cartTotalAmout(cartService),
                checkOutButton()
              ],
            ),
          ),
          // bottomNavigationBar: BottomAppNavBar(),
        ),
      ),
    );
  }

  Widget sliverGrid(CartService cartService) {
    return Container(
      // padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[cartTotalAmout(cartService)],
      ),
    );
  }

  Widget shoppingCartTitle() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        'My Shopping Cart',
        style: GoogleFonts.ubuntu(
                    textStyle: Theme.of(context)
                      .textTheme
                      .display1
                      .copyWith(fontWeight: FontWeight.bold),
                  ),
      ),
    );
  }

  Widget cartProductList(CartService cartService) {
    return Expanded(
      child: ListView.builder(
          itemCount: cartService.getCartProducts.length,
          itemBuilder: (context, index) {
            return Container(
              // padding: EdgeInsets.symmetric(vertical: 16.0),
              child: cartProductWidget(cartService.getCartProducts[index], cartService)
              // child: Text(cartService.getUniqueProductsInCart()[index].gujaratiName.toString()) 
              );
          
          }),
    );
  }

  Widget cartProductWidget(CartProduct cartProduct, CartService cartService) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        Card(
          color: lightRed,
          margin: EdgeInsets.only(bottom: 8.0, left: 8.0,),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              // icon: Icons.delete,
              iconWidget: Icon(Icons.delete, size: 32.0, color: Colors.white),
              onTap: () {
                cartService.removeProductFromCart(cartProduct.product);
              },
            ),
          ),
        ),
      ],
      child: Container(
        padding: EdgeInsets.all(8.0),
        
        margin: EdgeInsets.only(bottom: 8.0),
        // shape:
        //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    height: 88.0,
                    width: 88.0,
                    padding: EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32.0),
                      child: Image.network(
                        cartProduct.product.photoUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          // padding: EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            cartProduct.product.englishName,
                            style: GoogleFonts.ubuntu(
                    textStyle: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith( color: Colors.grey.shade800,),
                  ),),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            cartProduct.product.gujaratiName,
                            style: GoogleFonts.ubuntu(
                    textStyle: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Colors.black,),
                  ),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  '${convertUnit2(
                                cartService.getProductQuantityInCart(cartProduct.product) * cartProduct.product.minimumQuantity, cartProduct.product.minimumQuantityUnit)}',
                                  // 'hello',
                                  style: GoogleFonts.ubuntu(
                    textStyle: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(fontWeight: FontWeight.bold, color: Colors.black,),
                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Container(
                                child: Text(
                                  '₹${cartService.getProductPriceInCart(cartProduct.product)}',
                                  style: GoogleFonts.ubuntu(
                    textStyle: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(fontWeight: FontWeight.bold, color: Colors.black,),
                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(16.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(32.0)),
                      child: Icon(
                        Icons.add_circle,
                        size: 24.0,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      cartService.increaseProductInCart(cartProduct.product);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      child: Icon(
                        Icons.remove_circle_outline,
                        size: 24.0,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      cartService.decreaseProductInCart(cartProduct.product);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget cartTotalAmout(CartService cartService) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Total Amount',
            style: GoogleFonts.ubuntu(
                    textStyle: Theme.of(context)
                      .textTheme
                      .headline
                  ),
          ),
          SizedBox(
            width: 16.0,
          ),
          Text(
            '₹${cartService.getTotalAmountOfCart().toString()}',
            style: GoogleFonts.ubuntu(
                    textStyle: Theme.of(context)
                      .textTheme
                      .headline
                  ),
          )
        ],
      ),
    );
  }

  Widget checkOutButton() {
    return InkWell(
      child: Container(
        // margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'CHECKOUT',
            style: GoogleFonts.ubuntu(
                              textStyle: Theme.of(context).textTheme.button.copyWith(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                              ),
                            )
          ),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8.0),
          // gradient: LinearGradient(
          //   colors: [
          //     Theme.of(context).primaryColor,
          //     Theme.of(context).accentColor,
          //   ],
          // ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PaymentPage()));
      },
    );
  }
}
