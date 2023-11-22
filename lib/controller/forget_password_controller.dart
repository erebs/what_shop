import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_shop/controller/login_controller.dart';
import 'package:what_shop/utils/api_services.dart';


class ForgetPasswordController extends GetxController{
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  final LoginController loginController = Get.find();
  Future<void> _resetPassword()async{

    try{

      final response = await ApiService().post(endPoint:'reset-password');

    }catch(e){

      errorMessage.value = e.toString();

    }
  }

}