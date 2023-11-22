import 'dart:convert';

import 'package:get/get.dart';
import 'package:what_shop/models/shop_information_model.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/shared_pref_util.dart';

class ShopInformationController extends GetxController {
  ShopInformationController();

  Rx<ShopInformationResponse?> shopInformation =
      Rx<ShopInformationResponse?>(null);

  void onInit() {
    super.onInit();
    getShopInformation();
  }

  Future<void> getShopInformation() async {
    try {
      final String? shopId = await SharedPrefUtil().getShopId();
      final String? userId = await SharedPrefUtil().getUserId();
      print('shop id from shopinfo:$shopId');
      final response = await ApiService().post(endPoint: 'shopdetails', body: {
        'shopid': shopId!,
        'userid':userId.toString()
      });

      if (response == null) {
        return;
      }
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);

        shopInformation.value = ShopInformationResponse.fromJson(jsonData);
        print(' shop info ${shopInformation.value!.isFavourite}');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
