import 'package:bookstore_crud/pages/homeFoodPage/main_food_page.dart';
import 'package:bookstore_crud/utils/colors.dart';
import 'package:bookstore_crud/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PersistentTabController _persistentTabController;

  List pages = [
    MainFoodPage(),
    Container(
      child: BigText(text: '1212'),
    )
  ];

  void onTapBottomNavigationBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: pages[_selectedIndex],
  //     bottomNavigationBar: BottomNavigationBar(
  //         selectedItemColor: AppColors.mainColor,
  //         unselectedItemColor: AppColors.textColor,
  //         // showSelectedLabels: false,
  //         // showUnselectedLabels: false,
  //         // selectedFontSize: 2,
  //         currentIndex: _selectedIndex,
  //         onTap: onTapBottomNavigationBar,
  //         items: const [
  //           BottomNavigationBarItem(
  //               icon: Icon(Icons.home_outlined), label: 'Home'),
  //           BottomNavigationBarItem(
  //               icon: Icon(Icons.settings_outlined), label: 'Settings')
  //         ]),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    _persistentTabController = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      MainFoodPage(),
      Container(
        child: BigText(text: 'Cart'),
      ),
      Container(
        child: BigText(text: 'Settings'),
      )
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_outlined),
        title: ("Home"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.textColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_cart_outlined),
        title: ("Cart"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.textColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings_outlined),
        title: ("Settings"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.textColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _persistentTabController,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style13, // Choose the nav bar style with this property.
    );
  }
}
