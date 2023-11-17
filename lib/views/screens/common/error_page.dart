import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/views/widgets/buttons.dart';

class ErrorScreen extends StatefulWidget {
  final String errorMsg;
  final   onTap;
  final String? buttonText;
  final String? img;
  const ErrorScreen({super.key, required this.errorMsg, required this.onTap,this.buttonText, this.img});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: Get.width,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
           SvgPicture.asset(widget.img?? AppImages.errorImg,height: Get.height/2,),
           // const SizedBox(
           //    height: 30,
           //  ),
            Text(
              '${widget.errorMsg}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.mediumLight),
            ),
            const  SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 50,
              width:Get.width/1.5,
              child: SecondaryButton(
                onTap: widget.onTap,
                buttonText:widget.buttonText ?? 'Retry',
                fontSize: 16,
                backgroundColor: AppColors.primaryDark,
                fontColor: AppColors.fontOnSecondary,
                borderRadius: 10,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      );
  }
}
