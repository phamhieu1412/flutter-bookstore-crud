import 'package:bookstore_crud/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // Mark: Background Image
        Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 350,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/food2.jpeg"))),
            )),
        // Mark: Back and add to cart button
        Positioned(
            left: 20,
            right: 20,
            top: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.buttonBackgroundColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: const AppIcon(
                        icon: Icons.arrow_back_ios_new,
                        size: 40,
                        sizeIcon: 18)),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColors.buttonBackgroundColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: const AppIcon(
                      icon: Icons.shopping_cart_outlined,
                      size: 40,
                      sizeIcon: 20),
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
              const BigText(
                text: "Mon an 1",
                size: 22,
                color: Colors.black,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 1.0, // gap giua cac item
                    // runSpacing: 14.0, // gap between lines
                    children: List.generate(5, (index) {
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
                  const SmallText(text: "4.5"),
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
              const Expanded(
                  child: SingleChildScrollView(
                child: ExpandableTextWidget(
                  colorText: AppColors.titleColor,
                  text:
                      "Day la doan text dai gioi thieu san pham cua chung toi nhe cac man. Neu yeu thich hay dat ngay no vao gio hang di nha. So luong co han ddo nha, toi noi truoc do. Neu yeu thich hay dat ngay no vao gio hang di nha. So luong co han ddo nha, toi noi truoc do.Neu yeu thich hay dat ngay no vao gio hang di nha. So luong co han ddo nha, toi noi truoc doDay la doan text dai gioi thieu san pham cua chung toi nhe cac man. Neu yeu thich hay dat ngay no vao gio hang di nha. So luong co han ddo nha, toi noi truoc do. Neu yeu thich hay dat ngay no vao gio hang di nha. So luong co han ddo nha, toi noi truoc do.Neu yeu thich hay dat ngay no vao gio hang di nha. So luong co han ddo nha, toi noi truoc doDay la doan text dai gioi thieu san pham cua chung toi nhe cac man. Neu yeu thich hay dat ngay no vao gio hang di nha. So luong co han ddo nha, toi noi truoc do. Neu yeu thich hay dat ngay no vao gio hang di nha. So luong co han ddo nha, toi noi truoc do.Neu yeu thich hay dat ngay no vao gio hang di nha. So luong co han ddo nha, toi noi truoc do Day la doan text dai gioi thieu san pham cua chung toi nhe cac man. Neu yeu thich hay dat ngay no vao gio hang di nha. So luong co han ddo nha, toi noi truoc do. Neu yeu thich hay dat ngay no vao gio hang di nha. So luong co han ddo nha, toi noi truoc do.Neu yeu thich hay dat ngay no vao gio hang di nha. So luong co han ddo nha, toi noi truoc do",
                ),
              ))
            ]),
          ),
        )
      ]),
      bottomNavigationBar: Container(
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
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: const Row(
                children: [
                  Icon(Icons.remove, color: AppColors.signColor),
                  SizedBox(width: 5),
                  BigText(
                    text: "0",
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.add, color: AppColors.signColor),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(Dimensions.edgeInsets20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.mainColor,
              ),
              child: const BigText(text: "\$110 | Add to cart"),
            )
          ],
        ),
      ),
    );
  }
}
