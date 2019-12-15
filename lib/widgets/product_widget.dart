import 'package:flutter/material.dart';
import 'package:freshbranch/services/cart_service.dart';
import 'package:freshbranch/services/product_service.dart';
import 'package:freshbranch/shared/unit_converter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatefulWidget {
  final Product product;

  const ProductWidget({Key key, this.product}) : super(key: key);
  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  int productUnit = 0;
  Color animatedControllerColor; 

  String totalOrder;
  String order;
  num totalOrderQuantity = 0;
  @override
  Widget build(BuildContext context) {
    CartService cartService = Provider.of<CartService>(context);
    animatedControllerColor = Theme.of(context).primaryColor; 
    String photoUrl = widget.product.photoUrl;
    num price = widget.product.minimumQuantityPrice;
    String minimumQunatityUnit = widget.product.minimumQuantityUnit;
    num minimumQunatity = widget.product.minimumQuantity;
    String englishName = widget.product.englishName;
    String gujaratiName = widget.product.gujaratiName;
    int productQuantity = cartService.getProductQuantityInCart(widget.product);
    int productPrice = cartService.getProductPriceInCart(widget.product);
    
    print('${widget.product.englishName} Quantity : ${productQuantity.toString()}');
    print('${widget.product.englishName} Price : ${productPrice.toString()}');
    return Container(
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            // BoxShadow(
            //   color: Colors.blueGrey.shade100,
            //   blurRadius: 4.0,
            //   spreadRadius: 1.0 
            // )
          ]
        ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 36.0,
            right: 16.0,
            left: 16.0,
            child: Container(
              width: 120.0,
              height: 120.0,
              child: Image.network(
                photoUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
          
          Positioned(
            top: 4.0,
            right: 4.0,
            child: InkWell(
              onTap: (){
                print(cartService.getProductQuantityInCart(widget.product));
              },
                          child: Container(
                height: 32.0,
                width: 32.0,
                margin: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  
                  borderRadius: BorderRadius.circular(32.0),
                  
                ),
                child: Center(
                  child: Text(
                    '₹$price',
                    style: GoogleFonts.ubuntu(
                      textStyle: Theme.of(context).textTheme.subtitle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 12.0,
            left: 12.0,
            child: Text(
              '$minimumQunatity$minimumQunatityUnit',
              style: GoogleFonts.ubuntu(
                    textStyle: Theme.of(context).textTheme.subtitle.copyWith(
                      color: Colors.grey.shade700
                    ),
                  ),
            ),
          ),
          Positioned(
            top: 152.0,
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Center(
                child: Text(
                  '$englishName',
                  style: GoogleFonts.ubuntu(
                    textStyle: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.grey.shade800
                    )
                  )
                ),
              ),
            ),
          ),
          Positioned(
            top: 178.0,
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Center(
                child: Text(
                  '$gujaratiName',
                  style: GoogleFonts.ubuntu(
                    textStyle: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.grey.shade700,
                      fontSize: 18.0
                    )
                  )
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 4,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 800),
              height: 40.0,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                // gradient: animatedControllerColor,
                color: animatedControllerColor,
                borderRadius: BorderRadius.circular(32.0),
              ),
              // child: (true)
              // child: (true)
              child: (productQuantity < 1)
                  ? InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Text(
                              'ADD TO CART',
                              style: GoogleFonts.ubuntu(
                    textStyle: Theme.of(context).textTheme.button,
                  )
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(
                              Icons.add_circle,
                              size: 32.0,
                              color: Colors.white
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        cartService.addProductToCart(widget.product);
                        // num totalQuantity = widget.product.minimumQuantity *
                        //     cartService.getProductQuantity(widget.product.id);
                        // totalOrderQuantity =
                        //     totalOrderQuantity + minimumQunatity;
                        // totalOrder =
                        //     convertUnit2(totalQuantity, minimumQunatityUnit);
                        // setState(() {
                        //   productUnit++;
                          // productQuantity = cartService.getProductQuantityInCart(widget.product);

                        //   animatedControllerColor = (cartService.getProductQuantityInCart(widget.product) < 1 ) ? Colors.white : Colors.red;
                        // });
                      },
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                                // gradient: RadialGradient(colors: [
                                //   Theme.of(context).primaryColor,
                                //   Theme.of(context).accentColor
                                // ], center: Alignment.center),
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(32.0)),
                            child: Icon(
                              Icons.remove_circle_outline,
                              size: 32.0,
                              color: Colors.white
                            ),
                          ),
                          onTap: () {
                            cartService.decreaseProductInCart(
                                widget.product);
                            totalOrderQuantity =
                                totalOrderQuantity - minimumQunatity;
                            totalOrder = convertUnit2(
                                totalOrderQuantity, minimumQunatityUnit);
                            // setState(() {
                              // productQuantity = cartService.getProductQuantityInCart(widget.product);
                              // widget.product['quantity']--;
                              // cartService.decreaseCartProductQuantity(widget.product);
                              // if (totalOrderQuantity == 0) {
                                // animatedControllerColor = Theme.of(context).primaryColor;
                              // }
                            // });
                          },
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.0,
                          ),
                          child: Text(
                            // '${cartService.getProductQuantityInCart(widget.product).toString()}',
                            '${convertUnit2(
                                cartService.getProductQuantityInCart(widget.product) * widget.product.minimumQuantity, widget.product.minimumQuantityUnit)}',
                            // '20',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0),
                          ),
                        ),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                                // gradient: RadialGradient(colors: [
                                //   Theme.of(context).primaryColor,
                                //   Theme.of(context).accentColor
                                // ], center: Alignment.center),
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(32.0)),
                            child: Icon(
                              Icons.add_circle,
                              size: 32.0,
                              color: Colors.white
                            ),
                          ),
                          onTap: () {
                            cartService.increaseProductInCart(
                                widget.product);
                            // totalOrderQuantity =
                            //     totalOrderQuantity + minimumQunatity;
                            // totalOrder = convertUnit2(
                            //     totalOrderQuantity, minimumQunatityUnit);
                            // setState(() {
                              // productUnit++;
                              // productQuantity = cartService.getProductQuantityInCart(widget.product);
                              // print(total_order);
                              // widget.product['quantity']++;
                              // cartService.increaseCartProductQuantity(widget.product);
                            // });
                          },
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
