import 'dart:convert';

import 'package:get/get.dart';
import 'package:what_shop/controller/location_controller.dart';
import 'package:what_shop/models/banner_model.dart';
import 'package:what_shop/models/shop_details_by_id_model.dart';
import 'package:what_shop/utils/api_services.dart';

class ShopDetailsByIdController extends GetxController {
  final LocationController location = Get.find();

  @override
  void onInit() {
    super.onInit();
    // _getShopDetailsById();
    _getBanners();
  }

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  var shopDetails = Rx<ShopDetailsByIdModel?>(null);
  var banner = Rx<BannerList?>(null);



  // Future<void> _getShopDetailsById() async {
  //   try {
  //     isLoading.value = true;
  //     final response = await ApiService().post(
  //         endPoint: 'shophome', body: {'shopid': location.pinCode.toString()});
  //     if (response!.statusCode == 200) {
  //       final Map<String, dynamic> jsonData = jsonDecode(response.body);
  //       if (jsonData['sts'] == '01') {
  //         shopDetails.value = ShopDetailsByIdModel.fromJson(jsonData);
  //         if (shopDetails.value?.mainBanners != null) {
  //           mainBanner.value = shopDetails.value!.mainBanners;
  //         }
  //         print(shopDetails.value?.featuredProducts);
  //       }
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> _getBanners() async {
    try {
      isLoading.value = true;
      final response = await ApiService().post(
          endPoint: 'shopbanners', body: {'shopid': '15'});
      if (response!.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        print(jsonData);
        if (jsonData['sts'] == '01') {
          banner.value = BannerList.fromJson(jsonData);
          print(banner.value!.firstad);
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}


