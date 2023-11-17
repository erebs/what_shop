import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/constants/appSizes.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/controller/cart_count_controller.dart';
import 'package:what_shop/controller/home_screen_controller.dart';
import 'package:what_shop/controller/product_search_controller.dart';
import 'package:what_shop/controller/shop_information_controller.dart';
import 'package:what_shop/controller/user_data_controller.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/utils/shared_pref_util.dart';
import 'package:what_shop/views/screens/whats/product_search_screen.dart';
import 'package:what_shop/views/screens/whats/profile_screen.dart';
import 'package:what_shop/views/screens/whats/shop_data_screen.dart';
import 'package:what_shop/views/screens/widget/app_bar.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/shop_page_app_bar.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  late final ShopInformationController shopInformationController;
  final controller = Get.put(CartCountController(), permanent: true);
  final dataFromPreveScreen = Get.arguments;
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  final UserDataController userDataController = Get.find();
 final ProductSearchController productSearchController = Get.put(ProductSearchController(shopId:Get.arguments));
  var _currentIndex = 0;
  final List<Widget> _pages = [
    ShopDataScreen(),
    ProductSearchScreen(),
    Center(child: Text('Not available')),
    ProfileScreen()
  ];

  static const double iconSize = 22;

  void initState() {
    super.initState();
    shopInformationController = Get.put(ShopInformationController(shopId:dataFromPreveScreen));
    print(' data from preve main screen$dataFromPreveScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShopAppBar(
logo: shopInformationController.shopInformation.value?.shopDetails.logo ?? '',
        isHome: true,
        shopId: '',
      ),
      drawer: Drawer(
        width: Get.width * 0.67,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 0,
                  sigmaY: 5,
                ),
                child: Container(
                  color: Colors.grey.shade700.withOpacity(.8),
                )),
            SingleChildScrollView(
              child: SafeArea(
                  child: Container(
                      constraints: BoxConstraints(minHeight: Get.height),
                      padding: const EdgeInsets.symmetric(vertical: 27),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: horizontalPadding),
                              alignment: Alignment.centerLeft,
                              height: 85,
                              width: Get.width * 0.67,
                              color: AppColors.primaryDark,
                              child: Obx(
                                () => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PrimaryText(
                                      text: userDataController
                                              .userData.value?.details.name ??
                                          'user name',
                                      color: AppColors.inputBackgroundColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    PrimaryText(
                                      text: userDataController
                                              .userData.value?.details.email ??
                                          'yourmail@gmail.com',
                                      color: AppColors.inputBackgroundColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              )),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: horizontalPadding),
                              child: Column(
                                children: [
                                  drawerLink(context, onTap: () {
                                    Get.offAndToNamed(RouteName.homeScreen);
                                  }, icon: Remix.store_3_fill, title: 'Shops'),
                                  drawerLink(context, onTap: () {
                                    Get.back();
                                    Get.toNamed(RouteName.orderHistoryScreen);
                                  },
                                      icon: Remix.shopping_cart_2_fill,
                                      title: 'My Orders'),
                                  drawerLink(context, onTap: () {
                                    Get.back();
                                    Get.toNamed(RouteName.addressScreen);
                                  },
                                      icon: Remix.user_location_fill,
                                      title: 'My Address'),
                                  drawerLink(context,
                                      onTap: () {},
                                      icon: Remix.map_pin_5_fill,
                                      title: 'Select PinCode'),
                                  drawerLink(context, onTap: () {
                                    SharedPrefUtil().deleteToken();
                                    Get.offAllNamed(RouteName.loginScreen);
                                  },
                                      icon: Remix.logout_circle_fill,
                                      title: 'Logout'),
                                  const Divider(
                                    color: AppColors.inputBackgroundColor,
                                    thickness: 1,
                                  ),
                                  drawerLink(context,
                                      onTap: () {},
                                      icon: Remix.phone_fill,
                                      title: 'Contact Us'),
                                  drawerLink(context,
                                      onTap: () {},
                                      icon: Remix.information_fill,
                                      title: 'About Us'),
                                  drawerLink(context,
                                      onTap: () {},
                                      icon: Remix.file_list_3_fill,
                                      title: 'Terms & Conditions'),
                                  drawerLink(context,
                                      onTap: () {},
                                      icon: Remix.file_list_3_fill,
                                      title: 'Privacy And Policy'),
                                ],
                              )),
                        ],
                      ))),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primaryDark,
        selectedItemColor: AppColors.fontOnSecondary,
        currentIndex: _currentIndex,
        unselectedItemColor: AppColors.inputBackgroundColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Remix.home_2_line,
                color: AppColors.inputBackgroundColor,
                size: iconSize,
              ),
              label: '',
              activeIcon: Icon(
                Remix.home_2_line,
                color: AppColors.fontOnSecondary,
                size: iconSize + 2,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Remix.search_2_line,
                color: AppColors.inputBackgroundColor,
                size: iconSize,
              ),
              label: '',
              activeIcon: Icon(
                Remix.search_2_line,
                color: AppColors.fontOnSecondary,
                size: iconSize + 4,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Remix.notification_2_line,
                color: AppColors.inputBackgroundColor,
                size: iconSize,
              ),
              label: '',
              activeIcon: Icon(
                Remix.notification_2_line,
                color: AppColors.fontOnSecondary,
                size: iconSize + 4,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Remix.user_line,
                color: AppColors.inputBackgroundColor,
                size: iconSize,
              ),
              label: '',
              activeIcon: Icon(
                Remix.user_line,
                color: AppColors.fontOnSecondary,
                size: iconSize + 4,
              ))
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );
  }

  Widget drawerLink(BuildContext context,
      {required IconData icon, required String title, required onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TouchableOpacity(
        activeOpacity: .8,
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          width: double.maxFinite,
          height: 50,
          child: Row(
            children: [
              Icon(
                icon,
                color: AppColors.inputBackgroundColor,
                size: 22,
              ),
              const SizedBox(
                width: 12,
              ),
              PrimaryText(
                text: title,
                fontWeight: FontWeight.w600,
                color: AppColors.fontOnSecondary,
                fontSize: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
