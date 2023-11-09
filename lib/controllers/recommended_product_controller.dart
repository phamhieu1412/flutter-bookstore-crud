import 'package:bookstore_crud/controllers/cart_controller.dart';
import 'package:bookstore_crud/db/repository/recommended_product_repo.dart';
import 'package:bookstore_crud/models/products_model.dart';
import 'package:bookstore_crud/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  late CartController _cartController;

  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList => _recommendedProductList;

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getRecommendedProductList() async {
    _isFetching = true;
    Response response =
        await recommendedProductRepo.getRecommendedProductList();

    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isFetching = false;
      update();
    } else {
      _recommendedProductList = [];
      _isFetching = false;
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = _quantity + 1;
    } else if (!isIncrement && _quantity > 0) {
      _quantity = _quantity - 1;
    } else if (!isIncrement && _quantity < 0) {
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
