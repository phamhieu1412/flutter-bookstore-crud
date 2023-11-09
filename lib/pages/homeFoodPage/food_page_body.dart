import 'package:bookstore_crud/controllers/popular_product_controller.dart';
import 'package:bookstore_crud/controllers/recommended_product_controller.dart';
import 'package:bookstore_crud/models/products_model.dart';
import 'package:bookstore_crud/pages/popularFoodDetail/popular_food_detail.dart';
import 'package:bookstore_crud/routes/route_helper.dart';
import 'package:bookstore_crud/utils/colors.dart';
import 'package:bookstore_crud/utils/constants.dart';
import 'package:bookstore_crud/utils/dimensions.dart';
import 'package:bookstore_crud/widgets/big_text.dart';
import 'package:bookstore_crud/widgets/loading.dart';
import 'package:bookstore_crud/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/icon_and_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Danh sách slide
        // Mark: GetBuilder => dùng để truy cập vào class PopularProductController
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isFetching
              ? const Loading()
              : Container(
                  // color: Colors.redAccent,
                  margin: const EdgeInsets.only(top: 0),
                  height: Dimensions.pageView,
                  child: PageView.builder(
                      controller:
                          pageController, // => toc do luot qua cua slide
                      itemCount: popularProducts
                          .popularProductList.length, // => so luong item slider
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }),
                );
        }),
        const SizedBox(
          height: 5,
        ),
        // Danh sách dots
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isNotEmpty
                ? popularProducts.popularProductList.length
                : 1,
            position: _currentPageValue,
            decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0))),
          );
        }),
        //
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const BigText(text: "Recommended"),
              const SizedBox(width: 10),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: const BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                margin: const EdgeInsets.only(bottom: 1),
                child: const SmallText(
                  text: "Food Pairing",
                  color: Colors.black26,
                ),
              ),
            ],
          ),
        ),
        // list posts
        GetBuilder<RecommendedProductController>(
            builder: (recommendedProducts) {
          return Container(
            margin: const EdgeInsets.only(top: 0),
            height: 1400,
            child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                physics: const NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                itemCount: recommendedProducts.recommendedProductList.length,
                itemBuilder: (context, index) {
                  return _buildPostItem(
                      recommendedProducts.recommendedProductList[index], index);
                }),
          );
        }),
      ],
    );
  }

  Widget _buildPageItem(int idx, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (idx == _currentPageValue.floor()) {
      // vị trí index -2 -1 [0] 1 2
      var currentScale = 1 - (_currentPageValue - idx) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (idx == _currentPageValue.floor() + 1) {
      // vị trí index -2 -1 0 [1] 2
      var currentScale =
          _scaleFactor + (_currentPageValue - idx) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (idx == _currentPageValue.floor() - 1) {
      // vị trí index -2 [-1] 0 1 2
      var currentScale = 1 - (_currentPageValue - idx) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      // vị trí index [-2] -1 0 1 [2]
      var currentScale = 0.2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor), 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(idx, 'home_page'));
            },
            child: Container(
              height: Dimensions
                  .pageViewContainer, // => sao bỏ vào stack thì height mới được active nhỉ?
              margin: const EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                  color: idx.isEven ? Colors.limeAccent : Colors.blueAccent,
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "${Constants.BASE_URL}/uploads/${popularProduct.img!}"))),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              // => Stack:  xếp chồng container với nhau
              children: [
                Container(
                  height: Dimensions
                      .pageViewTextContainer, // => sao bỏ vào stack thì height mới được active nhỉ?
                  margin:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0xFFe8e8e8),
                            blurRadius: 5,
                            offset: Offset(0, 5)),
                        BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                        BoxShadow(color: Colors.white, offset: Offset(5, 0))
                      ]),
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 15, left: 20, right: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: popularProduct.name!),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Wrap(
                                direction: Axis.horizontal,
                                spacing: 1.0, // gap giua cac item
                                // runSpacing: 14.0, // gap between lines
                                children: List.generate(popularProduct.stars!,
                                    (index) {
                                  return const Icon(
                                    Icons.star,
                                    color: AppColors.mainColor,
                                    size: 15,
                                  );
                                }),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SmallText(text: "${popularProduct.stars!}"),
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
                          )
                        ]),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPostItem(ProductModel recommendedProduct, int index) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(RouteHelper.getRecommendFood(index));
        },
        child: Row(
          children: [
            // image post
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "${Constants.BASE_URL}/uploads/${recommendedProduct.img!}"))),
            ),
            // info post
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Colors.white,
              ),
              child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 7),
                      BigText(text: recommendedProduct.name!),
                      const SizedBox(height: 5),
                      SmallText(
                          text:
                              "${recommendedProduct.description!.substring(0, 25)}..."),
                      const SizedBox(height: 5),
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
                      const SizedBox(height: 7),
                    ],
                  )),
            ))
          ],
        ),
      ),
    );
  }
}
