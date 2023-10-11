import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/constants/appSizes.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/constants/app_variables.dart';
import 'package:what_shop/controller/shop_details_by_id_controller.dart';
import 'package:what_shop/models/shop_details_by_id_model.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/product_card.dart';

class ShopDetailsHomeScreen extends StatefulWidget {
  const ShopDetailsHomeScreen({super.key});

  @override
  State<ShopDetailsHomeScreen> createState() => _ShopDetailsHomeScreen();
}

class _ShopDetailsHomeScreen extends State<ShopDetailsHomeScreen> {
  final ShopDetailsByIdController shopDetailsByIdController =
      Get.put(ShopDetailsByIdController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    final data = shopDetailsByIdController;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: Get.width,
        child: Container(
          child: Column(
            children: [mainCarousel(), footerCarousel()],
          ),
        ),
      ),
    ));
  }

  //This widget is the items of main banner
  List<Widget> mainCarouselItems() {
    final itemList = shopDetailsByIdController.banner.value?.firstad;

    if (itemList == null || itemList.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: Get.width,
            height: 170,
            decoration: BoxDecoration(
                color: AppColors.fontOnSecondary,
                borderRadius: BorderRadius.circular(13)),
          ),
        ),
      ];
    }

    // Filtering out any possible null items and returning the list.
    return itemList.where((banner) => banner != null).map((banner) {
      return Container(
          width: Get.width,
          height: 170,
          child: Image.network(AppVariables.baseUrl + (banner.image ?? ''),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset(AppImages.graphicImage1)));
    }).toList();
  }

  // main banner
  Widget mainCarousel() {
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

  //This widget is the items of footer banner
  List<Widget> footerCarouselItems() {
    final itemList = shopDetailsByIdController.banner.value?.firstad;

    if (itemList == null || itemList.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: Get.width,
            height: 170,
            decoration: BoxDecoration(
                color: AppColors.fontOnSecondary,
                borderRadius: BorderRadius.circular(13)),
          ),
        ),
      ];
    }

    // Filtering out any possible null items and returning the list.
    return itemList.where((banner) => banner != null).map((banner) {
      return Container(
          width: Get.width,
          height: 170,
          child: Image.network(AppVariables.baseUrl + (banner.image ?? ''),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset(AppImages.graphicImage1)));
    }).toList();
  }

  // footer banner
  Widget footerCarousel() {
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

  Widget listHeading(BuildContext context,
      {required headingText, required onTap}) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 13,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PrimaryText(
            text: headingText,
            fontSize: 11,
          ),
          TouchableOpacity(
            onTap: onTap,
            child: const Text(
              'View all',
              style: TextStyle(color: AppColors.teal, fontSize: 9),
            ),
          )
        ],
      ),
    );
  }
}
