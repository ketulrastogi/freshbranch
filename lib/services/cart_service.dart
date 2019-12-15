import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freshbranch/services/product_service.dart';

class CartProduct {
  int quantity;
  Product product;

  CartProduct({this.quantity, this.product});
}

class CartService extends ChangeNotifier {
  List<CartProduct> cartProducts = List();
  int totalCartProducts;

  CartService.instance() {
    cartProducts = [];
    totalCartProducts = 0;
  }

  List<CartProduct> get getCartProducts => cartProducts;

  void addProductToCart(Product product) {
    
        
    CartProduct cartProduct = CartProduct(quantity: 1, product: product);
    cartProducts.add(cartProduct);
    notifyListeners();
   
  }

  increaseProductInCart(Product product) {
    CartProduct cartProduct = cartProducts.firstWhere(
        (cartProduct) => (cartProduct.product.id == product.id),
        orElse: () => null);

    if (cartProduct != null) {
      cartProduct.quantity = cartProduct.quantity + 1;
      notifyListeners();
    } else {
      addProductToCart(product);
    }
  }

  decreaseProductInCart(Product product) {
    CartProduct cartProduct = cartProducts.firstWhere(
        (cartProduct) => (cartProduct.product.id == product.id),
        orElse: () => null);
    if (cartProduct != null && cartProduct.quantity > 1) {
      cartProduct.quantity = cartProduct.quantity - 1;
      notifyListeners();
    } else {
      removeProductFromCart(product);
    }
  }

  removeProductFromCart(Product product) {
    cartProducts.removeWhere(
        (CartProduct cartProduct) => (cartProduct.product.id == product.id));
    notifyListeners();
  }

  int getTotalAmountOfCart() {
    int totalAmount = 0;
    cartProducts.forEach((cartProduct) {
      totalAmount = totalAmount +
          (cartProduct.product.minimumQuantityPrice * cartProduct.quantity);
    });
    return totalAmount;
  }

  int getProductQuantityInCart(Product product) {
    CartProduct cartProduct = cartProducts.firstWhere(
        (cartProduct) => (cartProduct.product.id == product.id),
        orElse: () => null);
    Future.delayed(Duration.zero);
    if (cartProduct != null && cartProduct.quantity > 0) {
      return cartProduct.quantity;
    } else {
      return 0;
    }
  }

  bool productAddedInCart(Product product) {
    CartProduct cartProduct = cartProducts.firstWhere(
        (cProduct) => (cProduct.product.id == product.id),
        orElse: () => null);
    if (cartProduct != null && cartProduct.quantity > 0) {
      print('CartService - 68 : CartProductQuantity');
      return true;
    }
    return false;
  }

  getProductPriceInCart(Product product) {
    CartProduct cartProduct = cartProducts.firstWhere(
        (CartProduct cartProduct) => (cartProduct.product.id == product.id),
         orElse: () => null);
    Future.delayed(Duration.zero);
    if(cartProduct != null){
      return (cartProduct.quantity * cartProduct.product.minimumQuantityPrice);
    }
    return 0;
  }

  num getTotalItemsInCart() {
    return cartProducts.length;
  }

  // num getTotalAmount(){
  //   num totalAmount = 0;
  //   cartProducts.forEach((product){
  //     totalAmount += product.minimumQuantityPrice*product.quantity;
  //   });
  //   return totalAmount;
  // }

  // addProductToCart(Product product) {
  //   cartProducts.add(CartProduct(
  //     id: product.id,
  //     englishName: product.englishName,
  //     gujaratiName: product.gujaratiName,
  //     photoUrl: product.photoUrl,
  //     minimumQuantity : product.minimumQuantity,
  //     minimumQuantityUnit: product.minimumQuantityUnit,
  //     minimumQuantityPrice: product.minimumQuantityPrice,
  //     quantity: 1
  //   ));
  //   notifyListeners();
  // }

  // increaseProductQuantityInCart(String id) {
  //   print(id);
  //   cartProducts.forEach((cartProduct) {
  //     print('hello');
  //     print('${cartProduct.id}  :  ${cartProduct.quantity}');
  //     if (cartProduct.id == id) {
  //       cartProduct.quantity++;
  //       // print('qunatity is ${cartProduct['quantity']}');
  //     }
  //   });

  //   notifyListeners();
  // }

  // decreaseProductQuantityInCart(String id) {
  //   var toRemove = [];
  //   cartProducts.forEach((cartProduct) {
  //     if (cartProduct.id == id) {
  //       if (cartProduct.quantity == 1) {
  //         toRemove.add(cartProduct.id);
  //       } else {
  //         cartProduct.quantity--;
  //       }
  //     }
  //   });
  //   cartProducts.removeWhere((cartProduct) => toRemove.contains(cartProduct.id));
  //   notifyListeners();
  // }

  // List<CartProduct> getAllCartProducts() {
  //   return cartProducts;
  // }

  // removeProductInCart(String id){
  //   var toRemove = [];
  //   cartProducts.forEach((cartProduct) {
  //     if (cartProduct.id == id) {
  //         toRemove.add(cartProduct.id);
  //     }
  //   });
  //   cartProducts.removeWhere((cartProduct) => toRemove.contains(cartProduct.id));
  //   notifyListeners();
  // }

  // num getProductQuantity(String id){
  //   print(cartProducts.firstWhere((test) => test.id == id).quantity);
  //   return cartProducts.firstWhere((test) => test.id == id).quantity;
  // }

}
