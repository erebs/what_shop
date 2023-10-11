import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_shop/models/all_shops_model.dart';
import 'package:what_shop/models/home_screen_model.dart';
import 'package:what_shop/utils/api_services.dart';



class AllShopsController extends GetxController{
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  var allShops = Rx<AllShopResponse?>(null);


  @override
  void onInit(){
    super.onInit();
    _getAllShopsData();
  }



  Future<void> _getAllShopsData()async{
    try{
      isLoading.value=true;

      final response = await ApiService().get('all-shops');
      if (response!.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData['sts'] == '01') {
          allShops.value = AllShopResponse.fromJson(jsonData);
          print(allShops.value?.shops[1].name);
        }
      }
    }catch(e){
      errorMessage.value = e.toString();

    }finally{
      isLoading.value = false;
    }
  }
  void reloadAllShops(){
    errorMessage.value = '';
    _getAllShopsData();
  }
}
