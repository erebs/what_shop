import 'dart:convert';

import 'package:get/get.dart';
import 'package:what_shop/models/product_details_model.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/shared_pref_util.dart';



class ProductDetailsController extends GetxController {
  final String productId;

  ProductDetailsController({required this.productId});

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  Rx<ProductDetailsModel?> productDetailsResponse = Rx<ProductDetailsModel?>(null);


  @override
  void onInit() {
    super.onInit();
    getProductDetails(productId: productId);
  }

  Future<void> getProductDetails({productId}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final userId = await SharedPrefUtil().getUserId();
      final response = await ApiService().post(
          endPoint: 'product_details', body: {
        'product_id': productId
        ,'user_id':userId.toString()
      });
      if (response!.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData['sts'] == '01') {
          productDetailsResponse.value = ProductDetailsModel.fromJson(jsonData);
        }
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
void onClose(){

}
}