import 'package:bookstore_crud/controllers/cart_controller.dart';
import 'package:bookstore_crud/controllers/popular_product_controller.dart';
import 'package:bookstore_crud/routes/route_helper.dart';
import 'package:bookstore_crud/utils/colors.dart';
import 'package:bookstore_crud/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String from;

  const PopularFoodDetail(
      {super.key, required this.pageId, required this.from});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initData(Get.find<CartController>(), product);

    var star = int.parse('${product.stars}');
    var unStar = 5 - star;

    return Scaffold(
      body: Stack(children: [
        // Mark: Background Image
        Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 350,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "${Constants.BASE_URL}/uploads/${product.img!}")
                      // image: AssetImage("assets/images/food2.jpeg"),
                      )),
            )),
        // Mark: Back and add to cart button
        Positioned(
            left: 20,
            right: 20,
            top: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (from == 'cart_page') {
                      Get.toNamed(RouteHelper.getCart());
                    } else {
                      Get.toNamed(RouteHelper.initial);
                    }
                  },
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppColors.buttonBackgroundColor,
                          borderRadius: BorderRadius.circular(25)),
                      child: const AppIcon(
                          icon: Icons.arrow_back_ios_new,
                          size: 50,
                          sizeIcon: 18)),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: AppColors.buttonBackgroundColor,
                      borderRadius: BorderRadius.circular(25)),
                  child: GetBuilder<PopularProductController>(
                      builder: (popularProduct) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getCart());
                          },
                          child: const AppIcon(
                            icon: Icons.shopping_cart_outlined,
                            size: 50,
                            sizeIcon: 22,
                          ),
                        ),
                        popularProduct.totalItemsInCart == '0'
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
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: BigText(
                                    size: 10,
                                    text: popularProduct.totalItemsInCart,
                                    color: Colors.white,
                                  ),
                                )),
                      ],
                    );
                  }),
                ),
              ],
            )),
        // Mark: Info food
        Positioned(
          left: 0,
          right: 0,
          top: Dimensions.popularFoodImgSize - 20,
          bottom: 0,
          child: Container(
            padding:
                EdgeInsets.only(left: 20, right: 20, top: Dimensions.height20),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              BigText(
                text: product.name!,
                size: 22,
                color: Colors.black,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Wrap(
                        direction: Axis.horizontal,
                        spacing: 1.0, // gap giua cac item
                        // runSpacing: 14.0, // gap between lines
                        children: List.generate(star, (index) {
                          return const Icon(
                            Icons.star,
                            color: AppColors.mainColor,
                            size: 15,
                          );
                        }),
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        spacing: 1.0, // gap giua cac item
                        // runSpacing: 14.0, // gap between lines
                        children: List.generate(unStar, (index) {
                          return const Icon(
                            Icons.star,
                            color: AppColors.textColor,
                            size: 15,
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SmallText(text: "${product.stars!}"),
                  const SizedBox(
                    width: 10,
                  ),
                  const SmallText(text: "1287"),
                  const SizedBox(
                    width: 3,
                  ),
                  const SmallText(text: "comments"),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconAndText(
                    icon: Icons.circle_sharp,
                    text: "Normal",
                    textColor: AppColors.mainBlackColor,
                    iconColor: AppColors.yellowColor,
                  ),
                  IconAndText(
                    icon: Icons.location_on,
                    text: "1.7 km",
                    textColor: AppColors.mainBlackColor,
                    iconColor: AppColors.mainColor,
                  ),
                  IconAndText(
                    icon: Icons.access_time_rounded,
                    text: "32 min",
                    textColor: AppColors.mainBlackColor,
                    iconColor: Colors.orangeAccent,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const BigText(
                text: "Introduce",
                size: 18,
                color: AppColors.titleColor,
              ),
              const SizedBox(
                height: 10,
              ),
              // Mark: Expanded Tex
              Expanded(
                  child: SingleChildScrollView(
                child: ExpandableTextWidget(
                  colorText: AppColors.titleColor,
                  text: product.description!,
                ),
              ))
            ]),
          ),
        )
      ]),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularProduct) {
        return Container(
          height: 120,
          padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height30,
              left: Dimensions.edgeInsets20,
              right: Dimensions.edgeInsets20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2)),
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
                    GestureDetector(
                      onTap: () {
                        popularProduct.setQuantity(false);
                      },
                      child:
                          const Icon(Icons.remove, color: AppColors.signColor),
                    ),
                    const SizedBox(width: 5),
                    BigText(
                      text: "${popularProduct.inCartItems}",
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        popularProduct.setQuantity(true);
                      },
                      child: const Icon(Icons.add, color: AppColors.signColor),
                    ),
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
                    popularProduct.addItem(product);
                  },
                  child: BigText(text: "\$${product.price!} | Add to cart"),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
