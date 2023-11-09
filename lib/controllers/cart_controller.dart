import 'package:bookstore_crud/db/repository/cart_repo.dart';
import 'package:bookstore_crud/models/cart_model.dart';
import 'package:bookstore_crud/models/products_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get item => _items;

  List<CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;

    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;

        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExit: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });

      if (totalQuantity <= 0) {
        _items.remove(product.id!);
      }
    } else {
      _items.putIfAbsent(
          product.id!,
          () => CartModel(
                id: product.id,
                name: product.name,
                price: product.price,
                img: product.img,
                quantity: quantity,
                isExit: true,
                time: DateTime.now().toString(),
                product: product,
              ));
    }

    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id!)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }

    return quantity;
  }

  String get totalItemsInCart {
    if (_items.length > 99) {
      return '99+';
    }
    return '${_items.length}';
  }

  // Mark: Key-Value to List
  List<CartModel> get getItems {
    return _items.entries.map((e) => e.value).toList();
  }

  int get getTotalMoney {
    var total = 0;

    _items.forEach((key, value) {
      total = total + value.price! * value.quantity!;
    });

    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getProductsInCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;

    var storageLength = storageItems.length;
    print("storageLength" + storageLength.toString());

    for (int i = 0; i < storageLength; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  // Mark: hàm checkout
  void addItemToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }
}
