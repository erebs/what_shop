import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/constants/appSizes.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/controller/order_details_controller.dart';
import 'package:what_shop/controller/order_history_controller.dart';
import 'package:what_shop/utils/api_state_enum.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/views/screens/common/error_page.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/secondary_custom_app_bar.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final OrderDetailsController orderDetailsController = Get.put(OrderDetailsController());
  final OrderHistoryController orderHistoryController =
      Get.put(OrderHistoryController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.inputBackgroundColor,
          appBar: SecondaryCustomAppBar(title: 'Orders'),
          body: Container(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: 20),
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  if (orderHistoryController.orderState.value ==
                      DataState.Loading) {
                    return CircularProgressIndicator();
                  }
                  if (orderHistoryController.orderState.value ==
                      DataState.Error) {
                    return ErrorScreen(errorMsg: orderHistoryController.errorMessage.value, onTap: (){
                      orderHistoryController.getOrders();
                    });
                  }
                  if (orderHistoryController.orderState.value ==
                      DataState.Empty) {
                    return Text('Empty');
                  }
                  if (orderHistoryController.orderState.value ==
                      DataState.Data) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: orderHistoryController
                              .orders?.value?.orders?.length,
                          itemBuilder: (context, index) {
                            final data = orderHistoryController
                                .orders!.value!.orders![index];
                            return orderCard(
                              onTap: (){
                                orderDetailsController.getOrderDetails(orderId: data.id.toString());
                                Get.toNamed(RouteName.orderDetailsScreen);
                              },
                                orderId: data.id,
                                amount:data.amount,
                                orderDate: data.order_on?.split(' ')[0],
                                paymentStatus: data.paystatus,
                                paymentType: data.paytype);
                          }),
                    );
                  }
                  return Text('EMpty outside');
                })
              ],
            ),
          )),
    );
  }

  Widget orderCard(
      {amount, orderId, paymentType, orderDate, paymentStatus, onTap}) {
    return TouchableOpacity(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        width: Get.width,
        height: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Remix.shopping_cart_2_line,
              size: 20,
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                      text: '#$orderId',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.fontOnWhite),
                  PrimaryText(
                    text: 'Amount : ₹ $amount',
                    color: AppColors.fontOnWhite,
                  ),
                  PrimaryText(
                    text: 'Payments Type : $paymentType',
                    color: AppColors.fontOnWhite,
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PrimaryText(
                    text: paymentStatus,
                    fontWeight: FontWeight.w500,
                    color: paymentStatus == 'Pending'
                        ? Colors.amber
                        : paymentStatus == 'Success' ?
                    Colors.green:
                            paymentStatus == 'Cancelled' ?

                                Colors.red
                            : Colors.blueAccent),
                PrimaryText(
                  text: orderDate,
                  fontSize: 9,
                  color: AppColors.mediumLight,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
