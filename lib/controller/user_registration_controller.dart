import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:what_shop/constants/app_variables.dart';
import 'package:what_shop/constants/error_variables.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:http/http.dart' as http;

class UserRegistrationController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isMobileVerified = false.obs;
  RxString emailStatus = ''.obs;

  void registerUser() => _registerUser();

  void verifyMobileNumber() => _verifyMobileNumber();

  // Future<dynamic> verifyEmailAddress() async {
  //   try {
  //     print('email checking');
  //     final response = await ApiService().post(
  //         endPoint: 'check/customer/email',
  //         body: {'email': emailController.text.toString()});
  //     if (response!.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       emailStatus.value = data['msg'];
  //       print(response.body);
  //       Get.snackbar('', emailStatus.value);
  //       return;
  //     }else{
  //
  //     }
  //   } catch (e) {
  //     Get.snackbar('', e.toString());
  //   }
  // }

  Future<void> _verifyMobileNumber() async {
    try {
      final response = await ApiService().post(
          endPoint: 'check/customer/number',
          body: {'number': mobileNumberController.text.toString()});
      final responseStatus = jsonDecode(response!.body)['sts'];

      if (responseStatus == '01') {

        isMobileVerified.value = true;
        return;
      }
    } catch (e) {
      Get.snackbar('', e.toString());
    }
  }

  Future<void> _registerUser() async {
    try {
      isLoading.value = true;

      //data passing in body
      final data = {
        'name': nameController.text.toString(),
        'email': emailController.text.toString(),
        'password': passwordController.text.toString(),
        'phone': mobileNumberController.text.toString(),
      };
      // checking if any of the field is empty
      if (nameController.text.isEmpty ||
          mobileNumberController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty) {
        errorMessage.value = allFieldsRequired;
        return;
      }
      // checking if mobile number is verified or not
      if (isMobileVerified.value == false) {
        errorMessage.value = mobileNumberAlreadyExist;
        return;
      }
      // if (emailStatus.value.toString() == emailDoesNotExist) {
      //   errorMessage.value = emailDoesNotExist;
      //   return;
      // } else if (emailStatus.value.toString() == emailAlreadyExist) {
      //   errorMessage.value = emailAlreadyExist;
      //   return;
      // }
      if (passwordController.text != confirmPasswordController.text) {
        errorMessage.value = passwordDoesNotMatch;
        return;
      }
      final response =
          await ApiService().post(endPoint: 'customer/register', body: data);
      final responseStatus = jsonDecode(response!.body)['sts'].toString();
      if (responseStatus == '00') {
        Future.delayed(const Duration(seconds: 1),
            () => Get.offNamed(RouteName.loginScreen));
      } else {
        Get.snackbar('', responseStatus);
      }
    } catch (e) {
      Get.snackbar('', e.toString());
    } finally {
      isLoading.value = false;
      print(errorMessage.value);
    }
  }
}
