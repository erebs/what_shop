import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/widgets/buttons.dart';


class PlaceOrderSuccessScreen extends StatelessWidget {
  const PlaceOrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:WillPopScope(
        onWillPop:()async{
          return false;
        },
        child:
       Container(
        height: Get.height,
        width: Get.width,

        child: Column(
mainAxisAlignment: MainAxisAlignment.center,
          children: [
SvgPicture.asset(AppImages.placeOrderSuccess,height: Get.height/5,),
            SizedBox(height:30,),

PrimaryText(text: 'Order Placed Successfully', fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.mediumLight),
SizedBox(height: 70,),
Container(
  height: 50,
  width: Get.width/1.4,
  child: SecondaryButton(
    borderRadius: 10,
    backgroundColor: AppColors.primaryDark,
    onTap: (){
      Get.offAllNamed(RouteName.homeScreen);
    },
    buttonText: 'Continue Shopping',
    fontColor: AppColors.fontOnSecondary,
    fontSize: 14,
  ),
),
            Container(

            )
          ],
        ),
      ),
      )
    );

  }
}
