import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  void pressName() {}

  void searchBtn() {}

  void selectLocation() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            // color: Colors.pink,
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            margin: const EdgeInsets.only(top: 45, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  children: [
                    BigText(
                        text: 'Hello Tit',
                        color: AppColors.mainColor,
                        size: 24),
                    Row(
                      children: [
                        SmallText(
                          text: 'HaNoi',
                          color: Colors.black54,
                        ),
                        Icon(Icons.arrow_drop_down_outlined)
                        //  IconButton(
                        //         onPressed: selectLocation,
                        //         icon: Icon(Icons.arrow_drop_down_circle_rounded))
                      ],
                    )
                  ],
                ),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                    onPressed: searchBtn,
                    icon: const Icon(Icons.search),
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          const Expanded(
              child: SingleChildScrollView(
            child: FoodPageBody(),
          ))
        ],
      ),
    );
  }
}
