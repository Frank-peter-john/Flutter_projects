import 'dart:convert';

import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  // SAVING AND RETRIEVING DATA FROM LOCAL STORAGE.
  //This method adds objects as strings to the cart list
  void addToCartList(List<CartModel> cartList) {
    // making sure the list is empty since it is called many times in the controller
    cart = [];
    cartList.forEach((element) {
      // Converting objects to string before adding them to cart List.
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    getCartList();
  }

// This method returns a list of objects from the local storage.
  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("Inside getCartLis $carts");
    }
    List<CartModel> cartList = [];
    carts.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }

// This method moves items from cartliost to historylist
  void adddToHistoryList() {
    for (int i = 0; i < cart.length; i++) {
      // print("History list ${cart[i]}");
      cartHistory.add(cart[i]);
    }
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);
  }
}
