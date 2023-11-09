import 'package:bookstore_crud/controllers/cart_controller.dart';
import 'package:bookstore_crud/models/products_model.dart';
import 'package:bookstore_crud/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bookstore_crud/db/repository/popular_product_repo.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;

  // Mark: mọi thứ lấy từ cartController nên thông qua truy vấn từ productController
  late CartController _cartController;

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    _isFetching = true;
    Response response = await popularProductRepo.getPopularProductList();

    print("get product 1 ${response.statusCode}");
    if (response.statusCode == 200) {
      print("get product 2");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      print(_popularProductList);
      _isFetching = false;
      update();
    } else {
      _popularProductList = [];
      _isFetching = false;
    }
  }

  void setQuantity(bool isIncrement) {
    print(_quantity + _inCartItems);
    if (isIncrement) {
      _quantity = _quantity + 1;
    } else if (!isIncrement && (_quantity + _inCartItems) > 0) {
      _quantity = _quantity - 1;
    } else if (!isIncrement && (_quantity + _inCartItems) == 0) {
      Get.snackbar("Item count", "You can't reduce more!",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
    }
    update();
  }

  void initData(CartController cartController, ProductModel product) {
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cartController;

    // Mark: Kiểm tra xem giỏ hàng hiện tại có bao nhiêu sản phẩm trong giỏ
    var exist = false;
    exist = _cartController.existInCart(product);

    if (exist) {
      _inCartItems = _cartController.getQuantity(product);
    }
  }

  void addItem(ProductModel product) {
    if (_quantity + _inCartItems > 0) {
      _cartController.addItem(product, _quantity);
      _quantity = 0;
      _inCartItems = _cartController.getQuantity(product);
    } else {
      Get.snackbar("Item count", "You should add at least one item into cart!",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
    }

    update();
  }

  String get totalItemsInCart {
    return _cartController.totalItemsInCart;
  }
}
