import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/controller/user_data_controller.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/utils/shared_pref_util.dart';
import 'package:what_shop/views/screens/widget/custom_snackbar.dart';

class EditProfileController extends GetxController{
  RxBool isLoading = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final UserDataController userDataController = Get.find();

  Future<void> editUserProfile() async{

    try{
      isLoading.value = true;
      final userId = await SharedPrefUtil().getUserId();
      final response = await ApiService().post(endPoint: 'edit-profile',body: {
        'user_id':userId.toString(),
        'name':nameController.text,
        'email':emailController.text
      });
      if (userId == null || userId.isEmpty) {
        return;
      }
      if ( response?.statusCode == 200 ){
        Map<String,dynamic> jsonData= jsonDecode(response!.body);
        if(jsonData['sts'] == '01'){
          await userDataController.getUserData();
          Future.delayed(const Duration(seconds: 1),()=>isLoading.value = false);
          Get.back();
          customSnackBar(title:'Successful',message:'Profile updated successfully');
        }else{
          print(jsonData);
          Future.delayed(const Duration(seconds: 1),()=>isLoading.value = false,);
          Get.snackbar('Error', 'Something went wrong',colorText:AppColors.fontOnSecondary);
        }
      }
    }catch(e){
      print(e.toString());

    }

  }


}