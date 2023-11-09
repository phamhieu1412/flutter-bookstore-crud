import 'dart:convert';

import 'package:bookstore_crud/models/cart_model.dart';
import 'package:bookstore_crud/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> list) {
    cart = [];
    var time = DateTime.now().toString();

    // Mark: Phải convert sang String vì cái shared chỉ cho phép kiểu string
    list.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(Constants.CART_LIST, cart);

    getProductsInCartList();
  }

  List<CartModel> getProductsInCartList() {
    List<CartModel> resultList = [];
    List<String> cartsTemp = [];

    if (sharedPreferences.containsKey(Constants.CART_LIST)) {
      cartsTemp = sharedPreferences.getStringList(Constants.CART_LIST)!;
    }

    cartsTemp.forEach((element) {
      resultList.add(CartModel.fromJson(jsonDecode(element)));
    });

    return resultList;
  }

  void addToCartHistoryList() {
    var cartLength = cart.length;

    if (sharedPreferences.containsKey(Constants.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(Constants.CART_HISTORY_LIST)!;
    }

    for (var i = 0; i < cartLength; i++) {
      cartHistory.add(cart[i]);
    }

    removeCart();

    sharedPreferences.setStringList(Constants.CART_HISTORY_LIST, cartHistory);
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(Constants.CART_LIST);
  }

  List<CartModel> getProductsInCartHistoryList() {
    List<CartModel> resultHistoryList = [];

    if (sharedPreferences.containsKey(Constants.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(Constants.CART_HISTORY_LIST)!;
    }

    cartHistory.forEach((element) =>
        resultHistoryList.add(CartModel.fromJson(jsonDecode(element))));

    return resultHistoryList;
  }
}
