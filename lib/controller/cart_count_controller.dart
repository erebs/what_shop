import 'dart:convert';

import 'package:get/get.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/shared_pref_util.dart';

class CartCountController extends GetxController {
  void onInit() {
    super.onInit();
    _getCartCount();
  }

  RxInt cartCount = 0.obs;
  // get cart count function
   void getCartCount()=>_getCartCount();

  Future<void> _getCartCount() async {
    try {
      final userId = await SharedPrefUtil().getUserId();
      final response = await ApiService()
          .post(endPoint: 'cartcount', body: {'userid': userId.toString()});
      if (response?.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response!.body);
        if (jsonData['sts'] == '01') {
          cartCount.value = jsonData['count'];
          print(cartCount.value);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
