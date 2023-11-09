import 'package:bookstore_crud/controllers/cart_controller.dart';
import 'package:bookstore_crud/controllers/recommended_product_controller.dart';
import 'package:bookstore_crud/db/repository/cart_repo.dart';
import 'package:bookstore_crud/db/repository/recommended_product_repo.dart';
import 'package:bookstore_crud/utils/constants.dart';
import 'package:bookstore_crud/db/api/api_client.dart';
import 'package:bookstore_crud/db/repository/popular_product_repo.dart';
import 'package:bookstore_crud/controllers/popular_product_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  // Mark: Api client
  Get.lazyPut(() =>
      ApiClient(appBaseUrl: Constants.BASE_URL)); // https://www.dbestech.com

// Mark: Repository
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

// Mark: Controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
