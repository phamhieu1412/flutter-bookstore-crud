import 'package:bookstore_crud/controllers/cart_controller.dart';
import 'package:bookstore_crud/controllers/popular_product_controller.dart';
import 'package:bookstore_crud/controllers/recommended_product_controller.dart';
import 'package:bookstore_crud/routes/route_helper.dart';
import 'package:bookstore_crud/utils/colors.dart';
import 'package:bookstore_crud/utils/constants.dart';
import 'package:bookstore_crud/utils/dimensions.dart';
import 'package:bookstore_crud/widgets/app_icon.dart';
import 'package:bookstore_crud/widgets/big_text.dart';
import 'package:bookstore_crud/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: Dimensions.height20 * 3,
              left: Dimensions.height15,
              right: Dimensions.height15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const AppIcon(
                      icon: Icons.arrow_back_ios_new_outlined,
                      colorIcon: Colors.white,
                      backgroundColorIcon: AppColors.mainColor,
                      sizeIcon: 24,
                      size: 50,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const AppIcon(
                          icon: Icons.home_outlined,
                          colorIcon: Colors.white,
                          backgroundColorIcon: AppColors.mainColor,
                          sizeIcon: 30,
                          size: 50,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Stack(
                        children: [
                          const AppIcon(
                            icon: Icons.shopping_cart_outlined,
                            colorIcon: Colors.white,
                            backgroundColorIcon: AppColors.mainColor,
                            sizeIcon: 26,
                            size: 50,
                          ),
                          Positioned(
                              top: 5,
                              right: 5,
                              child: Container(
                                alignment: Alignment.center,
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: SmallText(
                                  text: "99+",
                                  color: Colors.black,
                                  size: Dimensions.font9,
                                ),
                              ))
                        ],
                      ),
                    ],
                  )
                ],
              )),
          GetBuilder<CartController>(builder: (cart) {
            return Positioned(
                top: Dimensions.height20 * 6,
                right: Dimensions.height15,
                left: Dimensions.height15,
                bottom: 0,
                child: Container(
                  child: MediaQuery.removePadding(
                      // Mark: Xóa padding
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                          itemCount: cart.getItems.length,
                          itemBuilder: (_, index) {
                            var item = cart.getItems[index];

                            return Container(
                              height: 100,
                              width: double.maxFinite,
                              padding: const EdgeInsets.only(left: 5),
                              margin: const EdgeInsets.only(
                                bottom: 20,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  var popularIndex =
                                      Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(
                                              cart.getItems[index].product!);

                                  if (popularIndex >= 0) {
                                    Get.toNamed(RouteHelper.getPopularFood(
                                        popularIndex, 'cart_page'));
                                  } else {
                                    var recommendedIndex =
                                        Get.find<RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(
                                                cart.getItems[index].product!);
                                    Get.toNamed(RouteHelper.getRecommendFood(
                                        recommendedIndex));
                                  }
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "${Constants.BASE_URL}/uploads/${item.img!}"))),
                                    ),
                                    // Mark: Sử dụng Expanded để cho full width
                                    Expanded(
                                        child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 10,
                                          right: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          BigText(
                                              text: item.name!,
                                              size: Dimensions.font20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                text: "\$ ${item.price!}",
                                                size: Dimensions.font20,
                                                color: Colors.redAccent,
                                              ),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      cart.addItem(
                                                          item.product!, -1);
                                                    },
                                                    child: const Icon(
                                                        Icons.remove,
                                                        color: AppColors
                                                            .signColor),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  BigText(
                                                    text: "${item.quantity}",
                                                  ),
                                                  const SizedBox(width: 5),
                                                  GestureDetector(
                                                    onTap: () {
                                                      cart.addItem(
                                                          item.product!, 1);
                                                    },
                                                    child: const Icon(Icons.add,
                                                        color: AppColors
                                                            .signColor),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            );
                          })),
                ));
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (cart) {
        return Container(
          height: 100,
          padding: EdgeInsets.only(
              top: Dimensions.height20,
              bottom: Dimensions.height20,
              left: Dimensions.edgeInsets20,
              right: Dimensions.edgeInsets20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius5 * 2),
                  topRight: Radius.circular(Dimensions.radius5 * 2)),
              color: AppColors.buttonBackgroundColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    BigText(
                      text: "\$ ${cart.getTotalMoney}",
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(Dimensions.edgeInsets20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.mainColor,
                ),
                child: GestureDetector(
                  onTap: () {
                    // popularProduct.addItem(product);
                  },
                  child: const BigText(text: "Checkout"),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
