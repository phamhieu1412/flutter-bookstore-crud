import 'package:bookstore_crud/controllers/cart_controller.dart';
import 'package:bookstore_crud/controllers/recommended_product_controller.dart';
import 'package:bookstore_crud/routes/route_helper.dart';
import 'package:bookstore_crud/utils/colors.dart';
import 'package:bookstore_crud/utils/constants.dart';
import 'package:bookstore_crud/utils/dimensions.dart';
import 'package:bookstore_crud/widgets/app_icon.dart';
import 'package:bookstore_crud/widgets/big_text.dart';
import 'package:bookstore_crud/widgets/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendFoodDetail extends StatelessWidget {
  final int pageId;

  const RecommendFoodDetail({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<RecommendedProductController>()
        .initData(Get.find<CartController>(), product);

    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              // Mark: Hiển thị icon back mặc định
              automaticallyImplyLeading: false,
              toolbarHeight: 70, // Do dai toolbar
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: const AppIcon(
                        icon: Icons.clear,
                        size: 50,
                        sizeIcon: 20,
                      ),
                    ),
                    Row(
                      children: [
                        const AppIcon(
                          icon: Icons.favorite_border,
                          size: 50,
                          sizeIcon: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GetBuilder<RecommendedProductController>(
                            builder: (recommendedProduct) {
                          return Stack(
                            children: [
                              const AppIcon(
                                icon: Icons.shopping_cart_outlined,
                                size: 50,
                                sizeIcon: 20,
                              ),
                              recommendedProduct.totalItemsInCart == '0'
                                  ? Container()
                                  : Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        width: 22,
                                        height: 22,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColors.mainColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: BigText(
                                          size: 10,
                                          text: recommendedProduct
                                              .totalItemsInCart,
                                          color: Colors.white,
                                        ),
                                      )),
                            ],
                          );
                        })
                      ],
                    )
                  ]),
              pinned: true,
              expandedHeight: 250,
              backgroundColor: Colors.pink,
              flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                "${Constants.BASE_URL}/uploads/${product.img!}",
                width: double.maxFinite,
                fit: BoxFit.cover,
              )),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: BigText(
                    text: "${product.name!}",
                    size: Dimensions.font20,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(
                    left: Dimensions.height10,
                    right: Dimensions.height10,
                    top: Dimensions.height15),
                child: ExpandableTextWidget(
                  colorText: AppColors.titleColor,
                  text: "${product.description!}",
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<RecommendedProductController>(
            builder: (recommendedProduct) {
          return Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            decoration: const BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        recommendedProduct.setQuantity(false);
                      },
                      child: const AppIcon(
                        icon: Icons.remove,
                        backgroundColorIcon: AppColors.mainColor,
                        colorIcon: Colors.white,
                        size: 32,
                        sizeIcon: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    BigText(
                        text:
                            "\$${product.price!} X ${recommendedProduct.inCartItems}"),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        recommendedProduct.setQuantity(true);
                      },
                      child: const AppIcon(
                        icon: Icons.add,
                        backgroundColorIcon: AppColors.mainColor,
                        colorIcon: Colors.white,
                        size: 32,
                        sizeIcon: 24,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    recommendedProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height10,
                        left: Dimensions.height20,
                        bottom: Dimensions.height10,
                        right: Dimensions.height20),
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BigText(
                          text: "\$ ${product.price!}" + " ",
                          color: Colors.white,
                        ),
                        const BigText(
                            text: " " + "Add to cart", color: Colors.white),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }));
  }
}
