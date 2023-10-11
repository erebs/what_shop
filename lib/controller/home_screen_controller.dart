import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_shop/controller/location_controller.dart';
import 'package:what_shop/models/home_screen_model.dart';
import 'package:what_shop/models/shops_near_user_model.dart';
import 'package:what_shop/utils/api_services.dart';



class HomeScreenController extends GetxController{
  final LocationController locationController = Get.find();

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  // var shopResponse = Rx<ShopResponse?>(null);
  var shopsNearUser = Rx<ShopsNearUserData?>(null);
  var shopData = DefaultShops(sts: "",
      msg: "",
      categories: [], // example data
      newshops: [] ,
  firstad: [],
  secondad: []).obs;

  @override
  void onInit(){
    super.onInit();
    initializeData();

  }

  Future<void> initializeData() async {
    await locationController.getLocationPermission(context: Get.context);
    if(locationController.isLocationGranted.value){
      _getHomePinCodeData();

    }else{
      _getHomeScreenData();

    }
   return;
  }

  Future<void> _getHomeScreenData()async{
    try{
      isLoading.value = true;
      print('starting function call');
      final response = await ApiService().get('home');
      if (response!.statusCode == 200) {
        print('home controller function call successful');
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData['sts'] == '01') {
          shopData.value = DefaultShops.fromJson(jsonData);
          print('home shops ${shopData.value}');
          return;
        }
      }
    } catch(e) {
      errorMessage.value = e.toString();
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }



  // this function is to get data near the user using pin code
  Future<void> _getHomePinCodeData() async{
    try{
      isLoading.value = true;
      final response = await ApiService().post(endPoint: 'shoplist',body: {
        'pincode':'686507'
      });
      if (response?.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response!.body);
        if (jsonData['sts'] == '01') {
shopsNearUser.value = ShopsNearUserData.fromJson(jsonData);
print(shopsNearUser.value?.firstad);
        }
      }
    }catch(e){
      errorMessage.value = e.toString();

    }finally{
      isLoading.value = false;
    }
  }

}