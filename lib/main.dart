// import 'package:bookstore_crud/pages/homeFoodPage/main_food_page.dart';
import 'package:bookstore_crud/pages/popularFoodDetail/popular_food_detail.dart';
import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';
import 'package:get/get.dart';

void main() {
  // => runApp: ham khoi dong app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fluter Demo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: const MainFoodPage(),
      home: const PopularFoodDetail(),
    );
  }
}
