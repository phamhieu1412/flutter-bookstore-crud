import 'package:bookstore_crud/controllers/cart_controller.dart';
import 'package:bookstore_crud/controllers/popular_product_controller.dart';
import 'package:bookstore_crud/controllers/recommended_product_controller.dart';
import 'package:bookstore_crud/routes/route_helper.dart';
import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:bookstore_crud/helper/dependencies.dart' as deps;

void main() async {
  // => call api
  WidgetsFlutterBinding.ensureInitialized();
  await deps.init();

  // => runApp: ham khoi dong app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();

    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fluter Demo App',
          theme: ThemeData(primarySwatch: Colors.blue),
          // home: const SplashPage(),
          initialRoute: RouteHelper.getSplash(),
          getPages: RouteHelper.routes,
        );
      });
    });
  }
}
