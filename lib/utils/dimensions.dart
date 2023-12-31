import 'package:get/get.dart';

// 가로모드일 때 문제가 있는거 일단은 해결했다.
class Dimensions {
  // screensize
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  // bigger Axis
  static double biggerAxis =
      screenHeight >= screenWidth ? screenHeight : screenWidth;
  static double smallerAxis =
      screenHeight >= screenWidth ? screenWidth : screenHeight;

  // Splash Screen Logo and characters
  static double splashLogo = biggerAxis / (844 / 300);
  static double splashCharacter = biggerAxis / (844 / 80);

  // for food_page_body mother container
  static double pageView = biggerAxis / 2.64;

  // for food_page_body
  static double pageViewContainer = biggerAxis / 3.84;

  // for food_page_body sub container
  static double pageViewTextContainer = biggerAxis / 7.03;

  // text sizes
  static double smallTextSize = biggerAxis / (844 / 14);
  static double bigTextSize = biggerAxis / (844 / 20);
  static double font9 = biggerAxis / (844 / 9);
  static double font12 = biggerAxis / (844 / 12);
  static double font14 = biggerAxis / (844 / 14);
  static double font16 = biggerAxis / (844 / 16);
  static double font20 = biggerAxis / (844 / 20);
  static double font26 = biggerAxis / (844 / 26);

  // dynamic height
  static double height5 = biggerAxis / (844 / 5);
  static double height10 = biggerAxis / 84.4;
  static double height15 = biggerAxis / 56.27;
  static double height20 = biggerAxis / 42.2;
  static double height30 = biggerAxis / (844 / 30);
  static double height45 = biggerAxis / (844 / 45);

  // dynamic width
  static double edgeInsets2 = biggerAxis / (844 / 2);
  static double edgeInsets3 = biggerAxis / (844 / 3);
  static double edgeInsets5 = biggerAxis / (844 / 5);
  static double edgeInsets10 = biggerAxis / 84.4;
  static double edgeInsets15 = biggerAxis / 56.27;
  static double edgeInsets20 = biggerAxis / 42.2;
  static double edgeInsets30 = biggerAxis / (844 / 30);
  static double edgeInsets45 = biggerAxis / (844 / 45);

  // radius
  static double radius5 = biggerAxis / (844 / 5);
  static double radius15 = biggerAxis / (844 / 15);
  static double radius20 = biggerAxis / (844 / 20);
  static double radius30 = biggerAxis / (844 / 30);

  // icon
  static double icon20 = biggerAxis / (844 / 20);
  static double icon24 = biggerAxis / (844 / 24);
  static double icon16 = biggerAxis / (844 / 16);

  // Popular List View Size
  static double listViewImgSize = smallerAxis / (390 / 120);
  static double listViewTextContainerSize = smallerAxis / (390 / 100);

  // Popular View Detail
  static double popularFoodImgSize = biggerAxis / (844 / 350);

  // bottomNavigationBar height
  static double bottomNavigationBarHeight = biggerAxis / (844 / 95);

}
