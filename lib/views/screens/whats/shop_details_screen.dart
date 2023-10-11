import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/constants/appSizes.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/controller/shop_details_by_id_controller.dart';
import 'package:what_shop/views/screens/whats/profile_screen.dart';
import 'package:what_shop/views/screens/whats/shop_details_home_screen.dart';
import 'package:what_shop/views/screens/widget/app_bar.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/shop_page_app_bar.dart';

class ShopDetailsScreen extends StatefulWidget {
  const ShopDetailsScreen({super.key});

  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  final ShopDetailsByIdController shopDetailsController = Get.put(permanent: false,ShopDetailsByIdController());
  var _currentIndex = 0;
  final List<Widget> _pages = [
    ShopDetailsHomeScreen(),
    Text('hello2'),
    Text('hello3'),
    ProfileScreen()
  ];

  static const double iconSize = 22;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ShopAppBar(
        isHome: true,
      ),
      drawer: Drawer(
        width: Get.width * 0.67,
backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX:0, sigmaY: 5,),
              child: Container(
                color: Colors.grey.shade700.withOpacity(.8),)),
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
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PrimaryText(
                                      text: 'Name',
                                      color: AppColors.teal,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    PrimaryText(
                                      text: 'mail@gmail.com',
                                      color: AppColors.inputBackgroundColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: horizontalPadding),
                                  child: Column(
                                    children: [
                                      drawerLink(context,
                                          onTap: (){},

                                          icon: Remix.store_3_fill, title: 'Shops'),
                                      drawerLink(context,
                                          onTap: (){},

                                          icon: Remix.shopping_cart_2_fill,
                                          title: 'My Orders'),
                                      drawerLink(context,
                                          onTap: (){},

                                          icon: Remix.user_location_fill,
                                          title: 'My Address'),
                                      drawerLink(context,
                                          onTap: (){},

                                          icon: Remix.map_pin_5_fill,
                                          title: 'Select PinCode'),
                                      drawerLink(context,
                                          onTap: (){},

                                          icon: Remix.logout_circle_fill,
                                          title: 'Logout'),
                                      const Divider(
                                        color: AppColors.inputBackgroundColor,
                                        thickness: 1,
                                      ),
                                      drawerLink(context,
                                          onTap: (){},

                                          icon: Remix.phone_fill, title: 'Contact Us'),
                                      drawerLink(context,
                                          onTap: (){},

                                          icon: Remix.information_fill,
                                          title: 'About Us'),
                                      drawerLink(context,
                                          onTap: (){},

                                          icon: Remix.file_list_3_fill,
                                          title: 'Terms & Conditions'),
                                      drawerLink(context,
                                          onTap: (){},
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
        selectedItemColor: AppColors.teal,
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
                color: AppColors.teal,
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
                color: AppColors.teal,
                size: iconSize + 2,
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
                color: AppColors.teal,
                size: iconSize + 2,
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
                color: AppColors.teal,
                size: iconSize + 2,
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
      {required IconData icon, required String title,required onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TouchableOpacity(
        activeOpacity:.8,

        onTap: onTap,
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
    );
  }
}
