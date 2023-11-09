import 'package:bookstore_crud/pages/cartPage/cart_page.dart';
import 'package:bookstore_crud/pages/homeFoodPage/home_page.dart';
import 'package:bookstore_crud/pages/popularFoodDetail/popular_food_detail.dart';
import 'package:bookstore_crud/pages/recommendFoodDetail/recommend_food_detail.dart';
import 'package:bookstore_crud/pages/splashPage/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String splash = "/splash";
  static const String popularFood = "/popular-food";
  static const String recommendFood = "/recommend-food";
  static const String cart = "/cart";

  static String getInitial() => '$initial';
  static String getSplash() => '$splash';
  static String getPopularFood(int pageId, String from) =>
      '$popularFood?pageId=$pageId&from=$from';
  static String getRecommendFood(int pageId) => '$recommendFood?pageId=$pageId';
  static String getCart() => '$cart';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var from = Get.parameters['from'];
          return PopularFoodDetail(pageId: int.parse(pageId!), from: from!);
        },
        // Mark: Hiệu ứng chuyển trang
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: recommendFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          return RecommendFoodDetail(pageId: int.parse(pageId!));
        },
        // Mark: Hiệu ứng chuyển trang
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: cart,
        page: () => const CartPage(),
        transition: Transition.rightToLeftWithFade),
  ];
}
