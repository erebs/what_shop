import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/constants/appSizes.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/views/screens/widget/app_bar.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/secondary_custom_app_bar.dart';
import 'package:what_shop/views/widgets/buttons.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:SecondaryCustomAppBar(title: 'Orders'),
        body: Container(
            color: AppColors.inputBackgroundColor,
            padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: 20),
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                dummyOrderCard(),],
            )),
      ),
    );
  }

  // this is a card to show when orders are loading
  Widget dummyOrderCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
      decoration: BoxDecoration(
          color: AppColors.fontOnSecondary,
          borderRadius: BorderRadius.circular(12)),
      width: Get.width,
      height: 110,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.inputBackgroundColor)),
              width: 72,
              height: 75,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          SecondaryButton(
            buttonText: 'Delete',
            onTap: () {},
            height: 20,
            width: 45,
            fontColor: AppColors.mediumLight,
            borderColor: AppColors.inputBackgroundColor,
            borderRadius: 7,
            fontSize: 10,
          )
        ],
      ),
    );
  }
  // this is card widget for order
  Widget orderCard(
      {required onTap,
      required String productName,
      required String offerPrice,
      required String price,
      required String status,
      required onDelete}) {
    return TouchableOpacity(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
        decoration: BoxDecoration(
            color: AppColors.fontOnSecondary,
            borderRadius: BorderRadius.circular(12)),
        width: Get.width,
        height: 110,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 72,
                height: 75,
                child: Image.asset(
                  AppImages.banner,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    productName.isNotEmpty ? productName : 'Product Name',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      PrimaryText(
                        text: offerPrice,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        price,
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 9,
                            color: AppColors.mediumLight),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: PrimaryText(
                      text: status,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
            SecondaryButton(
              buttonText: 'Delete',
              onTap: onDelete,
              height: 20,
              width: 45,
              fontColor: AppColors.mediumLight,
              borderColor: AppColors.inputBackgroundColor,
              borderRadius: 7,
              fontSize: 10,
            )
          ],
        ),
      ),
    );
  }
}
