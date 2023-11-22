import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';

class NoAddressFoundScreen extends StatelessWidget {
  const NoAddressFoundScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    print(AppImages.noAddressSvg);
    return Container(
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AppImages.noAddressSvg),
          SizedBox(height: 20,),
          PrimaryText(text:'No Address Found',color: AppColors.primaryDark,fontSize: 20,fontWeight: FontWeight.w500, ),
          SizedBox(height: 8,),
          Container(
            width: Get.width/1.2,
              child: PrimaryText(text: "We noticed you haven't added an address yet. Please add one to help us serve you better",color: AppColors.mediumLight,))
        ],
      ),
    );
  }
}
