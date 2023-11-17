import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_shop/controller/location_controller.dart';
import 'package:what_shop/models/home_screen_model.dart';
import 'package:what_shop/models/shops_near_user_model.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/api_state_enum.dart';
import 'package:what_shop/utils/shared_pref_util.dart';

class HomeScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  var shopsFromPinCodeState = DataState.Loading.obs;
  var allShopsState = DataState.Loading.obs;
  var shopsNearUser = Rx<ShopsNearUserData?>(null);
  RxBool isLocationGranted = false.obs;
  var shopData = DefaultShops(
    sts: "",
    msg: "",
    categories: [],
    newshops: [],
    firstad: [],
    secondad: [],
  ).obs;
  final RxMap<dynamic, dynamic> userDetails = {}.obs;

  Future<void> getUserData() async {
    Map<String, String?> fetchedData = await SharedPrefUtil().getUserData();
    userDetails.value = fetchedData;
    print(userDetails);
  }

  Future<void> getAllShops() async {
    try {
      isLoading.value = true;
      print('Starting function call');

      final response = await ApiService().get('home');
      if (response == null) {
        return;
      }
      if (response.statusCode == 200) {
        print('Home controller function call successful');
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData['sts'] == '01') {
          shopData.value = DefaultShops.fromJson(jsonData);
          print(shopData.value.firstad);
          shopData.value.categories!
                      .every((category) => category.shops!.isEmpty) ==
                  true
              ? DataState.Empty
              : DataState.Data;
        } else {
          allShopsState.value = DataState.Error;
        }
      }
    } catch (e) {
      allShopsState.value = DataState.Error;
      errorMessage.value = e.toString();
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // This function is to get data near the user using a pin code
  Future<void> getShopsFromPincode({pincode}) async {
    print(pincode);
    try {
      isLoading.value = true;
      if (pincode == '') {

        getAllShops();
      }
      isLocationGranted.value = true;
      final response = await ApiService().post(
        endPoint: 'shoplist',
        body: {'pincode': pincode},
      );
      if (response == null) {
        return;
      }
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData['sts'] == '01') {
          shopsNearUser.value = ShopsNearUserData.fromJson(jsonData);
          shopsFromPinCodeState.value = shopsNearUser.value?.categories
                      .every((category) => category.shops.isEmpty) ==
                  true
              ? DataState.Empty
              : DataState.Data;
          print(' FROM HOME SCREEN CONTROLLER${shopsNearUser.value?.firstad}');
        } else {
          shopsFromPinCodeState.value = DataState.Error;
          print(jsonData);
        }
      }
    } catch (e) {
      shopsFromPinCodeState.value = DataState.Error;
      errorMessage.value= e.toString();
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
