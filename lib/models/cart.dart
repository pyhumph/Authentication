import 'package:flutter/material.dart';
import 'package:authentication/models/shoe.dart';

class Cart extends ChangeNotifier {
  // list of shoes for sale
  List<Shoe> shoeShop = [
    Shoe(
        name: 'Zoom FREAk',
        price: '236',
        description:
            'The-forward-thinking design of his latest signature shoe.',
        imagePath: '/images/zoom-freak.jpeg'),
    Shoe(
        name: 'KD Treys',
        price: '240',
        description:
            'A secure midfoot strap is suited for scoring binges and defensive',
        imagePath: '/images/kd-treys-jpeg'),
        Shoe(
        name: 'Kyrie 6',
        price: '190',
        description:
            'Bouncy cushioning is paired without soft yet supportive from ',
        imagePath: '/images/kyrie-6.jpeg'),
  ];

  // list of items in user cart
  List<Shoe> useCart = [];

  // get list of shoes for sale
  List<Shoe> getShoeList () {
    return shoeShop;
  }

  // get cart
  List<Shoe> getUserCart() {
    return useCart;
  }

  // add items to cart
  void addItemToCart(Shoe shoe, String s) {
    useCart.add(shoe);
    notifyListeners();
  }

  // remove items from cart
  void removeItemFromCart(Shoe shoe) {
    useCart.remove(shoe);
    notifyListeners();
  }
}
