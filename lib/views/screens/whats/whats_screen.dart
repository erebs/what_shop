import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/constants/app_variables.dart';
import 'package:what_shop/controller/home_screen_controller.dart';
import 'package:what_shop/controller/location_controller.dart';
import 'package:what_shop/models/shops_near_user_model.dart';
import 'package:what_shop/views/screens/whats/shop_details_screen.dart';
import 'package:what_shop/views/screens/widget/app_bar.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/shop_card.dart';
import 'package:what_shop/views/widgets/buttons.dart';
import 'package:what_shop/views/widgets/inputs.dart';

class WhatScreen extends StatefulWidget {
  const WhatScreen({Key? key}) : super(key: key); // Corrected super call

  @override
  State<WhatScreen> createState() => _WhatScreenState();
}

class _WhatScreenState extends State<WhatScreen> {
  final HomeScreenController homeScreenController =
  Get.put(HomeScreenController());
  final LocationController locationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: Get.height),
          color: AppColors.inputBackgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               carousel(),
              _buildLocationRow(context),
              const SizedBox(height:5),
              Obx(() {
                if (homeScreenController.isLoading.value) {
                  return Container(
                    height: Get.height / 2.5,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  );
                }
                return displayShops();
              }),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }


  // This widget is to pass items to carousel carousel
  List<Widget> mainCarouselItems() {
    final itemList = homeScreenController.shopsNearUser.value?.firstad;

    if (itemList == null || itemList.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: Get.width,
            height: 170,
            decoration: BoxDecoration(
                color: AppColors.fontOnSecondary,
                borderRadius: BorderRadius.circular(13)
            ),
          ),
        ),
      ];
    }

    // Filtering out any possible null items and returning the list.
    return itemList.where((banner) => banner != null).map((banner) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
            width: Get.width,
            height: 170,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.network(
                  AppVariables.baseUrl + banner.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset(AppImages.graphicImage1)
              ),
            )
        ),
      );
    }).toList();
  }


  Widget carousel() {
    return Obx(() {
      return CarouselSlider(
        items: mainCarouselItems(),
        options: CarouselOptions(
          height: 180,
          autoPlay: true,
          enlargeCenterPage: false,
          viewportFraction: 1.0,
        ),
      );
    });
  }

  // it display location box and apply button in row
  Widget _buildLocationRow(BuildContext context) {
    return Row(
      children: [
        locationBox(context, onTap: () {
          locationController.getLocationPermission(context: context);
        }, place: locationController.locality),
        const SizedBox(width: 8),
        Expanded(
          child: SecondaryButton(
            fontColor: AppColors.fontOnSecondary,
            borderRadius: 15,
            backgroundColor: AppColors.primary,
            width: Get.width * 0.4,
            height: 42,
            buttonText: 'APPLY',
            onTap: () {},
          ),
        ),
      ],
    );
  }

  // it is widget that display and the location TextField
  Widget locationBox(BuildContext context, {onTap, var place}) {
    return Container(
        height: 42,
        width: Get.width * 0.62,
        child: Obx(
          () => TextField(
            decoration: InputDecoration(
                fillColor: AppColors.fontOnSecondary,
                filled: true,
                contentPadding: const EdgeInsets.all(0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none),
                suffixIcon: const Icon(
                  Remix.arrow_down_s_line,
                  size: 14,
                ),
                prefixIcon: IconButton(
                  icon: const Icon(
                    Remix.map_pin_2_fill,
                    size: 14,
                    color: AppColors.primaryDark,
                  ),
                  onPressed: onTap,
                ),
                hintText: place?.value == '' ? 'Your location' : place?.value,
                hintStyle: const TextStyle(
                  fontSize: 10,
                )),
          ),
        ));
  }

// This widget Display all shops if pincode is not Provide
  Widget allDefaultShops() {
    final newshops = homeScreenController.shopData.value.newshops;
    if (newshops == null || newshops.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      constraints: const BoxConstraints(
          // You can set a max height if you want.
          // maxHeight: 500, // for example
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading(headingText: 'Newest Shops'),
          Container(
            height: 100, // you can adjust this value based on your need
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newshops.length,
              itemBuilder: (context, index) {
                final shop = newshops[index];
                return Padding(
                  padding: EdgeInsets.only(
                    right: (index != newshops.length - 1) ? 10.0 : 0,
                  ),
                  child: ShopCard(
                    image: shop.logo ?? '',
                    name: shop.name ?? '',
                    onTap: () {
                      print('hello');
                    },
                  ),
                );
              },
            ),
          ),
          buildShopListByCategory()
        ],
      ),
    );
  }

  //this widget disply all shops by category
  Widget buildShopListByCategory() {
    final category = homeScreenController.shopData.value.categories;
    if (category == null) {
      return const SizedBox.shrink();
    }
    return Column(
      children: category.map((category) {
        if (category.shops == null || category.shops!.isEmpty) {
          return const SizedBox
              .shrink(); // Return an empty widget if there are no shops for this category or it's null.
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading(headingText: category.categoryName),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: category.shops!.length,
                itemBuilder: (context, index) {
                  final shop = category.shops![index];
                  return Padding(
                    padding: EdgeInsets.only(
                        right:
                            (index != category.shops!.length - 1) ? 10.0 : 0),
                    child: ShopCard(
                        image: shop.logo ?? '',
                        name: shop.name ?? '',
                        onTap: () {
                          Get.to(ShopDetailsScreen());
                          // Get.toNamed(RouteName.shopDetailsScreen);
                        }),
                  );
                },
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  // This widget display shops near user after providing pincode
  Widget buildShopListFromPinCode() {
    final shopList = homeScreenController.shopsNearUser.value;

    // If there's no shopList or its categories are empty, return an empty widget.
    if (shopList == null || shopList.categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: shopList.categories.map((category) {
        final shops = category.shops;

        // If this category has no shops, return an empty widget.
        if (shops == null || shops.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0, bottom: 15, top: 18),
              child: PrimaryText(
                text: category.categoryName,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: shops.length,
                itemBuilder: (context, index) {
                  final shop = shops[index];
                  return Padding(
                    padding: EdgeInsets.only(
                        right: (index != shops.length - 1) ? 10.0 : 0),
                    child: ShopCard(
                      image: shop.logo ?? '',
                      name: shop.name,
                      onTap: () {
                        Get.to(const ShopDetailsScreen());
                        // Get.toNamed(RouteName.shopDetailsScreen);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  // this widget is to display shops conditionally on the basis of whether the user granted location access

  Widget displayShops() {
    if (locationController.isLocationGranted.value ||
        homeScreenController.shopsNearUser.value != null) {
      return buildShopListFromPinCode();
    } else {
      return allDefaultShops();
    }
  }
// THIS
}

//Heading is for the heading text of shop category

Widget heading({required headingText}) {
  return Padding(
    padding: const EdgeInsets.only(left: 7, bottom: 13, top: 18),
    child: PrimaryText(
      text: headingText,
      fontSize: 10,
      fontWeight: FontWeight.w500,
    ),
  );
}
