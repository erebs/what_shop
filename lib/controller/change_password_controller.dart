import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/api_state_enum.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/utils/shared_pref_util.dart';
import 'package:what_shop/views/screens/widget/custom_snackbar.dart';

class ChangePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> changePassword() async {
    if (passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      errorMessage.value = 'All fields are required';
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      errorMessage.value = 'Password does not match';
      return;
    }
    try {

      isLoading.value = true;
      final userId = await SharedPrefUtil().getUserId();
      final response = await ApiService().post(
          endPoint: 'change-password',
          body: {'user_id': userId!, 'password': passwordController.text});
      if (response?.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response!.body);
        if (jsonData['sts'] == '01') {
          Get.back();
         customSnackBar(title:'Successful',message:'Password updated successfully');
        }
      }
    } catch (e) {
      Get.snackbar('', e.toString(), colorText: AppColors.fontOnSecondary);
    } finally {
      isLoading.value = false;
      passwordController.clear();
      confirmPasswordController.clear();
    }
  }
}
