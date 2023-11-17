import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_shop/controller/user_data_controller.dart';
import 'package:what_shop/models/user_details_model.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/utils/shared_pref_util.dart';

class LoginController extends GetxController {
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  UserResponse? userData;

  void loginUser() => _loginUser();

  Future<void> _loginUser() async {
    try {
      if (mobileNumberController.text.isEmpty ||
          passwordController.text.isEmpty) {
        errorMessage.value = 'All fields required';
        return;
      }
      isLoading.value = true;
      final response =
          await ApiService().post(endPoint: 'customer/login', body: {
        'emailormobile': mobileNumberController.text,
        'password': passwordController.text
      });
      if (response!.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData['sts'] == '01') {
          UserResponse userData = UserResponse.fromJson(jsonData);
          await SharedPrefUtil().setUserData(id: userData.user.id.toString(),name: userData.user.name,phone: userData.user.phone,email:userData.user.email);
          Get.offAllNamed(RouteName.homeScreen);
        }
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
