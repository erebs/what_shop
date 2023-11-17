import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_shop/controller/cart_count_controller.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/shared_pref_util.dart';
import 'package:what_shop/views/screens/widget/custom_snackbar.dart';

class AddToCartController extends GetxController {
  final CartCountController cartCountController = Get.find();
  RxInt selectedIndex = 0.obs;
  int? unitId ;
  String quantity = '1';
  RxBool isLoading = false.obs;
  Future<void> addToCart(
      {
      required productid,
      }) async {
    try {
      isLoading.value = true;
      final userId = await SharedPrefUtil().getUserId();
      if (userId == null || userId.isEmpty){
        return;
      }
      if(productid == null || unitId == null || quantity == null ){
        Get.snackbar('', 'Something went wrong from ');
        return;
      }
      final response = await ApiService().post(endPoint: 'addtocart', body: {
        'userid': userId.toString(),
        'productid': productid.toString(),
        'unitid': unitId.toString(),
        'quantity': quantity.toString()
      });
      print({
        'userid': userId.toString(),
        'productid': productid.toString(),
        'unitid': unitId.toString(),
        'quantity': quantity.toString()
      });
      if (response!.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        print(jsonData);
        if (jsonData['sts'] == '01') {
          cartCountController.getCartCount();
          cartCountController.cartCount.refresh();
         customSnackBar(title:'Successful',message: 'Item added to cart');
        }
      }
    } catch (e) {
      print(e.toString());
      customSnackBar(title:'Error',message: 'Something went wrong');
    }finally{
      isLoading.value = false;
    }
  }
  void updateQuantity(String newQuantity) {
    quantity = newQuantity;
    update(); // This triggers a rebuild of the widget using this controller
  }
}
