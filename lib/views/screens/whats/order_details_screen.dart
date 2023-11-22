import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:what_shop/constants/appSizes.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/constants/app_variables.dart';
import 'package:what_shop/controller/order_details_controller.dart';
import 'package:what_shop/utils/api_state_enum.dart';
import 'package:what_shop/views/screens/common/error_page.dart';
import 'package:what_shop/views/screens/widget/app_bar.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/secondary_custom_app_bar.dart';
import 'package:what_shop/views/widgets/buttons.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreen();
}

class _OrderDetailsScreen extends State<OrderDetailsScreen> {
  final OrderDetailsController orderDetailsController = Get.find();


  @override
  Widget build(BuildContext context) {
    Future<void> _downloadInvoice({required orderId}) async {
      final _url = Uri.parse('https://portal.umall.in/seller/invoice/$orderId');
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    }
    return SafeArea(
      child: Scaffold(
        appBar: SecondaryCustomAppBar(
          title: 'Orders',
        ),
        body: Container(
            color: AppColors.inputBackgroundColor,
            padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: 20),
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  if (orderDetailsController.orderDataFetchingState.value ==
                      DataState.Loading) {
                    return CircularProgressIndicator();
                  }
                  if (orderDetailsController.orderDataFetchingState.value ==
                      DataState.Error) {
                    return ErrorScreen(
                        buttonText: 'Go back',
                        errorMsg: orderDetailsController.errorMsg.value,
                        onTap: () {
                          Get.back();
                        });
                  }
                  if (orderDetailsController.orderDataFetchingState.value ==
                      DataState.Data) {
                    return Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: orderDetailsController
                                    .orderDetailsResponse
                                    .value
                                    ?.orderDetails
                                    .orderItems
                                    .length,
                                itemBuilder: (context, index) {
                                  final data = orderDetailsController
                                      .orderDetailsResponse.value?.orderDetails;
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: orderCard(
                                        offerPrice: data?.orderItems[index].unit
                                                .offerprice
                                                .toString() ??
                                            '.',
                                        price: data
                                                ?.orderItems[index].unit.price
                                                .toString() ??
                                            '.',
                                        onTap: () {},
                                        image: data
                                            ?.orderItems[index].product.image,
                                        productName: data?.orderItems[index]
                                                .product.name ??
                                            '.',
                                        status: data?.order.paystatus ?? '.'),
                                  );
                                }),
                          ),
                          // FloatingActionButton(
                          //     onPressed: () {},
                          //     child: Icon(
                          //       Remix.arrow_down_line,
                          //     ),
                          //     backgroundColor: AppColors.primaryDark,
                          //  ),
                          Container(
                            height: Get.height * .05,
                            child: SecondaryButton(
                                borderRadius: 10,
                                backgroundColor: AppColors.primaryDark,
                                fontColor: Colors.white,
                                fontSize: 12,
                                height: 20,
                                buttonText: 'Download invoice',
                                onTap: () {
                                  final String orderId = orderDetailsController
                                      .orderDetailsResponse
                                      .value!
                                      .orderDetails
                                      .order
                                      .id
                                      .toString();

                                  _downloadInvoice(orderId: orderId);
                                }),
                          )
                        ],
                      ),
                    );
                  }
                  return SizedBox();
                }),
              ],
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
      String? image,
      required String productName,
      required String offerPrice,
      required String price,
      required String status,
      VoidCallback? onDelete}) {
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
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightGrey),
                    borderRadius: BorderRadius.circular(10)),
                width: 72,
                height: 75,
                child: image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          AppVariables.baseUrl + image,
                          errorBuilder: (context, error, stackTrace) => Center(
                            child: Text('!'),
                          ),
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        width: 72,
                        height: 75,
                        color: AppColors.inputBackgroundColor,
                      )),
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
                        text: '₹$offerPrice',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '₹$price',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 10,
                            color: AppColors.mediumLight),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: PrimaryText(
                      text: status,
                      color: status == 'Pending'
                          ? Colors.amber
                          : status == 'Success'
                              ? Colors.green
                              : Colors.blueAccent,
                    ),
                  )
                ],
              ),
            ),
            // SecondaryButton(
            //   buttonText: 'Delete',
            //   onTap: onDelete,
            //   height: 20,
            //   width: 45,
            //   fontColor: AppColors.mediumLight,
            //   borderColor: AppColors.inputBackgroundColor,
            //   borderRadius: 7,
            //   fontSize: 10,
            // )
          ],
        ),
      ),
    );
  }
}
