import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_shop/constants/app_colors.dart';




SnackbarController customSnackBar({ String? title,required String message}) {
  return  Get.snackbar(title ?? 'Message', message,
      colorText: AppColors.inputBackgroundColor,
      backgroundColor: AppColors.primaryDark.withOpacity(.7),
      borderRadius: 5);
}


 customBottomSnakbar({required BuildContext context,required String text}){
   final snackdemo = SnackBar(
     content: Text(text),
     duration: Duration(milliseconds: 1000),
     backgroundColor: AppColors.primaryDark.withOpacity(.7),
   );
   return Future.delayed(Duration(milliseconds:500),()=>ScaffoldMessenger.of(context).showSnackBar(snackdemo)
   ) ;}